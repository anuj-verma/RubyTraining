#bank program (Before: 167 lines)

#TODO:
	#validate all input

require "time"
#each user is stored as a hash e.g. #user = {balance: 765, password: "asda"}
#every such user hash is stored in a hash called users_list
users_list = {}					

#HOW TRANSACTIONS ARE STORED
	#transactions = {user_id1: [{}, {}, {}], user_id1: [{}, {}, {}]}
	#user_transactions = [{}, {}, {}]
	#transaction = {type: 'deposit', amount: 100, transfer_user_id = 2, balance: 1000, time: Time.now}
transactions = {}

#made global to conveniently check if a user is logged in or not
$logged_in_user_id = false		#false if user not logged in


def register(users_list, transactions)
	#new user_id is generated using the lenght of the hash 'users_list'
	#a different approach should be used to generate user_id if the function to delete a user is implemented

	puts 'Enter your new password: '
	password = gets.chomp.to_s

	new_user_id = users_list.length + 1
	new_user = {balance: 0, password: password}
	users_list[new_user_id] = new_user

	transactions[new_user_id] = []

	$logged_in_user_id = new_user_id
	puts "Registration successful. Your ID is #{$logged_in_user_id}."

	$logged_in_user_id = new_user_id

	true
end


def login(users_list)
	user_id = get_int("Enter User ID: ")
	if !users_list[user_id]
		puts "User ID doesn't exist.\n"
		return false
	end
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


def get_int(message)
	puts message
	while true
		amount = gets.to_i
		return amount if amount > 0
		puts "Invalid input"
	end
end

def deposit(users_list, transactions, amount)
	users_list[$logged_in_user_id][:balance] += amount

	new_tranasction = {type: "Deposit", amount: amount, balance: users_list[$logged_in_user_id][:balance], transaction_time: Time.now}
	transactions[$logged_in_user_id].append(new_tranasction)

	puts 'Deposit successful.'	
end

def withdraw(users_list, transactions, amount)
	if users_list[$logged_in_user_id][:balance] >= amount
		users_list[$logged_in_user_id][:balance] -= amount

		new_tranasction = {type: "Withdraw", amount: amount, balance: users_list[$logged_in_user_id][:balance], transaction_time: Time.now}
		transactions[$logged_in_user_id].append(new_tranasction)	
		puts 'Withdrawal successful.'
	else
		puts "You do not have #{amount} rupees in your account."
	end
end

def transfer(users_list, transactions, transfer_user_id, amount)
	if users_list[$logged_in_user_id][:balance] >= amount
		users_list[$logged_in_user_id][:balance] -= amount
		users_list[transfer_user_id][:balance] += amount

		sender_tranasction = {type: "Transfer", amount: amount, transfer_user_id: transfer_user_id, balance: users_list[$logged_in_user_id][:balance], transaction_time: Time.now, action: "To"}
		transactions[$logged_in_user_id].append(sender_tranasction)


		receiver_tranasction = {type: "Transfer", amount: amount, transfer_user_id: $logged_in_user_id, balance: users_list[transfer_user_id][:balance], transaction_time: Time.now, action: "From"}
		transactions[transfer_user_id].append(receiver_tranasction)	

		puts "Transfer of #{amount} to User #{transfer_user_id} is successful."
	else
		puts "You do not have #{amount} rupees in your account."
	end
end

def transfer_dialog(users_list, transactions)
	transfer_user_id = get_int("Enter user ID to transfer money: ")
	if(transfer_user_id != $logged_in_user_id)					
		if users_list[transfer_user_id]
			transfer(users_list, transactions, transfer_user_id, get_int("Enter amount: "))
		else
			puts 'The user ID you entered does not exist.'
		end
	else
		puts 'You cannot transfer to your own account.'
	end	
end

def show_history(user_transactions)
	#WE GET:
		#user_transactions = [{}, {}, {}]
		#transaction = {type: 'deposit', amount: 100, transfer_user_id = 2, balance: 1000, time: Time}
	puts "Transaction History:\n"
	puts "_________________________________________________________________________________________"
	puts "#\tType\t\tAmount    \t\tBalance \tTime"
	puts "_________________________________________________________________________________________"
	user_transactions.each_with_index do |transaction, count|
		puts "#{count+1}\t#{transaction[:type]} \t#{transaction[:amount]}#{transaction[:transfer_user_id] ? ('('+ transaction[:action] +': ' + transaction[:transfer_user_id].to_s + ')'):('     ')}\t\t#{transaction[:balance]} \t#{transaction[:transaction_time]}"
	end
end


def transactions_for_duration(user_transactions)
	#error handling not done
	puts "Enter start time: (format: '9 jan 2018 16:35:20')"
	start_time = Time.parse(gets).to_i

	puts "Enter end time: (format: '9 jan 2018 16:35:20')"
	end_time = Time.parse(gets).to_i

	puts "_________________________________________________________________________________________"

		user_transactions.each_with_index do |transaction, count|
			if transaction[:transaction_time].to_i >= start_time and transaction[:transaction_time].to_i <= end_time
			puts "#{count+1}\t#{transaction[:type]} \t#{transaction[:amount]}#{transaction[:transfer_user_id] ? ('(To: ' + transaction[:transfer_user_id].to_s + ')'):('     ')}\t\t#{transaction[:balance]} \t#{transaction[:transaction_time]}"
		end
	end
end
	
def logout
	$logged_in_user_id = false		#assign value to the global variable
end


#execution starts here:
while true
	puts "\n1. Login\n2. Register\n3. Exit"

	case gets.chomp.to_i
	when 1
		system "clear"
		next unless login(users_list)
	when 2
		system "clear"
		register(users_list, transactions)
	when 3
		exit
	end

		#loops until user logs out
		while true
			puts "__________________________________"
			puts "\n[Your Balance: #{users_list[$logged_in_user_id][:balance]}] [User ID: #{$logged_in_user_id}]"
			puts "__________________________________"
			puts "\n1. Deposit\n2. Withdraw\n3. Transfer\n4. Show history\n5. Find Transactions for a duration\n6. Logout\n7. Exit"

			case gets.to_i
				when 1
					system "clear"
					deposit(users_list, transactions, get_int("Enter amount: "))
				when 2
					system "clear"
					withdraw(users_list, transactions, get_int("Enter amount: "))
				when 3
					system "clear"
					transfer_dialog(users_list, transactions)
				when 4
					system "clear"
					show_history(transactions[$logged_in_user_id])
				when 5
					system "clear"
					transactions_for_duration(transactions[$logged_in_user_id])
				when 6
					system "clear"
					logout
					break
				when 7
					exit
				else
					puts "Enter valid option."
			end
		end
end