require 'yaml'

def load_data
	YAML.load_file("new_user_data.yml")
end

def save_data(user_record)
	File.open("new_user_data.yml","w") do |f|
		f.write(user_record.to_yaml)
	end
end

def input(arg)
  print arg
  gets.chomp
end

def add_user(user_record)
	system 'clear'
	name = input('Enter the name: ')
	email = input('Enter the emailaddress: ')
	user_id = input('Enter the new userId: ')
	password = input('Enter the new password: ')
	user_info = {name: name, email: email, balance: 0, password: password, transaction_history: []} 
	user_record.store(user_id.to_sym,user_info)
end

def login(user_record)
	system 'clear'
	user_id = input("\n\t\t::::::Login Window:::::\nEnter userid: ").to_sym
	if user_record.has_key? (user_id)
		user_record[user_id][:password] == input('Enter password: ') ?	user_interface(user_id, user_record) : abort("Wrong password!! Quiting the app")
	else
    if input('UserId not found. Do you want to create new user(y/n)') == 'y'
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

def make_transaction_history(user_record, user_id, amount, msg)
  user_record[user_id][:transaction_history] << "You #{msg} amount:#{amount} on #{Time.now.strftime("%d/%m/%Y %H:%M")}"
end

def deposit(user_id, user_record, amount)
  update_balance(user_record, user_id, :deposit, amount)
  make_transaction_history(user_record, user_id, amount, 'deposited')
end

def withdraw(user_id, user_record, amount)
	if user_record[user_id][:balance] - amount < 0
		puts "Invalid Transaction: Account balance insufficent."
	else
    update_balance(user_record, user_id, :transfer, amount)
    make_transaction_history(user_record, user_id, amount, 'withdrawn')
	end
end

def money_transfer(user_id, user_record, to_id, amount)
  if user_id != to_id
	  if user_record.has_key? (to_id)
		  if user_record[user_id][:balance] - amount < 0
			  puts "Transaction invalid: Account balance insufficent"
	    else
        update_balance(user_record, user_id, :transfer, amount)
        make_transaction_history(user_record, user_id, amount, "transferred to #{to_id}" )
        update_balance(user_record, to_id, :deposit, amount)
        make_transaction_history(user_record, to_id, amount, "received from #{user_id}" )
		  end
	  else money_transfer(user_id) if input("#{to_id} does not exists if you want to try again (y/n)") == 'y'
	  end
  else puts 'Invalid Transaction:You cannot transfer money to yourself.'
  end
end

def transaction_history(user_id, user_record, from_date, to_date)
	puts "Transaction history of user #{user_id}"
	user_record[user_id][:transaction_history].each do |transaction|
    transaction_date = transaction[-16..-7]
    puts transaction if DateTime.parse(from_date) <= Date.parse(transaction_date) and Date.parse(to_date) >= Date.parse(transaction_date)
  end
end

def check_balance(user_id, user_record)
	puts "The current balance for user #{user_id} is #{user_record[user_id][:balance]}"
end

def user_interface(user_id, user_record)
	system 'clear'
	begin
    option = input("\t\t Menu\n1.Deposit\n2.Withdraw\n3.Money Transaction\n4.Transaction History\n5.Show Balance\n6.Logout\n").to_i
    case option
      when 1
        amount = input('Enter the amount you want to deposit: ').to_i
			  deposit(user_id, user_record, amount)
      when 2
        amount = input('Enter the amount you want to withdraw: ').to_i
			  withdraw(user_id, user_record, amount)
      when 3
	      to_id = input('Enter the user id to transfer money to: ')
		    amount = input('Enter the amount you want to transfer: ').to_i
			  money_transfer(user_id, user_record, to_id.to_sym, amount)
      when 4
        from_date = input('Enter the Start date(dd/mm/yyyy): ')
        to_date = input('Enter the End date(dd/mm/yyyy)')
			  transaction_history(user_id, user_record, from_date, to_date)
      when 5
			  check_balance(user_id, user_record)
    end
  end while option != 6
end


def main
	user_record=load_data
	print user_record
	login(user_record)
	save_data(user_record)
end

main

