require 'io/console'

@account = {}
@id_ctr = 1

def read_input(command, type)
  puts command
  @entered_string = yield
  while !valid?(@entered_string, type) 
    puts command
    @entered_string = yield
  end
  @entered_string
end

def valid?(entered_string, type)
  case type
    when 'name'
      return false if (/[a-z]+/ =~ @entered_string) == nil 
    when 'phone'
      return false if ((/\d{10}/) =~ @entered_string) == nil
    when 'email' 
      return false if (/^[a-z][_a-z0-9]*@[a-z]+.com/ =~ @entered_string) == nil 
    when 'amount'
      return false if (/[0-9]+/ =~ @entered_string) == nil  
    when 'id'
      if (/[0-9]+/ =~ @entered_string) == nil            
        p 'yes'
        return false
      else
        @entered_string = @entered_string.to_i
        return false unless @account.has_key?(@entered_string)
      end
  end
  return true 
end

def signup
  user_id = @id_ctr
  @id_ctr += 1 
  user_name = read_input('Enter the name : ', 'name') { gets.chomp } 
  user_password = read_input('Enter the password : ', 'password') { STDIN.noecho(&:gets).chomp }
  user_phone = read_input('Enter the phone : ', 'phone') { gets.chomp}.to_i 
  user_email = read_input('Enter the email : ', 'email') { gets.chomp }
  @account[user_id] = {name: user_name, password: user_password, email: user_email, phone: user_phone, balance: 0, transactions: []}
  user_display(user_id)
  first_menu  
end

def login 
  user_id = read_input('Enter the id : ', 'id') { gets.chomp }.to_i
  user_password = read_input('Enter the password : ', 'password') { STDIN.noecho(&:gets).chomp }
  if @account[user_id]
    if @account[user_id][:password] == user_password
      puts 'successfully logged in!'
      main_menu(user_id)           
    else
      puts 'incorrect password'
    end
  else
    puts 'incorrect id', 'Please signup...'
    signup    
  end  
end

def first_menu
  choice = read_input("Enter 1 to signup\nEnter any other key to login\n", 'choice') { gets.chomp.to_i}
  choice == 1 ? signup : login
end

def main_menu(user_id)
  print "MAIN MENU\n1. Money Deposit\n2. Withdraw Money\n3. Transaction history\n4. Money Transfer\n5. Display account info\n6. Find transactions within date \n7. Logout\nAny other key to exit..\nEnter your choice : \n"
  choice = gets.chomp.to_i 
  case choice
  when 1 
    amount = read_input('Enter the amount : ', 'amount') { gets.chomp }.to_i
    money_deposit(user_id, amount)
  when 2
    amount = read_input('Enter the amount : ', 'amount') { gets.chomp }.to_i
    withdraw_money(user_id, amount)  
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

def get_time(time)
  new_array = []
  time_array = time.match(/(\d{4})-(\d{1,2})-(\d{1,2}) (\d{2}):(\d{2})/).to_a
  time_array.each_with_index {|element, index| new_array << element.to_i unless index == 0}
  new_array
end 

def find_transactions(user_id)
  start_time = Time.new(*get_time(read_input('Enter the start date and time in the format yyyy-mm-dd HH:MM ', 'date') {gets.chomp.to_s}))
  end_time = Time.new(*get_time(read_input('Enter the end date and time in the format yyyy-mm-dd HH:MM ', 'date') {gets.chomp.to_s}))
  @account[user_id][:transactions].each do |element|
    if element[:date].between?(start_time, end_time) 
      element.each {|key, value| puts "#{key} : #{value}"}   
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    end
  end
  main_menu(user_id)
end

def view_history(user_id)
  if @account[user_id][ :transactions].empty?
    print "No transactions yet\n"
  else 
    @account[user_id][:transactions].each do |element| 
      element.each { |key,value| puts "#{key} : #{value}" }
      puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
    end 
  end
  main_menu(user_id)
end

def change_balance(user_id, type, amount)
  @account[user_id][:balance] = yield(@account[user_id][:balance], amount)
  @account[user_id][:transactions] << { type: type, amount: amount, date: Time.now }
end

def money_deposit(user_id, amount)
  p amount  
  change_balance(user_id, 'credit', amount) { |balance, amount|  balance + amount }
  puts 'Money deposited successfully'
  main_menu(user_id)
end

def withdraw_money(user_id,amount)      
  if @account[user_id][:balance] > amount && @account[user_id][:balance] > 0
    change_balance(user_id, 'debit', amount) { |balance, amount| balance - amount }
    puts 'Money withdrawn successfully' 
  else 
    puts 'Not enough amount in balance '
  end
  main_menu(user_id)
end

def user_display(user_id)
  print "id = #{user_id}\n"
  @account[user_id].each { |key, value| print "#{key} = #{value}\n" unless key == :transactions }
  puts '~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'
end

def transfer_money(user_id)
  receiver_id = read_input('Enter the id of the receiver : ', 'id') { gets.chomp }.to_i
  amount = read_input('Enter the amount : ', 'amount') { gets.chomp }.to_i
  while(amount > @account[user_id][:balance])
    puts 'Not enough balance to transfer'
    amount = read_input('Enter the amount : ', 'amount') { gets.chomp }.to_i
  end
  change_balance(user_id, 'debit', amount) { |balance, amount|  balance - amount }
  change_balance(receiver_id, 'credit', amount) { |balance, amount|  balance + amount }

  puts 'Money Transfered successfully'
  user_display(user_id)
  user_display(receiver_id)
  main_menu(user_id)
end
first_menu
