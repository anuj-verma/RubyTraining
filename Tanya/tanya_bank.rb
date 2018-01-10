require 'date'
users={tanyasaroha: {name: "Tanya Saroha", password: "12345", email: "tanya@gmail.com", balance: 50000, transaction_history: [{transaction: "Deposited 20000", date: "2018-01-08"},{transaction: "Deposited 30000", date: "2018-01-07"}]}, priyanka: {name: "Priyanka Yadav", password: "12345", email: "priyank@josh.com", balance: 23000, transaction_history: [{transaction: "Deposited 23000", date: "2018-01-08"}]}, pinky: {name: "Pinky Rout", password: "123456", email: "pinky@gmail.com", balance: 30000, transaction_history: [{transaction: "Deposited 30000", date: "2018-01-08"}]}}

def register(users)
	puts "Please provide following details to register"
	puts "Your Username:-"
	new_username = gets.chomp.to_sym

	if(users[new_username] == nil)
		puts "Your Password:-"
		new_password = gets.chomp {|q| q.echo = "*"}
		puts "Your Full name:-"
		new_name = gets.chomp
		puts "Your Email-ID:-"
		new_email = gets.chomp
		puts "Balance you want to add in your account"
		new_balance = gets.chomp.to_i
		if new_balance > 0 
			new_date = Date.today.to_s
			new_users={ new_username=> {name: new_name, password: new_password, email: new_email, balance: new_balance, transaction_history: [{transaction:"Added " + new_balance.to_s, date: new_date}]}}
			users.merge!(new_users)
			puts users
		else
			puts "Registration Cancelled! You entered invalid amount! Register Again"
			register(users)
		end
	else
		puts "Username already taken, give yourself another username"
		register(users)
	end

	return new_username
end

def log_in(users)
	puts "To Log in:- Please enter Username:"
	user_name = gets.chomp.to_sym
	if users[user_name] != nil
		puts "Please enter password"
		user_password=gets.chomp
		if users[user_name][:password] == user_password
			puts "Welcome " + user_name.to_s
		else puts "Wrong password. Please enter again carefully"
		log_in(users)		
		end
	else puts "wrong username/ username does not exist. Please enter again carefully"	
		log_in(users)	
	end 
	return user_name
end

def deposit(users,user_name)
	puts "Please tell how much money you want to add?"
	amount = gets.chomp.to_i
	if amount > 0
		users[user_name][:balance]=users[user_name][:balance] + amount
		puts "Amount added, now your balance is:-"
		puts users[user_name][:balance]
		date = Date.today.to_s
		new_transaction = {transaction: "Deposited " + amount.to_s, date: date}
		users[user_name][:transaction_hitory] 
		users[user_name][:transaction_history] << new_transaction 
	else puts "Transsaction Cancelled. Did not wnwter valid amount"
	end
	return users[user_name][:balance]
end

def withdraw(users, user_name)
	puts "Please tell how much money you want to withdraw?"
	amount=gets.chomp.to_i
	if amount > 0
		if amount <= users[user_name][:balance]
			users[user_name][:balance]=users[user_name][:balance] - amount
			puts "Amount withdrawn, now your balance is:-"
			puts users[user_name][:balance]
			date = Date.today.to_s
			new_transaction = {transaction: "Withdrew " + amount.to_s, date:date}
			users[user_name][:transaction_history] << new_transaction
		else
			puts "Transaction Cancelled. Insufficenit amount of money in your account"
		end
	else 
		puts "Transaction Cancelled. You did not enter valid amount"
	end
	return users[user_name][:balance]
end

def transfer(users, user_name)
	puts "Please tell how much money you want to tranfer?"
	amount = gets.chomp.to_i
	if amount > 0
		if amount <= users[user_name][:balance]
			puts "Please enter the username of the receiver"
			user_name_receiver=gets.chomp.to_sym
			if users[user_name_receiver] != nil
				users[user_name][:balance] = users[user_name][:balance] - amount
				users[user_name_receiver][:balance] = users[user_name_receiver][:balance] + amount
				puts "Amount transferred, now your balance is:-"
				puts users[user_name][:balance]
				date = Date.today.to_s
				new_transaction = {transaction: "Transferred " + amount.to_s + " to " + users[user_name_receiver][:name], date: date}
				users[user_name][:transaction_history] << new_transaction
				new_transaction_receiver = {transaction: users[user_name][:name] + " transferred " + amount.to_s + " to your account ", date: date}
				users[user_name_receiver][:transaction_history] << new_transaction_receiver			
#users[user_name_receiver][:transaction_history] << users[user_name][:name] + " debited " + amount.to_s + " to your account"
			else puts"Transaction Cancelled. Invalid Username of receiver entered."
			end
		else puts "Transaction Cancelled. Insufficient balance in your account"
		end
	else puts "Transaction cancelled. You did not ented valid amount to transfer"
	end
	return users[user_name][:balance]
end

def welcome(users)
	puts "Press 1 if you are new user."
	puts "Press 2 if you are existing user."
	ch1 = gets.chomp
	puts ch1
	case ch1
 		when "1"
			user_name = register(users)
			welcome(users)
			#user_name = log_in(users)	
		when "2"
			user_name = log_in(users)
		else
			puts "Choose Either 1 or 2. You entered some invalid value"
			welcome(users)
	end
	return user_name
end

user_name = welcome(users)
 
loop do
	menu = ["Choose what operation you want to perform", "1. Add Amount", "2. Withdraw amount", "3. Transfer Amount", "4. View Transaction history", "5. View  Transaction history between two dates", "6. View Balance in account", "7. Logout and login from some other account", "8. Logout"]
	puts menu
	ch2 = gets.chomp

	case ch2
		when "1"
			puts "You have chosen to add money to your account"
			bal =deposit(users,user_name)
		when "2"
			puts "You have chosen to withdraw money from your account"
			bal = withdraw(users,user_name)
		when "3"
			puts "You have chosen to transfer money from your account"
			bal = transfer(users, user_name)
		when "4"
			users[user_name][:transaction_history].each{|transactions| puts "#{transactions[:transaction]} #{transactions[:date]}"}
		when "5"
			puts "You have chosen to view history of transactions between two dates"
			puts "Please choose the starting date (In the format YYYY-MM-DD)"
			from_date = gets.chomp
			puts "Please choose second date (In the format YYYY-MM-DD)"
			to_date = gets.chomp
			date_range = (from_date..to_date).to_a
			users[user_name][:transaction_history].each{|transactions| if date_range.include?transactions[:date]
 			puts "#{transactions[:transaction]}" end }
		when "6"
			puts users[user_name][:balance]
		when "7"
			user_name = welcome(users)
		when "8"
			puts "Bye"
		else
			puts "Invalid option chosen! Please choose option carefully"
	end
break if ch2 == "8"
end
