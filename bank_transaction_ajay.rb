$userinfo = Hash.new
$key="1"
$initial_account_number=100

def menu_transaction(login_id,transaction_details)
	puts "\n\n1.Deposit\n2.Withdraw\n3.Transfer Money\n4.Transaction Details\n5.Log out"
	choise = gets
	case choise.to_i
		when 1
			deposit(login_id,transaction_details)
		when 2
			withdraw(login_id,transaction_details)
		when 3
			transfer(login_id,transaction_details)
		when 4
			#transaction(login_id,transaction_details)
			puts "1.All Transaction\n2.Trasaction(Based On Date)\n3.Back"
			transaction_choise = gets.chomp
			case transaction_choise.to_i
			when 1
				transaction(login_id,transaction_details)
			when 2
				transaction_on_date(login_id,transaction_details)
			when 3
				menu_transaction(login_id,transaction_details)
		end
	end
end

def transaction_on_date(login_id,transaction_details)
	puts "Enter date(dd/mm/yy) and time(hh:mm:ss)"
	user_date = gets
	user_hash = $userinfo[login_id]
	transactions = user_hash[:transaction]
	for index in transactions
		puts "index:#{index}"
		split_transaction = index.split("		")
		puts "split:#{split_transaction}"
		if user_date.to_s == split_transaction[4]
			#puts split_transaction
			puts 'equal'
		end
	end

end

def transaction(login_id,transaction_details)
	user_hash = $userinfo[login_id]
	transactions = user_hash[:transaction]
	puts "-------------------------------------------------------------------------------------------"
	puts "LoginId\t\tType\t\tCurrent Amount\t\tFinal Amount\t\tDate"
	transactions.each{|trans_detail| print "#{trans_detail}\n"}
	puts"--------------------------------------------------------------------------------------------"
	menu_transaction(login_id,transaction_details)
end

def calculate_amount(account_type,current_amount,final_amount)
	puts "c:#{current_amount}"
	if account_type == 'Deposit'
		current_amount = current_amount - final_amount
	else
		current_amount = current_amount + final_amount
	end
end

def add_transaction_details(transaction_details,login_id,account_type,current_amount,final_amount,date)
	user_hash = $userinfo[login_id]
	current_amount = calculate_amount(account_type , current_amount , final_amount)
	transaction_details.push(login_id.to_s + "		" + account_type + "		" +current_amount.to_s + "		" + final_amount.to_s + "		" + date.to_s)
	user_hash[:transaction] = transaction_details
end

def transfer(user_login_id,transaction_details)	
	current_time=Time.new
	puts "Receiver login ID :"
	receiver_login_id = gets.chomp
    user_hash = $userinfo[user_login_id]
	receiver_hash = $userinfo[receiver_login_id]
	if receiver_hash == nil
		puts 'Account number not found'
		menu_transaction(user_login_id,transaction_details)
	end
	puts "Enter the amount to transfer:"
	amount = gets.chomp	
	if amount.to_i > user_hash[:balance]
		puts "Insufficient balance"
		menu_transaction(user_login_id,transaction_details)	
	else
		user_hash[:balance] = user_hash[:balance] - amount.to_i
	end
	receiver_hash[:balance] = receiver_hash[:balance] + amount.to_i
	puts "Your balance is: #{user_hash[:balance]}"
	add_transaction_details(transaction_details,user_login_id,'Transfer',amount.to_i,user_hash[:balance],current_time)
	menu_transaction(user_login_id,transaction_details)
end
def common_transaction(login_id , transaction_list , transaction_info)
 	current_date_time = Time.now
 	temp_hash = $userinfo[login_id]
	puts "Enter the amount"
	amount = gets
	yield(amount,temp_hash|:balance|)

end

def deposit(login_id , transaction_list , transaction_info)
 	common_trasaction(login_id , transaction_list , transaction_info) do|amount , balance|
	balance = balance + amount.to_i
	#puts "Final amount:#{balance}"
	add_transaction_list(transaction_list,transaction_info,login_id,'Deposit',amount.to_i,temp_hash[:balance],current_date_time)
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
	common_trasaction(login_id , transaction_list , transaction_info) do|amount , balance|
	if amount.to_i < balance 
		 balance = balance-amount.to_i 
	else
		 puts 'Insufficient balance'
		 transaction_menu(login_id , transaction_list , transaction_info)
	end
	#puts "Final amount:#{balance}"
	add_transaction_list(transaction_list ,transaction_info , login_id , 'withdraw', amount.to_i , temp_hash[:balance] , current_date_time)
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
	login_id=0
	puts "Enter the login Id:"
	login_id=gets.chomp
	if ($userinfo.include?(login_id))
		print_line
		puts "login succesfull...\n"
		print_line
		puts "\n\n1.Debit\n2.Withdrowl\n3.Transfer Money\n4.Transaction Details\n5.Log out"
		transaction_details = Array.new
		getinput = gets
		case getinput.to_i
			when 1
					deposit(login_id,transaction_details)
			when 2
					withdraw(login_id,transaction_details)
			when 3
					transfer(login_id,transaction_details)
			when 4
					transaction(login_id,transaction_details)
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
  temp = $userinfo[$key]  
	$key = $key + 1.to_s
	check_exit_user
end


def check_exit_user
	puts "1.New Register \n2.Login"

	check_no = gets

	case check_no.to_i
		when 1
				registration
		when 2
			login_check
	end	 	
end

check_exit_user

