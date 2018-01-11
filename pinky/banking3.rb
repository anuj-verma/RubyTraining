require 'date'
database = {'pinkyrout10@gmail.com' => 
             { name: 'Pinky Rout',
               password: '12345',
               balance: 0,
							 phone_no: 9527024807,
               transaction: [{ msg: 'transaction:  ', date: '2018-01-09'} ]
              }
           }

def signup(database)
  email = take_input('enter your email id'){|string| puts string 
            gets.chomp}
	validation(email,database){|string| /\A[a-z][a-z]*[0-9]*_*@[a-z]+.com$/.match?(string)}
  name = take_input('enter your user name'){|string| puts string
           gets.chomp}
  validation(name,database){|string| /\A[A-Za-z][A-Za-z0-9]*_*[A-Za-z0-9]*/.match?(string)}

  password = take_input("enter your password \n enter atleast 6 characters and alleast 1 special character )"){|string| puts string
               gets.chomp}
	validation(password,database) do |string| 
	  if string.length >= 6
	    /\A[a-zA-Z][a-zA-z0-9]*[~!@#$%^&*()_+.><,?:;'"}{|][a-zA-Z0-9]*/.match?(string)
    else
    	return false
		end
		end
  phone_no = take_input('enter your phone number'){|string| puts string
	           	gets.chomp}
  validation(phone_no,database) do |string|
	 if string.length == 10
	   /\D/.match?(string)
	 else
	   return false
	 end
   end
  database[email]= {name: name, password: password, balance: 0, phone_no: phone_no, transaction: []}
  user_interaction(email, database)
end

def signin(database)
   email = take_input('enter your email id'){|string| puts string 
            gets.chomp}
  if database.include?(email)
    entered_password = take_input('enter your password'){|string| puts string
                         gets.chomp}  
    if entered_password == database[email][:password]
    user_interaction(email, database)
    else
    take_input('wrong password entered'){|string| puts string
        signin(database)} 
    end
  else
    puts 'You have to signup first'
    signup(database)
  end
end
    
def user_interaction(email, database)
  puts "1.Deposit money \n2.Withdraw money \n3.Transfer money \n4.Balance Enquiry \n5.Logout \n6.Transaction history"
  puts 'enter the index of the operation to perform' 
  operation_index = gets.chomp.to_i
  case operation_index
    when 1
      amount = take_input('enter the amount'){ |string| puts string
			           gets.chomp}
      deposit(email, database, amount)
    when 2
        amount = take_input('enter the amount'){ |string| puts string
				         	gets.chomp}
        withdraw(email, database, amount)
    when 3
        to_transfer_email = take_input('enter the email id of the user to transfer to'){ |string| puts string
				                    	gets.chomp}
        if database.include?(to_transfer_email)
          puts 'Enter the amount of money to transfer'
  	  amount = gets.chomp.to_i
  	  transfer(email, database, amount, to_transfer_email)
        else
          puts 'User with above email does not exist'
          user_interaction(email, database)
        end
    
    when 4
  	balance_enquiry(email, database)
    when 5 
  	logout(email,database)
    when 6  
      puts '1.Show all transactions'
      puts '2.Show transactions between two dates'
      choice = gets.chomp.to_i
      case choice
        when 1
	  puts 'Transactions are as follows'
	  transaction_history(database,email,choice,nil,nil)
	when 2
	  puts 'enter the first date (format = yyyy-mm-dd)'
	  date1 = gets.chomp
	  puts 'enter the second date (format = yyyy-mm-dd)'
	  date2 = gets.chomp
	  transaction_history(database,email,choice,date1,date2)
      end
    else
      user_interaction(email, database)  
  end
end

def take_input(msg)
  input = yield(msg) if block_given?
  if input == ''
    take_input(msg){ |string| puts string
      gets.chomp}
  end  
  input
end

def validation(string, database)
	valid = yield(string) if block_given?
  if valid == false 
	puts 'invalid data entered'
	signup(database)
	end
end


def balance_enquiry(email, database)
  puts "Your current balance is #{database[email][:balance]}"
  message = "balance enquiry, balance = #{database[email][:balance]}   "
  set_trans_history(email, database, message)
  user_interaction(email, database)
end

def deposit(email, database, amount)
  database[email][:balance] = database[email][:balance] + amount
  puts "#{amount} rupees deposited successfully, current balance is #{database[email][:balance]}"
  message = "#{amount} rupees deposited, balance = #{database[email][:balance]}    "
  set_trans_history(email, database, message)
  user_interaction(email,database)
end

def withdraw(email, database, amount)
  if database[email][:balance] < amount
  puts 'Not enough balance'
  user_interaction(email,database)
  else
  database[email][:balance] = database[email][:balance] - amount
  puts "Money withdrawn successfully, current balance is #{database[email][:balance]}"
  message = "#{amount} rupees withdrawn, balance = #{database[email][:balance]}    "
  set_trans_history(email, database, message)
  user_interaction(email,database)
  end
end

def set_trans_history(email,database,message)
  time = Time.new
  date = Date.today.to_s
  database[email][:transaction] << {msg: message + time.inspect, date: date }
end

def transfer(email, database, amount, to_transfer_email)
  if database[email][:balance] < amount
    puts 'Not enough balance to transfer' 
    user_interaction(email,database)
  end
  database[email][:balance] = database[email][:balance] - amount
  database[to_transfer_email][:balance] = database[to_transfer_email][:balance] + amount
  puts 'Money transfered successfully'
  message = "#{money_to_transfer} rupees transferred to #{database[to_transfer_email][:name]}"
  set_trans_history(email,database,message)
  message = "#{money_to_transfer} rupees recieved from #{database[email][:name]}"
  set_trans_history(to_transfer_email,database,message)
  user_interaction(email, database)
end

def logout(email, database)
  puts '1.exit'
  puts '2.signin again'
  choice = gets.chomp.to_i
  exit if choice == 1
  signin(database)
end

def transaction_history(database,email,choice,date1,date2)
  i = 0
  case choice
    when 1
      database[email][:transaction].each{|transaction| puts "#{transaction[:msg]}"}
      user_interaction(email,database)
    when 2
      date_array = (date1..date2).to_a
      database[email][:transaction].each do
        |transaction|
        if date_array.include?(transaction[:date])
          i = 1
          puts transaction[:msg]
        end
       end
      puts 'You have not performed any transaction between the above dates' if i == 0
  end
end   
signin(database)

