#bank program (Before: 167 lines)

#TODO:
	#BUG: enetering non-numeric data where numeric input is expected doesn't raise an error
	#transaction not stored for the receiver

require "time"
#each user is stored as a hash e.g. #user = {balance: 765, password: "asda"}
#every such user hashes are stored in a hash called users_list
users_list = {}					#no user exists in the beginning

#HOW TRANSACTIONS ARE STORED
	#transactions_all = {user_id1: [{}, {}, {}], user_id1: [{}, {}, {}]}
	#transactions_user = [{}, {}, {}]
	#transaction = {type: 'deposit', amount: 100, transfer_user_id = 2, balance: 1000, time: Time.now}
transactions_all = {}

#made global to conveniently check if a user is logged in or not
$logged_in_user_id = false		#false if user not logged in


#saves to the hash 'users_list' and returns the newly created user_id
def register(users_list, transactions_all, password)
	#new user_id is generated using the lenght of the hash 'users_list'
	#a different approach should be used to generate user_id if the function to delete a user is implemented

	new_user_id = users_list.length + 1
	new_user = {balance: 0, password: password}
	users_list[new_user_id] = new_user

	transactions_all[new_user_id] = []

	$logged_in_user_id = new_user_id
	puts "Registration successful. Your ID is #{$logged_in_user_id}."

	new_user_id
end

def register_caller(users_list, transactions_all, user_id)
	puts "\nUser #{user_id} is not registered.\nWould you like to register?(y/n)"
	if gets.chomp.eql? 'y'
		puts 'Enter your new password: '
		$logged_in_user_id = register(users_list, transactions_all, gets.chomp)
		true
	else
		false 	#user doesn't want to register
	end
end

def login
	puts 'Enter your password: '
	if gets.to_s.chomp == users_list[user_id][:password]
		$logged_in_user_id = user_id
		puts "User #{user_id} logged in."
		true
	else
		puts 'Wrong password'
		false
	end	
end


def login_caller(users_list, transactions_all, user_id)
	#if user does exist
	if users_list[user_id]
		login(users_list, transactions_all, user_id)

	#if user doesn't exist
	else
		register_caller(users_list, transactions_all, user_id)
	end
end

def input_amount
	puts 'Enter amount: '
	while true
		amount = gets.to_i
		return amount if amount > 0
		puts "Negaive amount cannot be entered."
	end
end


def deposit(users_list, transactions_all, amount)
	users_list[$logged_in_user_id][:balance] += amount

	new_tranasction = {type: "Deposit", amount: amount, balance: users_list[$logged_in_user_id][:balance], transaction_time: Time.now}
	transactions_all[$logged_in_user_id].append(new_tranasction)
end

def deposit_caller(users_list, transactions_all)
	system "clear"		
	deposit(users_list, transactions_all, input_amount)
	puts 'Deposit successful.'	
end


def withdraw(users_list, transactions_all, amount)
	if users_list[$logged_in_user_id][:balance] >= amount
		users_list[$logged_in_user_id][:balance] -= amount

		new_tranasction = {type: "Withdraw", amount: amount, balance: users_list[$logged_in_user_id][:balance], transaction_time: Time.now}
		transactions_all[$logged_in_user_id].append(new_tranasction)	
		puts 'Withdrawal successful.'
	else
		puts "You do not have #{amount} rupees in your account."
	end
end


def withdraw_caller(users_list, transactions_all)
	system "clear"
	withdraw(users_list, transactions_all, input_amount)	
end


def transfer(users_list, transactions_all, transfer_user_id, amount)
	#todo: transaction not stored for the receiver
	if users_list[$logged_in_user_id][:balance] >= amount
		users_list[$logged_in_user_id][:balance] -= amount
		users_list[transfer_user_id][:balance] += amount

		new_tranasction = {type: "transfer", amount: amount, transfer_user_id: transfer_user_id, balance: users_list[$logged_in_user_id][:balance], transaction_time: Time.now}
		transactions_all[$logged_in_user_id].append(new_tranasction)	

		puts "Transfer of #{amount} to User #{transfer_user_id} is successful."
	else
		puts "You do not have #{amount} rupees in your account."
	end
end

def transfer_caller(users_list, transactions_all)
	system "clear"
	puts 'Enter user ID to transfer money: '
	transfer_user_id = gets.to_i
	if(transfer_user_id != $logged_in_user_id)					
		if users_list[transfer_user_id]
			transfer(users_list, transactions_all, transfer_user_id, input_amount)
		else
			puts 'The user ID you entered does not exist.'
		end
	else
		puts 'You cannot transfer to your own account.'
	end	
end


def show_history(transactions_user)
	#WE GET:
		#transactions_user = [{}, {}, {}]
		#transaction = {type: 'deposit', amount: 100, transfer_user_id = 2, balance: 1000, time: Time}
	system "clear"
	puts "Transaction History:\n"
	puts "_________________________________________________________________________________________"
	puts "#\tType\t\tAmount    \t\tBalance \tTime"
	puts "_________________________________________________________________________________________"
	transactions_user.each_with_index do |transaction, count|
		puts "#{count+1}\t#{transaction[:type]} \t#{transaction[:amount]}#{transaction[:transfer_user_id] ? ('(To: ' + transaction[:transfer_user_id].to_s + ')'):('     ')}\t\t#{transaction[:balance]} \t#{transaction[:transaction_time]}"
	end
end

def transactions_for_duration(transactions_user)
	#error handling not done
	system "clear"
	puts "Enter start time: "
	start_time = Time.parse(gets).to_i

	puts "Enter end time: "
	end_time = Time.parse(gets).to_i

	puts "Start: #{start_time}\t End: #{end_time}"

	puts "_________________________________________________________________________________________"

		transactions_user.each_with_index do |transaction, count|
			if transaction[:transaction_time].to_i >= start_time and transaction[:transaction_time].to_i <= end_time
			puts "#{count+1}\t#{transaction[:type]} \t#{transaction[:amount]}#{transaction[:transfer_user_id] ? ('(To: ' + transaction[:transfer_user_id].to_s + ')'):('     ')}\t\t#{transaction[:balance]} \t#{transaction[:transaction_time]}"
		end
	end
end
	

def logout
	#assign value to the global variable
	$logged_in_user_id = false
end


#execution starts here:
while true
	puts "To login, enter your ID: (Enter 0 to exit)"
	user_id = gets.chomp.to_i

	if user_id == 0
		#user chose to exit
		break
	end

	if login_caller(users_list, transactions_all, user_id)
		#loops until user logs out
		while true
			puts "__________________________________"
			puts "\n[Your Balance: #{users_list[$logged_in_user_id][:balance]}] [User ID: #{$logged_in_user_id}]"
			puts "__________________________________"
			puts "\n1. Deposit\n2. Withdraw\n3. Transfer\n4. Show history\n5. Find Transactions for a duration\n6. Logout"

			case gets.to_i
				when 1
					deposit_caller(users_list, transactions_all)
				when 2
					withdraw_caller(users_list, transactions_all)
				when 3
					transfer_caller(users_list, transactions_all)
				when 4
					show_history(transactions_all[$logged_in_user_id])
				when 5
					transactions_for_duration(transactions_all[$logged_in_user_id])
				when 6
					logout
					break
				else
					puts "Enter valid option."
			end
		end
	end
end