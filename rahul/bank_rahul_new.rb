require 'date'
user_information = { 
  'rahul': { 
    name: 'rahul', 
    password: 'rahul', 
    balance: 0.0
   }, 
  'rj': {
    name: 'rj', 
    password: '123', 
    balance: 0.0
  }
}
transaction_history = {}

def login(user_info)
  return perform_io('User does not Exist!') if user_info.nil?
  pass_word = perform_io('enter password') { gets.chop }
  return perform_io('Invalid Password') if user_info[:password] != pass_word
  return user_info
end

def new_user(user_information, user_name, pass_word)
  user_information.merge!(
	user_name.to_sym => {
    name: user_name, password: pass_word, balance:  0.0
		}
	)
end

def current_time
  time = Time.now
  return time.strftime("%Y-%m-%d %H:%M:%S")
end

def perform_io(type)
  puts "#{type}"
  yield if block_given?
end

def store_history(user_info, transaction_history, history, time, total, amount)
  transaction_history[:user_info] << ({
	time: time, 
	info: {
		operation: history, amount: amount, balance: total
		}
	})
end

def deposit(user_info, amount, transaction_history)
  store_history(
								user_info, 
								transaction_history, 
								'deposited', 
								current_time, 
								user_info[:balance] += amount, 
								amount
								)
end

def withdraw(user_info, amount, transaction_history)
  return perform_io('Balance is LOW.') if (user_info[:balance] - amount) <= 0.0
  store_history(
								user_info, 
								transaction_history, 
								'withdraw', 
								current_time, 
								user_info[:balance] -= amount, 
								amount
								)
end

def money_transfer(user_info, receiver_info, amount, transaction_history)
  return perform_io('Invalid User') if receiver_info.nil?
  return perform_io('Balance in LOW') if (user_info[:balance] - amount) <= 0.0
  receiver_info[:balance] += amount
  store_history(
								user_info, 
								transaction_history, 
								"Transfered to #{receiver_info[:email]}", 
								current_time, 
								user_info[:balance] -= amount, 
								amount
								)
end
  
def transaction_info(transaction_history, user_info, start_date, end_date)
  transactions = transaction_history[:user_info].select do |transaction| 
  Date.parse(start_date) <= Date.parse(transaction[:time]) && 
				Date.parse(transaction[:time]) <= Date.parse(end_date)
  end
  puts transactions 
end

def check_balance(user_info)
  puts user_info[:balance]
end

def operations(user_information, user_info, transaction_history)
  perform_io('welcome')
  transaction_history[:user_info] = []	        
  opt = 0
  while opt != 6 do
    opt = perform_io("1.Deposit\n2.Withdraw\n3.Money Transfer\n4.Transaction history\n5.Check balance\n6.Logout") { gets.chop.to_i }
    case opt
    when 1, 2, 3
    	amount = perform_io('Enter amount') { gets.chop.to_f }
    	next perform_io('enter valid amount') if amount <= 0.0
      case opt
      when 1
        deposit(user_info, amount, transaction_history)
      when 2
        withdraw(user_info, amount, transaction_history)
      when 3
        receiver_account = perform_io('enter receiver id') { gets.chop }
        receiver_info = user_information[receiver_account.to_sym]
        money_transfer(user_info, receiver_info, amount, transaction_history)
      end
    when 4
      start_date = perform_io('starting date(yy-mm-dd)') { gets.chop }
      end_date = perform_io('ending date(yy-mm-dd)') { gets.chop }
      perform_io('Transaction History')
      transaction_info(transaction_history, user_info, start_date, end_date)
    when 5
      check_balance(user_info)
    end
  end
end

def banking_options(user_information, transaction_history)
  iterator = 0
  while iterator != 3 do
    iterator = perform_io("1.Login\n2.Register\n3.exit") { gets.chop.to_i }
    case iterator
    when 1
    	user_name = perform_io("LOGIN:\nenter username") { gets.chop }
    	user_info = login(user_information[user_name.to_sym])
    	operations(user_information, user_info, transaction_history) if user_info.class.equal?(Hash)
    when 2
    	user_name = perform_io("REGISTER:\nenter username") { gets.chop }
			break perform_io('User already exist') if user_information[user_name.to_sym]
    	break perform_io('enter valid username') if /^[a-zA-Z\d]+\Z/.match(user_name).nil?
    	pass_word = perform_io('enter password') { gets.chop }
    	break perform_io('enter valid password') if /^[a-zA-Z\d]+\Z/.match(pass_word).nil?
    	perform_io('user is added') if new_user(user_information, user_name, pass_word)
    end
  end
end

banking_options(user_information, transaction_history)
