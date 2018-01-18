require 'date'
user_information = {'rahul': {email: 'rahul', password: 'rahul', balance: 0.0}, 'rj': {email: 'rj', password: '123', balance: 0.0}}
transaction_history = {}

def login(user_id)
 if user_id
    puts 'enter password'
    pass_word = gets.chop
    if user_id[:password] == pass_word
      return user_id
    else
      puts 'Invalid Password'
      return nil
    end
  else
   puts 'User does not Exist!'
  end
end

def new_user(user_information , user_name , pass_word)
  user_information.merge!(:"#{user_name}" => {:email => "#{user_name}", :password => "#{pass_word}", :balance => 0.0})
end

def store_history(user_id , transaction_history , history , time , total)
  transaction_history[:user_id] << ({time: "#{time}", info: " #{history}", total: total})
end

def get_time()
  time = Time.now
  return time.strftime("%Y-%m-%d %H:%M:%S")
end

def deposit(user_id , amount , transaction_history)
  total = user_id[:balance] += amount
  time = get_time()
  deposit_history = "deposited => #{amount}"
  store_history(user_id , transaction_history , deposit_history , time , total)
end

def withdraw(user_id , amount , transaction_history)
  if (user_id[:balance] - amount) >= 0.0
    total = user_id[:balance] -= amount
    time = get_time()
    withdraw_history = "withdraw => #{amount}"
    store_history(user_id , transaction_history , withdraw_history , time , total)
  else
    puts 'balance is LOW.'
  end
end

def money_transfer(user_id , receiver_id , amount , transaction_history)
  if receiver_id
    if (user_id[:balance] - amount) >= 0.0
      receiver_id[:balance] += amount
      total = user_id[:balance] -= amount
      time = get_time()
      transfer_history = "Transfered to #{receiver_id[:email]} => #{amount}"
      store_history(user_id , transaction_history , transfer_history , time , total)
    else
      puts 'balance is LOW.'
    end
  else
    puts 'invalid user.'
  end
end
  
def transaction_info(transaction_history , user_id , start_date , end_date)
  transaction_history[:user_id].select do |transaction| 
    if Date.parse(start_date) <= Date.parse(transaction[:time]) && Date.parse(transaction[:time]) <= Date.parse(end_date)
      p transaction
    end
  end 
end

def check_balance(user_id)
  puts user_id[:balance]
end

def banking_options(user_information , transaction_history)
  iterator = 0
  while iterator != 3 do
    puts "Enter \n 1.Login \n 2.Register \n 3.exit"
    iterator = gets.chop.to_i
    case iterator
    when 1
      puts "LOGIN: \n enter username"
      user_name = gets.chop
      user = user_information[:"#{user_name}"]
      user_id = login(user)
      if user_id != nil
        puts 'Welcome!!'
	transaction_history[:user_id] = []	        
	opt = 0;
        while opt != 6 do
          puts "Enter \n 1.Deposit \n 2.Withdraw \n 3.Money Transfer \n 4.Transaction history \n 5.Check balance \n 6.Logout"
          opt = gets.chop.to_i
          case opt
          when 1, 2, 3
            puts 'Enter amount'
            amount = gets.chop.to_f
            if amount <= 0.0
              puts 'enter valid amount'
            else
            case opt
            when 1
              deposit(user_id , amount , transaction_history)
            when 2
              withdraw(user_id , amount , transaction_history)
            when 3
              puts "enter receiver id"
              receiver_account = gets.chop
              receiver_id = user_information[:"#{receiver_account}"]
              money_transfer(user_id , receiver_id , amount , transaction_history)
            end
            end
          when 4
            puts 'starting date(yy-mm-dd)'
            start_date = gets.chop
            puts 'ending date(yy-mm-dd)'
            end_date = gets.chop
            transaction_info(transaction_history , user_id , start_date , end_date)
          when 5
            check_balance(user_id)
          end
        end 
      end
    when 2
      puts "REGISTER: \n enter email (as username)"
      user_name = gets.chop
      if user_name == ''
        puts 'enter valid username'
i      else
      puts 'enter password'
      pass_word = gets.chop
        if pass_word == ''
          puts 'enter valid password'
        else
          puts 'user is added' if new_user(user_information , user_name , pass_word)
        end
      end
    end
  end
end

banking_options(user_information , transaction_history)
