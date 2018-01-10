@account = {}
@id_ctr = 1

def signup

    user_id = @id_ctr
    @id_ctr += 1 
    puts 'Enter the name : '
    user_name = gets.chomp 
    puts 'Enter the password : '
    user_password = gets.chomp

    puts 'Enter the phone : '
    user_phone = gets.chomp.to_i  
    @account[user_id] = { name: user_name , password: user_password, phone: user_phone,balance: 0,transactions: []}
    user_display(user_id)
  first_menu  
end


def login 

  puts 'Enter the id : '
  user_id = gets.chomp.to_i
  puts 'Enter the password : '
  user_password = gets.chomp
  
  if @account[user_id]
    if @account[user_id][:password] == user_password
      puts 'successfully logged in!'
      main_menu(user_id)           
    else
      puts 'incorrect password'
    end
  else
    puts 'incorrect id'
    puts 'Please signup...'
    signup    
  end  
end

def first_menu
  print "Enter 1 to signup\nEnter any other key to login\n"
  choice = gets.chomp.to_i
	choice == 1 ? signup : login
end

def main_menu(user_id)
  print "MAIN MENU\n1. Money Deposit\n2. Withdraw Money\n3. Transaction history\n4. Money Transfer\n5. Display account info\n6. Find transactions within date \n7. Logout\nEnter your choice : "
  choice = gets.chomp.to_i 
	case choice
  when 1 
		money_deposit(user_id)
  when 2
    withdraw_money(user_id)  
  when 3
    view_history(user_id)
  when 4
    transfer_money(user_id)
  when 5
    user_display(user_id) 
    main_menu(user_id)
  when 6
      find_transactions(user_id)
  when 7 
    first_menu
  end
end


def credit(user_id, amount)
  @account[user_id][:balance] += amount
  @account[user_id][:transactions] << { type: 'credit', amount: amount, date: Time.now }
end

def debit(user_id, amount)
  @account[user_id][:balance] -= amount
  @account[user_id][:transactions] << { type: 'debit', amount: amount, date: Time.now}
end


def find_transactions(user_id)
  puts 'Enter the start time in the format - YYYY,MM,DD,HH,MM,SS' 
  start_time = Time.new(*gets.chomp.split(",").map(&:to_i))
  puts 'Enter the end time in the format - YYYY,MM,DD,HH,DD,SS'
  end_time = Time.new(*gets.chomp.split(",").map(&:to_i))
  @account[user_id][:transactions].each do |element|
    if element[:date].between?(start_time, end_time) 
      element.each {|key, value| puts "#{key} : #{value}"}   
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    end
  end
  main_menu(user_id)
end

def view_history(user_id)
  if @account[user_id][:transactions].empty?
    print "No transactions yet\n"
  else 
    @account[user_id][:transactions].each do |element| 
      element.each {|key,value| puts "#{key} : #{value}"}
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    end 
  end
  main_menu(user_id)
end

def money_deposit(user_id)
  
  puts 'Enter the amount : '
  amount  = gets.chomp.to_i
	credit(user_id, amount)
  puts 'Money deposited successfully'
	main_menu(user_id)

end

def withdraw_money(user_id)
  puts 'Enter the amount : '
  amount = gets.chomp.to_i
  if @account[user_id][:balance] > 0    
    debit(user_id, amount)
		puts 'Money withdrawn successfully' 
  else
    puts 'Not enough amount in balance' 
  end
	main_menu(user_id)
end

def user_display(user_id)
  print "id = #{user_id}\n"
  @account[user_id].each { |key, value| print "#{key} = #{value}\n" unless key == :transactions }
  puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
end

def transfer_money(user_id)
  puts 'Enter the id of the receiver : '
  receiver = gets.chomp.to_i
  puts 'Enter the amount : '
  amount = gets.chomp.to_i
  while(amount > @account[user_id][:balance])
    puts 'Not enough balance to transfer'
    puts 'Enter the amount : '
    amount = gets.chomp.to_i
	end
  debit(user_id, amount)
  credit(receiver, amount)
  puts 'Money Transfered successfully'
  user_display(user_id)
	user_display(receiver)
	main_menu(user_id)
end

first_menu
