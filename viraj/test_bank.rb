# bank program

require 'time'
# each user is stored as a hash e.g. #user = {balance: 765, password: "asda"}
# every such user hash is stored in a hash called users_list
users_list = {logged_in_user_id: false}

# HOW TRANSACTIONS ARE STORED
# transactions = {user_id1: [{}, {}, {}], user_id1: [{}, {}, {}]}
# user_transactions = [{}, {}, {}]
transactions = {}

# made global to conveniently check if a user is logged in or not
users_list[:logged_in_user_id] = false

def get_valid_num(message)
  puts message
  loop do
    amount = gets.chomp.to_i
    return amount if amount > 0
    puts 'Invalid input'
  end
end

def get_valid_input(message, regex)
  puts message
  loop do
    input = gets.chomp.to_s
    return input if input.match?(regex)
    puts 'Invalid input'
  end
end

def register(users_list:, transactions:, user_name:, password:, phone:, email:)
  # new user_id is generated using the lenght of the hash 'users_list'
  new_user_id = users_list.length + 1
  new_user = { balance: 0,
               password: password,
               user_name: user_name,
               phone: phone,
               email: email }

  users_list[new_user_id] = new_user

  transactions[new_user_id] = []

  users_list[:logged_in_user_id] = new_user_id
  puts "Registration successful. Your ID is #{users_list[:logged_in_user_id]}."

  users_list[:logged_in_user_id] = new_user_id
  true
end

def login(users_list)
  user_id = get_valid_num('Enter User ID: ')
  unless users_list[user_id]
    puts 'User ID doesn\'t exist.\n'
    return false
  end
  if get_valid_password('Enter password: ') == users_list[user_id][:password]
    users_list[:logged_in_user_id] = user_id
    puts "User #{user_id} logged in."
    true
  else
    puts 'Wrong password'
    false
  end
end

def save_transaction(transactions, user_id, type, amount, transfer_user_id, balance, transaction_time, action)
  transactions[user_id] << {
    type: type,
    amount: amount,
    transfer_user_id: transfer_user_id,
    balance: balance,
    transaction_time: transaction_time,
    action: action
  }
end

# works for 'deposit' and 'withdraw'
def transact(users_list, user, transactions, amount)
  if block_given?
    transact_info = yield()
    user[:balance] = transact_info[:balance].to_i

    save_transaction(transactions, users_list[:logged_in_user_id], transact_info[:type], amount, nil, user[:balance], Time.now, nil)

    puts transact_info[:message]
  else
    puts 'Pass proper block'
  end
end

def deposit(users_list, transactions, amount)
  transact(users_list, users_list[users_list[:logged_in_user_id]], transactions, amount) do
    { balance: users_list[users_list[:logged_in_user_id]][:balance] + amount,
      type: 'Deposit',
      message: 'Deposit successful' }
  end
end

def withdraw(users_list, transactions, amount)
  transact(users_list, users_list[users_list[:logged_in_user_id]], transactions, amount) do
    if users_list[users_list[:logged_in_user_id]][:balance] < amount
      puts 'Insufficient balance'
      return false
    end
    { balance: users_list[users_list[:logged_in_user_id]][:balance] - amount,
      type: 'Withdraw',
      message: 'Withdraw successful' }
  end
  true
end

def transfer(users_list, transactions, transfer_user_id, amount)
  if users_list[users_list[:logged_in_user_id]][:balance] >= amount
    users_list[users_list[:logged_in_user_id]][:balance] -= amount
    users_list[transfer_user_id][:balance] += amount

    save_transaction(transactions, users_list[:logged_in_user_id], 'Transfer', amount, transfer_user_id, users_list[users_list[:logged_in_user_id]][:balance], Time.now, 'To')

    save_transaction(transactions, transfer_user_id, 'Transfer', amount, transfer_user_id, users_list[transfer_user_id][:balance], Time.now, 'From')

    puts "Transfer of #{amount} to User #{transfer_user_id} is successful."
  else
    puts "You do not have #{amount} rupees in your account."
  end
end

def transfer_validate(users_list, transactions, transfer_user_id, amount)
  if transfer_user_id != users_list[:logged_in_user_id]
    if users_list[transfer_user_id]
      transfer(users_list, transactions, transfer_user_id, amount)
    else
      puts 'The user ID you entered does not exist.'
    end
  else
    puts 'You cannot transfer to your own account.'
  end
end

def show_history(user_transactions)
# WE GET:
# user_transactions = [{}, {}, {}]
# transaction = {type: 'transfer', amount: 100, transfer_user_id = 2, balance: 1000, time: Time}
  puts 'Transaction History:\n'
  puts '_______________________________________________________'
  puts '#\tType\t\tAmount    \t\tBalance \tTime'
  puts '_______________________________________________________'
  user_transactions.each_with_index do |transaction, count|
    puts "#{count + 1}\t#{transaction[:type]} \t#{transaction[:amount]}#{transaction[:transfer_user_id] ? ('(' + transaction[:action] + ': ' + transaction[:transfer_user_id].to_s + ')') : '     '}\t\t#{transaction[:balance]} \t#{transaction[:transaction_time]}"
  end
end

def transactions_for_duration(user_transactions)
  # error handling not done
  puts 'Enter start time: (e.g: \'9 jan 2018 16:35:20\')'
  start_time = Time.parse(gets).to_i

  puts 'Enter start time: (e.g: \'9 jan 2018 16:35:20\')'
  end_time = Time.parse(gets).to_i

  puts '_______________________________________________________'
  puts '#\tType\t\tAmount    \t\tBalance \tTime'
  puts '_______________________________________________________'
  user_transactions.each_with_index do |transaction, count|
    if transaction[:transaction_time].to_i >= start_time && transaction[:transaction_time].to_i <= end_time
      puts "#{count + 1}\t#{transaction[:type]} \t#{transaction[:amount]}#{transaction[:transfer_user_id] ? ('(To: ' + transaction[:transfer_user_id].to_s + ')') : '     '}\t\t#{transaction[:balance]} \t#{transaction[:transaction_time]}"
    end
  end
end


# execution starts here:
loop do
  puts "\n1. Login\n2. Register\n3. Exit"
  case gets.chomp.to_i
  when 1
    system 'clear'
    next unless login(users_list)
  when 2
    system 'clear'
    new_user = { users_list: users_list,
                 transactions: transactions,
                 user_name: get_valid_input('Enter name: (<first_name> <space> <last_name>)', /\A[a-zA-Z]+\s[a-zA-Z]+/),
                 password: get_valid_input('Enter new password. (6 digit, Numbers, letters allowed)', /\A[a-zA-Z\d]{6}\z/),
                 phone: get_valid_input('Enter phone number: ', /\A[\d]{10}\z/),
                 email: get_valid_input('Enter email ID: ', /^[a-z][_a-z0-9]*@[a-z]+\.[a-z]+\z/) }
    register(new_user)
  when 3
    exit
  else
    system 'clear'
    puts 'Enter valid option.'
    next
  end

  # loops until user logs out
  loop do
    puts '______________________________'
    puts "\n[Balance: #{users_list[users_list[:logged_in_user_id]][:balance]}] [User ID: #{users_list[:logged_in_user_id]}]"
    puts '______________________________'
    puts "\n1. Deposit\n2. Withdraw\n3. Transfer\n4. Show history\n5. Find Transactions for a duration\n6. Logout\n7. Exit"

    case gets.to_i
    when 1
      system 'clear'
      deposit(users_list, transactions, get_valid_num('Enter amount: '))
      show_history(transactions[users_list[:logged_in_user_id]])
    when 2
      system 'clear'
      next unless withdraw(users_list, transactions, get_valid_num('Enter amount: '))
      show_history(transactions[users_list[:logged_in_user_id]])
    when 3
      system 'clear'
      transfer_validate(users_list, transactions, get_valid_num('Enter user ID to transfer money'), get_valid_num('Enter amount'))
      show_history(transactions[users_list[:logged_in_user_id]])
    when 4
      system 'clear'
      show_history(transactions[users_list[:logged_in_user_id]])
    when 5
      system 'clear'
      transactions_for_duration(transactions[users_list[:logged_in_user_id]])
    when 6
      system 'clear'
      users_list[:logged_in_user_id] = false
      break
    when 7
      exit
    else
      puts 'Enter valid option.'
    end
  end
end
