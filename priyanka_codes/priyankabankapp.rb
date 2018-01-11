require 'date'
user_information = {:id1=>{:name=>"priyanka", :password=>"abc", :amount=>0, :transactions=>[{:transaction=>"100.0 Rs CREDITED ", :date=>"2017-11-09"}, {:transaction=>"100.0 Rs DEBITED ", :date=>"2018-01-01"}]}, :id2=>{:name=>"tanya", :password=>"abc", :amount=>0, :transactions=>[]}}
def deposit(user_information, id, amount)
	user_information[id][:amount] += amount
	p "#{amount} rs Credited"
	new_hash = {transaction:  "#{amount.to_s} RS CREDITED ", date: Date.today.to_s}
	user_information[id][:transactions] << new_hash
end

def withdraw(user_information, id, amount)
	return p 'Insufficient Balance' unless user_information[id][:amount] >= amount 
	user_information[id][:amount] -= amount
	p "#{amount} RS Debited"
	new_hash = {transaction:  "#{amount.to_s} RS  DEBITED ", date: Date.today.to_s}
	user_information[id][:transactions] << new_hash
end

def transfer(user_information, from, to, amount)
	return p 'Insufficient Balance' unless user_information[from][:amount] >= amount 
	user_information[from][:amount] -= amount
	user_information[to][:amount] += amount
	p "#{amount} RS Transfered to #{to}"
	new_hash = {transaction:  "#{amount.to_s} RS CREDITED TO #{to}", date: Date.today.to_s}
	user_information[from][:transactions] << new_hash
	new_hash = {transaction:  "#{amount.to_s} RS CREDITED FROM #{from}", date: Date.today.to_s}
	user_information[to][:transactions] << new_hash
end

def validate_input(expr, input)
	expr.match?(input)
end
def read_input(expr, msg, msg2)
	input = gets.chomp
 	return input if validate_input(expr, input)
	p msg2
 	loop do
		#to = read_input(expr, msg).to_sym
  	input = gets.chomp
  	p "Invalid #{msg} Please Enter Again"
 	break if( expr.match?(input))
	end
	input
end
 
def enter_amount()
	amount = gets.chomp
	return amount.to_f if(validate_input(/\A[0-9]+\z/, amount) && amount.to_f > 0)
	p 'Enter Valid amount'
	enter_amount()
end

def check_dates(date1, date2)
	return false if date2[0].to_i < date1[0].to_i
  return false if (date2[1].to_i < date1[1].to_i && date2[0].to_i == date1[0].to_i)
  return false if (date2[2].to_i < date1[2].to_i && date2[1].to_i == date1[1].to_i)
  true
end

def show_transactions(user_information, id, first_date, last_date)
	user_information[id][:transactions].each do |transaction|
	range = (first_date..last_date)
	p "#{transaction[:transaction]} ON #{transaction[:date]}"  if(range.include?(transaction[:date]))
	end
end

def recipient_userid(user_information, id, expr)
	to = read_input(expr, 'ID').to_sym
	return to if (user_information[to] != nil && to != id)
	p '1. enter valid user id ' 
	recipient_userid(user_information, id, expr)
end

def get_date
 regex = /\A\d{4}-\d{2}-\d{2}\z/
 date = gets.chomp
 return date if regex.match?(date)
 p 'Invalid date,enter date in yyyy-mm-dd format'
 get_date
end

def review_transaction(user_information, id)
	p 'enter from date in yyyy-mm-dd format'
	from = get_date
	p 'enter from to in yyyy-mm-dd format'
	to = get_date
	return show_transactions(user_information, id, from, to) if check_dates(from.split('-'), to.split('-'))
	p ' Invalid to date'
	review_transaction(user_information, id)
end

def perform_operations(user_information, id, idexp)
	loop do
		p 'CHOOSE OPTION'
		p '1.Deposit  2.Withdraw 3.transfer 4.review transaction 5.Available Balance 6.exit'
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
				p 'Enter Recipient ID' 	
				to = recipient_userid(user_information,	id, idexp)
				p 'Enter amount'
				amount = enter_amount()
				transfer(user_information, id, to, amount)
			when "4"
					review_transaction(user_information, id)
			when '5'
				p "Available Balance : #{user_information[id][:amount]} rs"
		end
	break unless option != '6'
	end
end

def verify_password(user_information, id)
	p 'Enter Password'
	password = gets.chomp
	return true if user_information[id][:password] == password
	p 'Wrong Password'
	verify_password(user_information, id)
end

def login(user_information, idexp)
	p 'Enter ID'
	id = read_input(idexp, 'ID', 'ID must not contain spaces and empty string').to_sym
	return p 'ID Does Not Exist Signup First' unless user_information[id] != nil
	perform_operations(user_information, id, idexp) if verify_password(user_information, id)
end

def get_unique_id(user_information, expr)
	id = read_input(expr, 'ID', 'ID must not contain spaces and empty string').to_sym
	return id if !user_information.has_key?(id) 
	loop do 
	  p 'Given ID Already Exist, Enter ID Again'
	  id = read_input(expr, 'ID', 'ID must not contain spaces and empty string').to_sym
	  break if !user_information.has_key?(id)
	end
	id
end

def signup(user_information, idexp, nameexp, passexp)
	p 'Enter ID'
	id = get_unique_id(user_information, idexp)
	p "Enter Your Name :  "
	name = read_input(nameexp, 'Name', 'please enter fullname')
	p 'Enter Password'	
	password = read_input(passexp, 'Password','password must contain one special character,one small case letter,one capital letter and one digit')
	new_record = {id => {name: name, password: password, amount: 0, transactions: []}}
	user_information.merge!(new_record)
	p 'New Record Created'
	p user_information[id].slice(:name, :amount)
end

def menu(user_information)
	passexp = /(?=.*[a-z]+)(?=.*[A-Z]+)(?=.*[0-9]+)(?=.*\W+)/
	nameexp = /\A[a-zA-z]+ [a-zA-z]+\z/
	idexp  =/[^''|' ']/
	loop do
		p '1. Login 2.Signup 3.Exit'
		choice = gets.chomp
		case choice
		when '1'
			login(user_information, idexp)
		when '2'
			signup(user_information,idexp, nameexp, passexp)
		end
		break unless choice != '3'	
	end
end
menu(user_information)
