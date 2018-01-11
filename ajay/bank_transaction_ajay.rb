#transaction_info=[{},{},{}]
#user_info ={key={},key=>{}}
require 'time'
$userinfo = Hash.new
$key="1"
$initial_account_number=100

def transaction_menu(login_id,transaction_list,transaction_info)
	puts "\n\n1.Deposit\n2.Withdraw\n3.Transfer Money\n4.Transaction Details\n5.Log out"
	choise = gets
	case choise.to_i
		when 1
			deposit(login_id,transaction_list,transaction_info)
		when 2
			withdraw(login_id,transaction_list,transaction_info)
		when 3
			transfer(login_id,transaction_list,transaction_info)
		when 4
			puts "\n\n"
			puts "1.All Transaction\n2.Trasaction(Based On Date)\n3.Back"
			transaction_choise = gets.chomp
			puts "\n\n"
			case transaction_choise.to_i
			when 1
				transaction(login_id,transaction_list,transaction_info)
			when 2
				transaction_history(login_id,transaction_list,transaction_info)
			when 3
				transaction_menu(login_id,transaction_list,transaction_info)
			end
		when 5
			check_exits_user
	end
end

def transaction_history(login_id , transaction_list , transaction_info)
	puts "Enter start date"
	start_date = gets
	puts "Enter end date"
	end_date = gets
	start_date = Time.parse(start_date)
	end_date = Time.parse(end_date)
	#puts "strat date:#{start_date}"
	#puts "end date:#{end_date}"
	user_hash = $userinfo[login_id]
	transactions = user_hash[:transaction]

	transactions.each do |element|
		#puts"Element:#{element[:date]}"
		if element[:date].to_i >= start_date.to_i && element[:date].to_i <= end_date.to_i
			element.each do |key , value|
				print "#{value}\t"
			end
		end
	end
	puts"\n\n"
	print_line
	transaction_menu(login_id,transaction_list,transaction_info)
end

def transaction(login_id,transaction_list,transaction_info)
	user_hash = $userinfo[login_id]
	transactions = user_hash[:transaction]
	puts "-------------------------------------------------------------------------------------------"
	puts "LoginId\tType\tFinal Amount\tDate"
	transactions.each do |element|
		element.each do |key , value|
			print "#{value}\t"
		end
		puts "\n"
	end
	puts"--------------------------------------------------------------------------------------------"
	transaction_menu(login_id,transaction_list,transaction_info)
end

=begin
def calculate_amount(account_type,current_amount,final_amount)
	puts "c:#{current_amount}"
	puts "F:#{final_amount}"
	if account_type == 'Deposit'
		current_amount = current_amount - final_amount
	else
		current_amount = current_amount + final_amount
	end
=end

def add_transaction_list(transaction_list,transaction_info,login_id,account_type,current_amount,final_amount,date)
	transaction_list = Hash.new
	user_hash = $userinfo[login_id]
	#current_amount = calculate_amount(account_type , current_amount , final_amount)
	transaction_list[:loginid] = login_id
	transaction_list[:type] = account_type
	#transaction_list[:currentamount] = current_amount
	transaction_list[:finalamount] = final_amount
	transaction_list[:date] = date
	transaction_info.push(transaction_list)
	user_hash[:transaction] = transaction_info

end

def transfer(user_login_id , transaction_list , transaction_info)	
	current_date_time = Time.now
	puts "Receiver login ID :"
	receiver_login_id = gets.chomp
    user_hash = $userinfo[user_login_id]
	receiver_hash = $userinfo[receiver_login_id]
	if receiver_hash == nil
		puts 'Account number not found'
		transaction_menu(user_login_id,transaction_list)
	end
	puts "Enter the amount to transfer:"
	amount = gets.chomp	
	if amount.to_i > user_hash[:balance]
		puts "Insufficient balance"
		transaction_menu(user_login_id,transaction_list)	
	else
		user_hash[:balance] = user_hash[:balance] - amount.to_i
	end
	receiver_hash[:balance] = receiver_hash[:balance] + amount.to_i
	puts "Your balance is: #{user_hash[:balance]}"
	add_transaction_list(transaction_list,transaction_info,user_login_id,'Transfer',amount.to_i,user_hash[:balance],current_date_time)
	transaction_menu(user_login_id,transaction_list,transaction_info)
end

def common_trasaction(login_id , transaction_list , transaction_info)
	current_date_time = Time.now
 	user_hash = $userinfo[login_id]
	puts "Enter the amount"
	amount = gets

	user_hash[:balance] = yield(amount,user_hash[:balance],current_date_time)
	puts "Final amount:#{user_hash[:balance]}"
	#add_transaction_list(transaction_list,transaction_info,login_id,'Deposit',amount.to_i,user_hash[:balance],current_date_time)
	transaction_menu(login_id,transaction_list,transaction_info)


end

def deposit(login_id , transaction_list , transaction_info)
 	common_trasaction(login_id , transaction_list , transaction_info) do|amount , balance , current_date_time|
	balance = balance + amount.to_i
	#puts "Final amount:#{balance}"
	add_transaction_list(transaction_list,transaction_info,login_id,'Deposit',amount.to_i,balance,current_date_time)
	balance
	end
 end
=begin	
 	current_date_time = Time.now
 	temp_hash = $userinfo[login_id]
	puts "Enter the amount"
	amount = gets
	temp_hash[:balance] = temp_hash[:balance] + amount.to_i
	puts "Final amount:#{temp_hash[:balance]}"
	add_transaction_list(transaction_list,transaction_info,login_id,'Deposit',amount.to_i,temp_hash[:balance],current_date_time)
	transaction_menu(login_id,transaction_list,transaction_info)

=end

def withdraw(login_id , transaction_list , transaction_info)
	common_trasaction(login_id , transaction_list , transaction_info) do|amount , balance ,current_date_time|
	if amount.to_i < balance 
		 balance = balance-amount.to_i 
	else
		 puts 'Insufficient balance'
		 transaction_menu(login_id , transaction_list , transaction_info)
	end
	#puts "Final amount:#{balance}"
	add_transaction_list(transaction_list ,transaction_info , login_id , 'withdraw', amount.to_i , balance , current_date_time)
	balance
	end
end
=begin	current_date_time = Time.now
	temp_hash = $userinfo[login_id]
	puts "Enter the amount"
	amount = gets
	if amount.to_i < temp_hash[:balance] 
		 temp_hash[:balance] = temp_hash[:balance]-amount.to_i 
	else
		 puts 'Insufficient balance'
		 transaction_menu(login_id,transaction_list)
	end
	puts "Final amount:#{temp_hash[:balance]}"
	add_transaction_list(transaction_list ,transaction_info , login_id , 'withdraw', amount.to_i , temp_hash[:balance] , current_date_time)
	transaction_menu(login_id,transaction_list,transaction_info)
=end

def login_check	
	login_id = 0
	puts "Enter the login Id:"
	login_id = gets.chomp
	if ($userinfo.include?(login_id))
		print_line
		puts "login succesfull...\n"
		print_line
		puts "\n\n1.Debit\n2.Withdrowl\n3.Transfer Money\n4.Transaction Details\n5.Log out"
		transaction_list = Hash.new
		transaction_info=Array.new
		getinput = gets
		case getinput.to_i
			when 1
					deposit(login_id,transaction_list,transaction_info)
			when 2
					withdraw(login_id,transaction_list,transaction_info)
			when 3
					transfer(login_id,transaction_list,transaction_info)
			when 4
					transaction(login_id,transaction_list,transaction_info)
		end
	else
		puts "login fail"
	end		
end

def print_line
	puts"---------------------------------------------------------------------"
end

def registration

	userinfo = Hash.new
	puts "Enter the user name"
	username = gets.chomp

	puts "Enter the password"
	password = gets.chomp

	userinfo[:name] = username
	userinfo[:userpassword] = password
	userinfo[:accountnumber] = $initial_account_number
	userinfo[:balance] = 0
	print_line
	puts "Your login id is:#{$key}"
	puts "your account no is:#{userinfo[:accountnumber]}"
	print_line
  
	$initial_account_number = $initial_account_number+1; 	
	$userinfo[$key] = userinfo
	$key = $key + 1.to_s
	check_exit_user
end


def check_exits_user
	puts "1.New Register \n2.Login"

	check_no = gets

	case check_no.to_i
		when 1
				registration
		when 2
			login_check
	end	 	
end

check_exits_user

