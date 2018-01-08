users={:tanyasaroha =>{:name=>"Tanya Saroha", :password => "12345", :email => "tanya@gmail.com", :balance =>20000, :transaction_history => ["Deposited 20000"]}, :priyanka => {:name => "Priyanka Yadav", :password => "12345", :email=> "priyank@josh.com", :balance => 23000, :transaction_history => ["Deposited 23000"]}, :pinky => {:name => "Pinky Rout", :password => "123456", :email => "pinky@gmail.com", :balance => 30000, :transaction_history => ["Deposited 30000"]}}

def register(users)
	puts "Please provide following details to register"
	puts "Your username:-"
	new_username =gets.chomp.to_sym
	puts "Your password:-"
	new_password = gets.chomp
	puts "Your Full name:-"
	new_name = gets.chomp
	puts "Your emailID:-"
	new_email = gets.chomp
	puts "Balance you want to add in your account"
	new_balance = gets.chomp.to_i
	new_users={ new_username => {:name => new_name, :password=>new_password, :email => new_email, :balance => new_balance, :transaction_history => ["Added " + new_balance.to_s + " in your account"]}}
	users.merge!(new_users)
return new_username
end

def log_in(users)
	puts "To Log in:- Please enter Username:"
	user_name =gets.chomp.to_sym
	if users[user_name]!=nil
		puts "Please enter password"
		user_password=gets.chomp
		if users[user_name][:password]==user_password
			puts "Welcome " + user_name.to_s
		else puts "Wrong password. Please enter again carefully"
		log_in(users)		
		end
	else puts "wrong username/ username does not existin your account. Please enter again carefully"	
		log_in(users)	
	end 
return user_name
end

def deposit(users,user_name)
	puts "Please tell how much money you want to add?"
	amount=gets.chomp.to_i
	users[user_name][:balance]=users[user_name][:balance] + amount
	puts "Amount added, now your balance is:-"
	puts users[user_name][:balance]
	users[user_name][:transaction_history] << "Deposited " + amount.to_s
return users[user_name][:balance]
end

def withdraw(users, user_name)
	puts "Please tell how much money you want to withdraw?"
	amount=gets.chomp.to_i
	if amount <= users[user_name][:balance]
		users[user_name][:balance]=users[user_name][:balance] - amount
		puts "Amount withdrawn, now your balance is:-"
		puts users[user_name][:balance]
		users[user_name][:transaction_history] << "Withdrew " + amount.to_s
	else
		puts "Transaction Cancelled. Insufficenit amount of money in your account"
	end
return users[user_name][:balance]
end

def transfer(users, user_name)
	puts "Please tell how much money you want to tranfer?"
	amount=gets.chomp.to_i
	if amount <= users[user_name][:balance]
		puts "Please enter the username of the receiver"
		user_name_receiver=gets.chomp.to_sym
		if users[user_name_receiver]!=nil
			users[user_name][:balance]=users[user_name][:balance] - amount
			users[user_name_receiver][:balance]=users[user_name_receiver][:balance] + amount
			puts "Amount transferred, now your balance is:-"
			puts users[user_name][:balance]
			users[user_name][:transaction_history] << "transferred " + amount.to_s + " to " + users[user_name_receiver][:name]
			users[user_name_receiver][:transaction_history] << users[user_name][:name] + " debited " + amount.to_s + " to your account"
		else puts"Transaction Cancelled. Invalid Username of receiver entered."
		end
	else puts "Transaction Cancelled. Insufficient balance in your account"
	end
return users[user_name][:balance]
end

puts "Press 1 if you are new user."
puts "Press 2 if you are existing user."
ch1 = gets.chomp
puts ch1
case ch1
when "1"
	user_name=register(users)
	user_name=log_in(users)
when "2"
	user_name=log_in(users)
end
loop do
puts "Choose what operation you want to perform"
puts "1. Add Amount"
puts "2. Withdraw amount"
puts "3. Transfer Amount"
puts "4. View Transaction history"
puts "5. Logout and login from some other account"
puts "6. Logout"
ch2 = gets.chomp
case ch2
	when "1"
	puts "You have chosen to add money to your account"
	bal=deposit(users,user_name)
	when "2"
	puts "You have chosen to withdraw money from your account"
	bal=withdraw(users,user_name)
	when "3"
	puts "You have chosen to transfer money from your account"
	bal=transfer(users, user_name)
	when "4"
	puts users[user_name][:transaction_history]
	when "5"
	user_name=log_in(users)
	when "6"
	puts "Bye"
end
break if ch2=="6"
end
