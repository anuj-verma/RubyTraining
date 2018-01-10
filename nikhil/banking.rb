require 'date'

user_info = {user101: {name: "Nikhil Pathak", password: "user101", balance: 0.0, 
			city: "Dhule", transaction_history: []} , 
			user102: {name: "Saransh Khandelwal" , password: "user102", balance: 0.0, 
			city: "Agra", transaction_history: []}}

def string_input(display_string)
	puts display_string
	gets.chop
end

def float_input(display_string)
	puts display_string
	gets.chop.to_f
end

def user_exist(user_info, account_number)
	user_info[account_number.to_sym].nil? == true ? 0 : account_number
end

def user_authentication(user_info, account_number, password)
	user_info[account_number.to_sym][:password] == password ? 1 : 0
end

def operations_details()

	puts '1. Withdrawal'
	puts '2. Deposit'
	puts '3. Transfer Money'
	puts '4. Transaction History' 
	puts '5. Logout'
	puts '6. Exit'
	gets.chop
end

def add_transaction_history(user_info, account_number, type, amount, date)

	user_info[account_number.to_sym][:transaction_history] << {
		'type' => type,
		'account_number' => account_number,
		'amount' => amount,
		'current_balance' => user_info[account_number.to_sym][:balance],
		'date' => date
	}
end

def withdraw(user_info, account_number, amount, date)

	if user_info[account_number.to_sym][:balance] - amount >= 500.0
		user_info[account_number.to_sym][:balance] -= amount
		add_transaction_history(user_info, account_number, 'Withdraw', amount, date)
		puts 'Successfully Amount Withdraw'
	else
		puts 'Insufficient Balance'
	end	
end

def deposit(user_info, account_number, amount, date)

	user_info[account_number.to_sym][:balance] += amount
	add_transaction_history(user_info, account_number, 'Deposit', amount, date)
	puts 'Successfully Amount Deposited'
end

def transfer(user_info, account_number, reciever_account_number, amount, date)

	if user_info[reciever_account_number.to_sym].nil? == false 
	
		return puts 'Sender and Reciever Accounts are Same!'	if reciever_account_number == account_number
		if user_info[account_number.to_sym][:balance] - amount >= 500.0

			user_info[account_number.to_sym][:balance] -= amount
			user_info[reciever_account_number.to_sym][:balance] += amount
			add_transaction_history(user_info, account_number, 'Transfer', amount, date)
			puts 'Successfully Transfered Amount'
		else
			puts 'Insufficient Balance to Transfer!'
		end
	else
		puts 'Reciever Account Does Not Exist!'
	end
end

def validate_input_amount(input_amount)

	while input_amount <= 0.0
		puts 'Enter Valid Withdrawal Amount'
		input_amount = gets.chop.to_f
	end	
	input_amount
end

def validate_string_input(input_string, validation_field)

	while input_string.class == 'Fixnum' or input_string.class == 'Float' or input_string.length == 0 or input_string.strip.length == 0
		puts "Enter your Valid #{validation_field}"
		input_string = gets.chop
	end
	input_string
end

def user_registeration(user_info)

	account_number = 'user'+$user_number.to_s
	puts 'Please Register before banking'
	new_user = {}

	puts 'Enter your Name'
	new_user[:name] = gets.chop
	new_user[:name] = validate_string_input(new_user[:name], "Name")

	puts 'Enter Password'
	new_user[:password] = gets.chop
	new_user[:password] = validate_string_input(new_user[:balance], "Password")

	puts 'Enter Initial Balance'
	new_user[:balance] = gets.chop.to_f
	new_user[:balance] = validate_string_input(new_user[:balance], "Initial Balance")

	puts 'Enter City'
	new_user[:city] = gets.chop
	new_user[:city] = validate_string_input(new_user[:city], "City")

	new_user[:transaction_history] = []
	user_info[account_number.to_sym] = new_user
	$user_number += 1
	puts "Your Account Number is #{account_number}"
	account_number
end

def display_transaction_history(user_info, account_number, start_date, end_date)

	for transaction in user_info[account_number.to_sym][:transaction_history]		
		if transaction['date'] >= start_date and transaction['date'] <= end_date
			print "Type: ",transaction['type']
			puts ' '
			print "Account Number: ",transaction['account_number']
			puts ' '
			print "Amount: ",transaction['amount']
			puts ' '
			print "Current Balance: ",transaction['current_balance']
			puts ' '
			print "Date of Transaction: ",transaction['date']
			puts ' '
		end
	end
end

$user_number = 103
incorrect_password_flg = 0

while 1

	if incorrect_password_flg == 0
		account_number = string_input('Enter your Account Number')
		account_number = validate_string_input(account_number, "Account Number")
	
		account_number = user_exist(user_info, account_number)
		while account_number == 0
		  account_number = user_registeration(user_info)
		 	account_number = user_exist(user_info, account_number)
		end
	end

	password = string_input('Enter Your Password')
	password = validate_string_input(password, "Password")
	if user_authentication(user_info, account_number, password) == 1	
		while 1	
			option = operations_details().to_i
			if option != 4 and option != 5 and option != 6
				current_time = DateTime.now 
				current_time = current_time.strftime("%d/%m/%Y %H:%M")
				current_time = Date.parse(current_time)
			end
			case option
				when 1
					amount = float_input('Enter Withdrawal Amount')
					amount = validate_input_amount(amount) 
					withdraw(user_info, account_number, amount, current_time)

				when 2
					amount = float_input('Enter Deposit Amount')
					amount = validate_input_amount(amount)
					deposit(user_info, account_number, amount, current_time)

				when 3
					reciever_account_number = float_input('Enter another user account number to transfer money')
					reciever_account_number = validate_string_input(reciever_account_number, "Amount to Transfer")
					amount = float_input('Enter Amount to Transfer')
					amount = validate_input_amount(amount)
					transfer(user_info, account_number, reciever_account_number, amount, current_time)
			
				when 4
					start_date = string_input('Enter Start Date')
					start_date += '00:00'
					start_date = Date.parse(start_date)
					end_date = string_input('Enter End Date')
					end_start += '00:00'
					end_date = Date.parse(end_date)
					display_transaction_history(user_info, account_number, start_date, end_date)

				when 5
					incorrect_password_flg = 0
					break

				when 6
					exit_banking_operations = true
					break
			end
		end
		break if exit_banking_operations == true
	else
		puts 'Incorrect Password'
		incorrect_password_flg = 1
	end
end