#bank program

#BUG: enetering non-numeric data where numeric input is expected doesn't raise an error
#Make things more MODULAR

#'transaction history' feature is remaining 

#each user is stored as a hash e.g. #user = {balance: 765, password: "asda"}
#every such user hashes are stored in a hash called users_list
users_list = {}					#no user exists in the beginning

#made global to conveniently check if a user is logged in or not
$logged_in_user_id = false		#false if user not logged in


#saves to the hash users_list and returns the newly created user_id
def register(users_list, password)
	#new user_id is generated using the lenght of the hash 'users_list'
	#a different approach should be used to generate user_id if the function to delete a user is implemented

	new_user_id = users_list.length + 1
	new_user = {balance: 0, password: password}
	users_list[new_user_id] = new_user

	$logged_in_user_id = new_user_id
	puts "Your ID is #{$logged_in_user_id}. \nUser #{$logged_in_user_id} is registered and logged in."

	return new_user_id
end


#if user exists => asks user for password and log in,
#if doesn't => gives an option to register
def login(users_list, user_id)
	#if user does exist
	if users_list[user_id]
		puts 'Enter your password: '
		entered_password = gets
		if entered_password.to_s.chomp == users_list[user_id][:password]
			$logged_in_user_id = user_id
			puts "User #{user_id} logged in."
			return true
		else
			puts 'Wrong password'
			return false
		end

	#if user doesn't exist
	else
		puts "\nUser #{user_id} is not registered.\nWould you like to register?(y/n)"
		register_or_not = gets
		if register_or_not.chomp.eql? 'y'
			puts 'Enter your new password: '
			password = gets
			$logged_in_user_id = register(users_list, password.chomp)
			return true
		else
			exit 		#exit because user doesn't want to register
		end
	end
end


def deposit(users_list, amount)
	users_list[$logged_in_user_id][:balance] += amount
end


def withdraw(users_list, amount)
	if users_list[$logged_in_user_id][:balance] >= amount
		users_list[$logged_in_user_id][:balance] -= amount
		puts 'Withdrawal successful.'
	else
		puts "You do not have #{amount} rupees in your account."
	end

end


def transfer(users_list, transfer_user_id, amount)
	if users_list[$logged_in_user_id][:balance] >= amount
		users_list[$logged_in_user_id][:balance] -= amount
		users_list[transfer_user_id][:balance] += amount
		puts "Transfer of #{amount} to User #{transfer_user_id} is successful."
	else
		puts "You do not have #{amount} rupees in your account."
	end
end


def logout
	$logged_in_user_id = false
end


#execution starts here:

#loops until chooses not to log in/register
while true
	puts "To login, enter your ID: (Enter 0 to exit)"
	user_id = gets.chomp.to_i

	if user_id == 0
		#user chose to exit
		break
	end

	if login(users_list, user_id)
		#user is logged in, provide user with actions to choose

		#the global variable $logged_in_user_id is used to refer to the logged in user at all the time

		#loops until user logs out
		while true
			puts "\n[Your Balance: #{users_list[$logged_in_user_id][:balance]}]
			Choose an action: 
			1. Deposit
			2. Withdraw
			3. Transfer
			4. Logout"

			action = gets.to_i

			if action == 1
				#deposit
				puts 'Enter amount to be deposited: '
				amount = gets
				deposit(users_list, amount.to_i)
				puts 'Deposit successful.'
			end

			if action == 2
				#withdraw
				puts 'Enter amount to be withdrawn: '
				amount = gets
				withdraw(users_list, amount.to_i)
			end

			if action == 3
				#transfer
				puts 'Enter user ID to transfer money: '
				transfer_user_id = gets.to_i
				if(transfer_user_id != $logged_in_user_id)					
					if users_list[transfer_user_id]
						puts 'Enter amount to transfer: '
						amount = gets.to_i
						transfer(users_list, transfer_user_id, amount)
					else
						puts 'The user ID you entered does not exist.'
					end
				else
					puts 'You cannot transfer to your own account.'
				end
			end

			if action == 4
				logout
				break
			end
		end
	end
end

