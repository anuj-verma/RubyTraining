require 'yaml'

def load_data
	YAML.load_file("new_user_data.yml")
end

def save_data(user_record)
	File.open("new_user_data.yml","w") do |f|
		f.write(user_record.to_yaml)
	end
end

def add_user(user_record)
	system 'clear'
	print 'Enter the name: '
	name = gets.chomp
	print 'Enter the email address: '
	email = gets.chomp
	print 'Enter new userid: '
	user_id = gets.chomp
	print 'Enter new password: '
	password = gets.chomp
	user_info ={name: name, email: email, balance: 0, password: password, transaction_history: []} 
	user_record.store(user_id.to_sym,user_info)
end

def login(user_record)
	system "clear"
	puts "\n\t\t::::::Login Window::::::"
	print 'Enter userid: '
	user_id = gets.chomp.to_sym
	if user_record.has_key? (user_id)
		print 'Enter password: '
		if user_record[user_id][:password] == gets.chomp
			user_interface(user_id,user_record)
		else
			abort("Wrong password!! Quiting the app")
		end
	else
		print "UserId not found. Do you want to create new user(y/n)"
		if gets.chomp == 'y'
			add_user(user_record)
			login(user_record)
		else
			abort("Quiting the app!!")
		end
	end
end

def deposit(user_id, user_record)
	print 'Enter the amount you want to deposit: '
	amount = gets.chomp.to_i
	user_record[user_id][:balance] += amount
	user_record[user_id][:transaction_history].push "User deposited #{amount} on #{Time.now}"
end

def withdraw(user_id,user_record)
	print "Enter the amount you want to withdraw: "
	amount = gets.chomp.to_i
	if user_record[user_id][:balance] - amount < 0
		puts "Transaction invalid: Account balance insufficent"
	else
		user_record[user_id][:balance] -= amount
		user_record[user_id][:transaction_history].push "User withdrawn #{amount} on #{Time.now}"
	end
end

def money_transfer(user_id,user_record)
	print 'Enter the user id to transfer money to: '
	to_id = gets.chomp
	if user_record.has_key? (to_id)
		print 'Enter the amount you want to transfer: '
		amount = gets.chomp.to_i
		if user_record[user_id][:balance] - amount < 0
			puts "Transaction invalid: Account balance insufficent"
		else
			user_record[user_id][:balance] -= amount
			user_record[to_id][:balance] += amount
			user_record[user_id][:transaction_history].push "User transfered #{amount} to #{to_id} on #{Time.now}"
			user_record[user_id][:transaction_history].push "User got #{amount} from #{user_id} on #{Time.now}"
		end
	else
		print "#{to_id} does not exists if you want to try again (y/n)"
		if gets.chomp == 'y'
			money_transfer(user_id)
		end
	end
end

def transaction_history(user_id,user_record)
	puts "Transaction history of user #{user_id}"
	user_record[user_id][:transaction_history].each {|x| puts x}
	print "\n"
end

def check_balance(user_id,user_record)
	puts "The current balance for user #{user_id} is #{user_record[user_id][:balance]}"
end

def user_interface(user_id,user_record)
	system "clear"
	begin
		puts "\t\t Menu\n1.Deposit\n2.Withdraw\n3.Money Transaction\n4.Transaction History\n5.Show Balance\n6.Logout"
		option = gets.chomp.to_i
		if option == 1
			deposit(user_id,user_record)
		elsif option == 2
			withdraw(user_id,user_record)
		elsif option == 3
			money_transfer(user_id,user_record)
		elsif option == 4
			transaction_history(user_id,user_record)
		elsif option == 5
			check_balance(user_id,user_record)
		end 
	end	while option != 6
end


def main
	user_record=load_data
	print user_record
	login(user_record)
	save_data(user_record)
end

main
