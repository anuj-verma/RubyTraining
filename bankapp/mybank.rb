require 'yaml'
require 'io/console'

def load_data
	YAML.load_file("new_user_data.yml")
end

def save_data(user_record)
	File.open("new_user_data.yml","w") do |f|
		f.write(user_record.to_yaml)
	end
end

def input(statement)
  print statement
  block_given? ? yield(gets.chomp) : gets.chomp
end

def enter_valid_passwd(statement)
  print statement
  passwd = STDIN.getpass
  passwd.length < 8 ? enter_valid_passwd(statement) : passwd
end

def enter_valid_user_id(user_record, statement)
  user_id = input(statement) {|id| id.to_sym}
  if user_id.to_s.empty?
    puts 'Conflict: UserId cannot be Blank'
    enter_valid_user_id(user_record, statement)
  end
  if user_record.has_key? (user_id)
      puts 'Conflict: UserId already exist'
      enter_valid_user_id(user_record, statement)
  else
      user_id
  end
end

def enter_valid_payee_id(user_record, statement)
  payee_id = input(statement) { |id| id.sym }
  if payee_id.to_s.empty?
    puts 'Conflict: PayeeId cannot be empty'
    enter_valid_payee_id(user_record, statement)
  end
  unless user_record.has_key? (payee_id)
    puts 'Conflict: PayeeId does not exist'
    enter_valid_payee_id(user_record, statement)
  else
    payee_id
  end
end

def enter_valid_email(statement)
  email = input(statement)
  email.empty? ? enter_valid_email(statement) : email
end

def enter_valid_name(statement)
  name = input(statement)
  name.empty? ? enter_valid_name(statement) : name
end

def enter_valid_date(statement)
  date = input(statement)
  date.empty? ? enter_valid_date(statement) : date
end

def add_user(user_record)
	system 'clear'
	name = enter_valid_name('Enter the Name: ')
	email = enter_valid_email('Enter the Email address: ')
	user_id = enter_valid_user_id(user_record, 'Enter the new UserId: ')
	password = enter_valid_passwd('Enter the new Password(pass length >= 8): ')
	user_info = {name: name, email: email, balance: 0, password: password, transaction_history: []} 
	user_record.store(user_id,user_info)
end

def login(user_record)
	system 'clear'
	user_id = input("\n\t\t::::::Login Window:::::\nEnter UserId: ").to_sym
	if user_record.has_key? (user_id)
		user_record[user_id][:password] == STDIN.getpass('Enter the Password: ') ? user_interface(user_id, user_record) : abort("Wrong password!! Quiting the app")
	else
    if input('UserId not found. Do you want to create new User(y/n)') == 'y'
      add_user(user_record)
			login(user_record)
		else
			abort("Quiting the app!!")
		end
	end
end

def update_balance(user_record, user_id, operation, amount)
  case operation
    when :deposit
      user_record[user_id][:balance] += amount
    when :transfer
      user_record[user_id][:balance] -= amount
  end
end

def update_bal(user_record, user_id, amount)
  if block_given?
    yield(user_record, user_id, amount)
  end
end

def make_transaction_history(user_record, user_id, amount, msg)
  user_record[user_id][:transaction_history] << "You #{msg} amount:#{amount} on #{Time.now.strftime("%d/%m/%Y %H:%M")}"
end

def deposit(user_id, user_record, amount)
  #update_balance(user_record, user_id, :deposit, amount)
  update_bal(user_record, user_id, amount) { |record, id, amount| record[id][:balance] += amount }
  check_balance(user_id, user_record)
  make_transaction_history(user_record, user_id, amount, 'deposited')
end

def withdraw(user_id, user_record, amount)
	if user_record[user_id][:balance] - amount < 0
		puts 'Invalid Transaction: Account balance insufficent.'
	else
    #update_balance(user_record, user_id, :transfer, amount) 
    update_bal(user_record, user_id, amount) { |record, id, amount| record[id][:balance] -= amount }
    check_balance(user_id, user_record)
    make_transaction_history(user_record, user_id, amount, 'withdrawn') 
	end
end

def money_transfer(user_id, user_record, to_id, amount)
  if user_id == to_id
    puts 'Invalid Transaction:You cannot transfer money to yourself.'
  end
	if user_record[user_id][:balance] - amount < 0
	  puts 'Invalid Transaction: Account balance insufficent.'
	else
    update_bal(user_record, user_id, amount) { |record, id, amount| record[id][:balance] -= amount }
    make_transaction_history(user_record, user_id, amount, "transferred to #{to_id}" )
    update_bal(user_record, to_id, amount) { |record, id, amount| record[id][:balance] += amount }
    make_transaction_history(user_record, to_id, amount, "received from #{user_id}" )
  end
end

def transaction_history(user_id, user_record, from_date, to_date)
	puts "Transaction history of user #{user_id}"
	user_record[user_id][:transaction_history].each do |transaction|
    transaction_date = transaction[-16..-7]
    #puts transaction if DateTime.parse(from_date) <= Date.parse(transaction_date) and Date.parse(to_date) >= Date.parse(transaction_date)
    puts transaction if DateTime.parse(transaction_date).between?(DateTime.parse(from_date), DateTime.parse(to_date))
  end
end

def check_balance(user_id, user_record)
	puts "The current balance for user #{user_id} is #{user_record[user_id][:balance]}"
end

def user_interface(user_id, user_record)
	system 'clear'
	begin
    option = input("\t\t Menu\n1.Deposit\n2.Withdraw\n3.Money Transaction\n4.Transaction History\n5.Show Balance\n6.Logout\n") {|x| x.to_i}
    case option
      when 1
        amount = input('Enter the Amount you want to deposit: ') {|amount| amount.to_i}
			  deposit(user_id, user_record, amount)
      when 2
        amount = input('Enter the Amount you want to withdraw: ') {|amount| amount.to_i}
			  withdraw(user_id, user_record, amount)
      when 3
	      to_id = enter_valid_payee_id(user_record, 'Enter the UserId to transfer money to: ') #validate to_id
		    amount = input('Enter the Amount you want to transfer: ') {|amount| amount.to_i}
			  money_transfer(user_id, user_record, to_id, amount)
      when 4
        from_date = enter_valid_date('Enter the Start date(dd/mm/yyyy): ')
        to_date = enter_valid_date('Enter the End date(dd/mm/yyyy): ')
			  transaction_history(user_id, user_record, from_date, to_date)
      when 5
			  check_balance(user_id, user_record)
    end
  end while option != 6
end


def main
	user_record=load_data
	#print user_record
	login(user_record)
	save_data(user_record)
end

main

