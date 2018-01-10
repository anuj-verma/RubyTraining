require 'date'
user_information = {:id1=>{:name=>"priyanka", :password=>"abc", :amount=>0, :transactions=>[{:transaction=>"100 Rs CREDITED ", :date=>"2017-11-09"}, {:transaction=>"100 Rs DEBITED ", :date=>"2018-01-01"}]}, :id2=>{:name=>"tanya", :password=>"abc", :amount=>0, :transactions=>[]}}

def deposit(user_information, id, amount)
	user_information[id][:amount] += amount
	new_hash = {transaction:  "#{amount.to_s} Rs CREDITED ", date: Date.today.to_s}
	user_information[id][:transactions] << new_hash
end

def withdraw(user_information, id, amount)
	if user_information[id][:amount] >= amount 
		user_information[id][:amount] -= amount
		new_hash = {transaction:  "#{amount.to_s} Rs DEBITED ", date: Date.today.to_s}
		user_information[id][:transactions] << new_hash
	else
		p "Insufficient balance"
	end
end

def transfer(user_information, from, to, amount)
	if user_information[from][:amount] >= amount 
		user_information[from][:amount] -= amount
		user_information[to][:amount] += amount
		new_hash = {transaction:  "#{amount.to_s} Rs CREDITED TO #{to}", date: Date.today.to_s}
		user_information[from][:transactions] << new_hash
		new_hash = {transaction:  "#{amount.to_s} Rs CREDITED FROM #{from}", date: Date.today.to_s}
		user_information[to][:transactions] << new_hash
	else
		p "Insufficient balance"
	end
end

def enter_id()
id = gets.chomp
return id.to_sym unless id == ""
loop do 
	p 'Enter Valid Id'
	id = gets.chomp 
break if (id != "")
end 
id.to_sym
end

def enter_password()
	password = gets.chomp
	return password if(password != "")
	loop do
		p 'Enter valid password'
		password = gets.chomp
	break if( password != "")
	end
password
end

def enter_name()
	name = gets.chomp
	return name if( name != "")
	p 'Enter Valid name'
	enter_name()
end

def enter_amount()
	amount = gets.chomp.to_i
	return amount if( amount != 0)
	p 'Enter Valid amount'
	enter_amount()
end

def show_transactions(user_information, id, first_date, last_date)
	user_information[id][:transactions].each do |transaction|
	range = (first_date..last_date)
	p "#{transaction[:transaction]} ON #{transaction[:date]}"  if(range.include?(transaction[:date]))
	end
end

def perform_operations(user_information, id)
	
	loop do
		p "CHOOSE OPTION"
		p "1.Deposit  2.Withdraw 3.transfer 4.review transaction 5.exit"
		option = gets.chomp
		case option
			when "1"
				p 'Enter amount'
				amount = enter_amount()
				deposit(user_information, id, amount)	
			when "2"
				p 'Enter amount'
				amount = enter_amount()
				withdraw(user_information, id, amount)
			when "3"
				while true do
				p 'Enter user id to transfer money'
				to = enter_id()
				if user_information[to] != nil
					p 'Enter amount'
					amount = enter_amount()
					transfer(user_information, id, to, amount)
					break
				else
					p "enter valid user id,entered id does not exist"
				end
				end
			when "4"
				p "enter from date in yyyy-mm-dd format"
				from = gets.chomp
				p "enter from to in yyyy-mm-dd format"
				to = gets.chomp
				show_transactions(user_information, id, from, to)
			else
				break
				end
	break if(option == "5")
	end
end

=begin
def menu(user_information)
	begin
		p '1. Login 2.Signup 3.Exit'
		choice = gets.chomp.to_sym
		case choice
		when :1
			#login(user_information)
		when :2
			#signup(user_information)
		else :3
			break
	until choice != :3
end
=end

while true do
	p 'Enter ID'
	id = enter_id()
	if user_information[id] != nil 
		p 'Enter Password'
		password = enter_password()
		if user_information[id][:password] == password
			perform_operations(user_information, id)
		else
			p 'Invalid Password Enter Details Again'
		end
		
	else
		p "ID Does Not Exist"
		p "Enter Your Name :  "
		name = enter_name()
		p 'Enter Password'	
		password = enter_password()
		new_record = {id => {name: name, password: password, amount: 0, transactions: []}}
		user_information.merge!(new_record)
		p user_information
		p 'New Record Created'
	end
end


