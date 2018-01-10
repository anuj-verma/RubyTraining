account = Hash[:jyoti => Hash[:password => "abc",:name => "Jyoti Sharma", :balance => 200, :history => Hash[]]]

def new_user(account) 
  puts "***New User***\nEnter username : "
  logged_username = gets.chomp
  puts 'Enter password : '
  password = gets.chomp
  puts "Enter Name : "
  name = gets.chomp
  account.store(logged_username.to_sym, Hash[:password => password, :name => name, :balance => 0, :history => Hash[]])
  display_menu(logged_username,account)
end

def login(account)
  puts "***LOGIN***\nEnter Username : "
    logged_username = gets.chomp
    if account.include?(logged_username.to_sym)
      puts "Enter password : "
      password =gets.chomp 
      if account[logged_username.to_sym][:password] == password
        puts "Password Matched"
        display_menu(logged_username, account)
      else
        puts "Password not matched \nNew User"
        new_user(account)
      end
    else
      new_user(account)
    
    end
end

def withdraw(logged_username, amount,account)
  puts "Available Balance : #{account[logged_username.to_sym][:balance]}"
	if account[logged_username.to_sym][:balance].to_i < amount.to_i
    puts "Not Sufficient Balance"
    display_menu(logged_username,account)
  else
    account[logged_username.to_sym][:balance] = account[logged_username.to_sym][:balance].to_i - amount.to_i
    puts "New Balance : #{account[logged_username.to_sym][:balance]}"
    require 'date'
    date = DateTime.now
   #time = date.strftime("%H:%M:%S")
    timestr = date.to_s
    account[logged_username.to_sym][:history].store(timestr,Hash[:action =>"Withdraw", :amount => amount.to_i])
    display_menu(logged_username, account)
end
end

def deposit(logged_username, amount, account)
  puts "Available Balance : #{account[logged_username.to_sym][:balance]}"
  account[logged_username.to_sym][:balance] = account[logged_username.to_sym][:balance].to_i + amount.to_i
  require 'date'
  date = DateTime.now
 # time = date.strftime("%H:%M:%S")
  timestr = date.to_s
  account[logged_username.to_sym][:history].store(timestr,Hash[:action =>"Deposit", :amount => amount.to_i])
  puts "New Balance : #{account[logged_username.to_sym][:balance]}"
  display_menu(logged_username, account)
end
	
def transfer (logged_username, account)
  require 'date'
  date = DateTime.now
  #time = date.strftime("%H:%M:%S")
  timestr = date.to_s
  puts "\nTransfering money.....\nEnter username of that account:"
  username = gets.chomp 
  if(account.include?(username.to_sym))
    puts "\nEnter amount to be transfered : "
    amount = gets.to_i
  	if account[logged_username.to_sym][:balance].to_i < amount.to_i
      puts "Not Sufficient Balance"
      display_menu(logged_username,account)
  	else
      account[logged_username.to_sym][:balance] = account[logged_username.to_sym][:balance].to_i - amount.to_i 
      account[username.to_sym][:balance] = account[username.to_sym][:balance].to_i + amount.to_i
      account[logged_username.to_sym][:history].store(timestr,Hash[:action =>"Transfer", :amount => amount.to_i])
      display_menu(logged_username, account)
  	end
  else
    puts "Username Not found"
    display_menu(logged_username,account)
  end
end  

def all_history(logged_username,account)
  account[logged_username.to_sym][:history].each {|key,value| puts "#{key}----#{value}"}
  puts "Total Balance : #{account[logged_username.to_sym][:balance]}"
  time_history(logged_username,account)
  display_menu(logged_username,account)
end  

def time_history(logged_username,account)
  puts "\nEnter date from in 24hrs : "
  fromtime = gets.chomp
  puts "\nEnter date to in 24 hrs : "
  totime = gets.chomp
  account[logged_username.to_sym][:history].each {|key,value| puts"#{key}----> #{value}" if (Date.parse(key).between?(Date.parse(fromtime),Date.parse(totime))  )}
  puts "Total Balance : #{account[logged_username.to_sym][:balance]}"
  display_menu(logged_username,account)
end  

def display_menu (logged_username,account)
  puts "\n***MENU***\n1.Deposit Money\n2.Withdraw Money\n3.View Transaction History\n4.Transfer Money\n5.Exit\n6.Logout\n"
	puts "\n\nEnter your choice : \n"
  choice_function(logged_username, account)
end

def choice_function (logged_username, account) 
  choice = gets 
  choice = choice.chomp.to_i
  puts "Your choice : #{choice}"
  case choice
  when 1 
    puts"Depositing.....\nEnter amount to be deposited : \n"
    deposit_amount = gets 
    deposit(logged_username, deposit_amount, account)
    display_menu(logged_username, account)
	  choice_function(logged_username, account)
  when 2
    puts "\nWithdrawing.....\nEnter amount to be withdrawn : \n"
	  withdraw_amount = gets
    withdraw(logged_username, withdraw_amount, account)
    display_menu(logged_username, account)
	  choice_function(logged_username, account)
  when 3
    all_history(logged_username,account)
  when 4
    transfer(logged_username, account)
  when 5
    puts "\n*** THANK YOU !!!***\n"
	  exit (0) 
  when 6 
    puts "\n Logged out successfully!!!\n"
	  login(account)
	else
	  puts "\nSelect proper option!!!\n"
	  display_menu(logged_username, account)
	  end
end

login(account)
