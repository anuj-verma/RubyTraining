require 'date'
database_hash = {'pinkyrout10@gmail.com'=> {name: 'Pinky Rout', password: '12345', balance: 0, transaction_array: [{msg: 'transaction:  ', date: '2018-01-09'}]}}

def signup(database_hash)
  puts 'enter your email id'
  email = gets.chomp
  puts 'enter your user name'
  user_name = gets.chomp
  puts 'enter your password'
  user_password = gets.chomp
  database_hash[email]= {name: user_name, password: user_password, balance: 0, transaction_array: []}
  user_interaction(email, database_hash)
end

def signin(database_hash)
  puts 'enter your email id'
  email = gets.chomp
  if database_hash.include?(email)
    puts "Enter the password"
    entered_password = gets.chomp  
    correct_password = database_hash[email][:password]
    if entered_password == correct_password
        user_interaction(email, database_hash)
    else
      puts "Wrong password entered"
      signin(database_hash)
    end
  else
    puts 'You have to signup first'
    signup(database_hash)
  end
end
    
def user_interaction(email, database_hash)
      puts '1.Deposit money'
      puts '2.Withdraw money'
      puts '3.Transfer money'
      puts '4.Balance Enquiry'
      puts '5.Logout'
      puts '6.Transaction history'
      puts 'enter the index of the operation to perform' 
      operation_index = gets.chomp.to_i

      case operation_index
        when 1
          puts 'Enter the amount of money to deposit'
          money_to_deposit = gets.chomp.to_i
          deposit_money(email, database_hash, money_to_deposit)
        when 2
          puts 'Enter the amount of money to withdraw'
          money_to_withdraw = gets.chomp.to_i
          withdraw_money(email, database_hash, money_to_withdraw)
        when 3
          puts 'Enter the email id of the user to transfer money'
          to_transfer_email = gets.chomp
          puts 'Enter the amount of money to transfer'
          money_to_transfer = gets.chomp.to_i
          transfer_money(email, database_hash, money_to_transfer, to_transfer_email)
        when 4
          balance_enquiry(email, database_hash)
        when 5 
          logout(email,database_hash)
        when 6  
          puts '1.Show all transactions'
          puts '2.Show transactions between two dates'
          choice = gets.chomp.to_i
          case choice
            when 1
              puts 'Transactions are as follows'
              transaction_history(database_hash,email,choice,nil,nil)
            when 2
              puts 'enter the first date (format = yyyy-mm-dd)'
              date1 = gets.chomp
              puts 'enter the second date (format = yyyy-mm-dd)'
              date2 = gets.chomp
              transaction_history(database_hash,email,choice,date1,date2)
           end
       end
end

def balance_enquiry(email, database_hash)
  puts "Your current balance is #{database_hash[email][:balance]}"
  time = Time.new
  date = Date.today.to_s
  database_hash[email][:transaction_array] << {msg: "balance enquiry, balance = #{database_hash[email][:balance]} " + time.inspect, date: date}
  user_interaction(email, database_hash)
end

def deposit_money(email, database_hash, money_to_deposit)
  new_balance = database_hash[email][:balance] + money_to_deposit
  database_hash[email][:balance] = new_balance
  puts 'Money deposited successfully'
  time = Time.new.to_s
  date = Date.today.to_s
  
  database_hash[email][:transaction_array] << { msg: "#{money_to_deposit} rupees deposited, balance = #{database_hash[email][:balance]} " + time.inspect, date: date}
  
  user_interaction(email, database_hash)
    
end  

def withdraw_money(email, database_hash, money_to_withdraw)
  new_balance = database_hash[email][:balance] - money_to_withdraw
  database_hash[email][:balance] = new_balance
  puts 'Money withdrawn successfully'
  time = Time.new
  date = Date.today.to_s
  database_hash[email][:transaction_array] << {msg: "#{money_to_withdraw} withdrawn, balance = #{new_balance} " + time.inspect, date: date}
  user_interaction(email, database_hash)
    
end  

def transfer_money(email, database_hash, money_to_transfer, to_transfer_email)
  database_hash[email][:balance] = database_hash[email][:balance] - money_to_transfer
  database_hash[to_transfer_email][:balance] = database_hash[to_transfer_email][:balance] + money_to_transfer
  puts 'Money transfered successfully'
  time = Time.new.to_s
  date = Date.today.to_s
  database_hash[email][:transaction_array] << {msg: "#{money_to_transfer} rupees transferred to #{database_hash[to_transfer_email][:name]}" + time.inspect, date: date}
  database_hash[to_transfer_email][:transaction_array] << {msg: "#{money_to_transfer} rupees recieved from #{database_hash[email][:name]}" + time.inspect, date: date}
  user_interaction(email, database_hash)
    
end

def logout(email, database_hash)
  puts '1.exit'
  puts '2.signin again'
  choice = gets.chomp.to_i
  if choice == 1
    exit
  else
    signin(database_hash)
  end
end
def transaction_history(database_hash,email,choice,date1,date2)
  i = 0
  case choice
  when 1
    puts database_hash[email][:transaction_array]
  when 2
    date_array = (date1..date2).to_a
    database_hash[email][:transaction_array].each do
      |transaction|
      if date_array.include?(transaction[:date])
        i = 1
        puts transaction[:msg]
      end
     end
    if i == 0
      puts 'You have not performed any transaction between the above dates'
  end
end   
end
signin(database_hash)

