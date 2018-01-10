require 'date'

account_number = "10001"
user_data = {}
initial_record = {account_number: account_number , username: "Harish" , password: "hsp" , balance: 5000}
user_data[account_number] = initial_record
transaction_record = []

=begin
account_number = account_number.to_i
account_number+=1
initial_record = {account_number: account_number , username: "Aditya" , password: "ask" , balance: 4000}
=end

puts user_data

def add_transaction_history(transaction_name , transaction_record , amount)
	d = DateTime.now
	current_date_time = d.strftime("%d/%m/%Y %H:%M")
	transaction_record.push("Rs "+"#{amount}"+" "+transaction_name+" "+current_date_time)
end

def view_transaction_history(transaction_record)
	print "Amount\tTransaction   date time\n"
	for record in transaction_record
		puts record
	end
end

def view_transaction_between(transaction_record)
	print "\nEnter Start Date :(dd/mm/yyyy) :"
	start_date = gets.chomp
	print "\nEnter End Date :(dd/mm/yyyy) :"
	end_date = gets.chomp
	i=0
	for record in transaction_record
		split_records = record.split(" ")
		#if (Date.parse(start_date) <= Date.parse(split_records[3]) && Date.parse(end_date) >= Date.parse(split_records[3]))
		if Date.parse(split_records[3]).between?(Date.parse(start_date),Date.parse(end_date))
			puts record
			i = 1 
		end
	end
	if i == 0
		puts '...Record not found...'
	end
end

def create_new_user(user_data , account_number , transaction_record)
	print 'Enter Username :'
	new_username = gets.chomp
	print 'Enter Password :'
	new_password = gets.chomp
	print 'Enter opening balance :'
	initial_balance = gets.chomp.to_i
	account_number = account_number.to_s
	puts "Account number of new Account :#{account_number}"
	new_record = {account_number: account_number , username: new_username , password: new_password , balance: initial_balance}
	user_data[account_number] = new_record
	puts user_data
	print "\nNew Account created\n"
	banking_menu user_data , account_number , transaction_record
end

def print_account_details(user_data , account_number)
	print "\nAccount Number :#{user_data[account_number][:account_number]}\n"
	print "Username :#{user_data[account_number][:username]}\n"
	print "Balance :#{user_data[account_number][:balance]}\n"
end

def deposit_amount(user_data , account_number_deposit , transaction_record)
	if account_number_deposit == user_data[account_number_deposit][:account_number]
		print 'Enter amount to deposit :'
		STDOUT.flush
		deposit_amount = gets.chomp.to_i
		user_data[account_number_deposit][:balance] = user_data[account_number_deposit][:balance] + deposit_amount
		print "\nAmount deposited sucessfully...\nCurrent balance is Rs :#{user_data[account_number_deposit][:balance]}\n"
		add_transaction_history 'Deposit' , transaction_record , deposit_amount
	else
		print "\nAccount number not found\n"
	end
end

def withdraw_amount(user_data , account_number_withdraw , transaction_record)
	if account_number_withdraw == user_data[account_number_withdraw][:account_number]
		print "\nEnter amount to withdraw :"
		STDOUT.flush
		withdraw_amount = gets.chomp.to_i
		if (user_data[account_number_withdraw][:balance] - withdraw_amount) > 0
			user_data[account_number_withdraw][:balance] = user_data[account_number_withdraw][:balance] - withdraw_amount
			print "\nAmount withdraw sucessfully...\nBalance is Rs :#{user_data[account_number_withdraw][:balance]}\n"
			add_transaction_history 'Withdraw' , transaction_record , withdraw_amount.to_s
		else
			print "\n\n...Cannot withdraw amount balance going to Rs 0.0...\n\n"
		end
	else
		print "\nAccount number not found\n"
	end
end

def transfer_amount(user_data , source_account_number , transaction_record)
	if source_account_number == user_data[source_account_number][:account_number]
		print 'Enter account number to transfer :'
		destination_account_number = gets.chomp
		print 'Enter amount to transfer :'
		transfer_amount = gets.chomp.to_i
		if (user_data[source_account_number][:balance] - transfer_amount) > 0
			user_data[source_account_number][:balance] = temp_balance_val  = user_data[source_account_number][:balance] - transfer_amount
			user_data[destination_account_number][:balance] = user_data[destination_account_number][:balance] + transfer_amount
			print "\nTransfer sucessfully...\n"
			add_transaction_history 'Transfer' , transaction_record , transfer_amount.to_s
			puts user_data
		else
			print "\n\n...Insufficient Balance to transfer money...\n\n"
		end
	else
		print "\nAccount number not found\n"
	end
end

def banking_menu(user_data , temp_account_number , transaction_record)
	loop do
		print "\n1. Deposit\n2. Withdraw\n3. Transfer\n4. Display Account Details\n5. View Transaction History\n6. View Transactions between date\n7. Logout\n8. Exit\n\nEnter option :"
		option = gets.chomp
			case option.to_s
			when '1'
				deposit_amount user_data , temp_account_number , transaction_record

			when '2'
				withdraw_amount user_data , temp_account_number , transaction_record

			when '3'
				transfer_amount user_data , temp_account_number , transaction_record

			when '4'
				print_account_details user_data , temp_account_number
			when '5'
				view_transaction_history transaction_record
			when '6'
				view_transaction_between transaction_record
			when '7'
				login user_data , transaction_record
			else
				exit(true)
			end
	end
end

def login(user_data , transaction_record)
	flag = 0
	i = 0
	temp = 10001
	while i < user_data.length do
		print "\nLogin"
		print "\nEnter Username :"
		username_input = gets.chomp
		print "\nEnter Password :"
		password_input = gets.chomp
		if ((user_data[temp.to_s][:username] == username_input) && (user_data[temp.to_s][:password] == password_input))
				temp_account_number = user_data[temp.to_s][:account_number]
				banking_menu user_data , temp_account_number , transaction_record
				flag = 1
		end
		i += 1
		temp += 1
	end
	if flag == 0
		puts "\nRegister as new user...\n"
		create_new_user user_data , temp.to_s , transaction_record
	end
end
login user_data , transaction_record
