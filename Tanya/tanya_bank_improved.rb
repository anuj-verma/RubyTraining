require 'date'
users = {
  tanyasaroha: {
    name: 'Tanya Saroha',
    password: '12345',
    email: 'tanya@gmail.com',
    balance: 50_000,
    transaction_history: [{ transaction: 'Debited 20000', date: '2018-01-08' },
                          { transaction: 'Debited 30000', date: '2018-01-07' }]
  },
  priyanka: {
    name: 'Priyanka Yadav',
    password: '12345',
    email: 'priyank@josh.com',
    balance: 23_000,
    transaction_history: [{ transaction: 'Debited 23000', date: '2018-01-08' }]
  },
  pinky: {
    name: 'Pinky Rout',
    password: '123456',
    email: 'pinky@gmail.com',
    balance: 30_000,
    transaction_history: [{ transaction: 'Debited 30000', date: '2018-01-08' }]
  }
}

def get_input(message)
  print message
  not_empty = /[^''|' ']/
  input = gets.chomp
  if input.match? not_empty
    input
  else
    puts 'Please Enter Something'
    get_input(message)
  end
end

def username_validation(users, user_name)
  user_name = username_validation(users, get_input('Already Exists, Enter again: ').to_sym) until users[user_name].nil?
  user_name
end

def amount_validation(amount)
  amount_valid = /\A0*[.][0-9]+\z|\A[0-9]+[.][0-9]+\z|\A[0-9]+\z/
  if amount.match? amount_valid
    while amount.to_f <= 0
      amount = amount_validation(get_input('Less tha zero! Enter again: '))
    end
  else
    amount = amount_validation(get_input('Invalid! Enter again: '))
  end
  amount
end

def full_name_validation(full_name)
  name_valid = /\A[A-Z][a-z]* [A-Z][a-z]*+\z/
  if full_name.match? name_valid
    full_name
  else
    full_name_validation(get_input('Enter full name please: '))
  end
end

def password_validation(password)
  valid_password = /(?=.*[a-z])(?=.*[A-z])(?=.*[0-9])(?=.*\W)/
  if password.match? valid_password
    password
  else
    password_validation(get_input('Password not Strong.E nter Again:-'))
  end
end

def email_validation(email)
  valid_email = /\A[A-Za-z0-9\W]+*@[A-Za-z0-9\W]+[.][a-z]+\z/
  if email.match? valid_email
    email
  else
    email_validation(get_input('Enter EMail again:- '))
  end
end

def check_password(users, user_name, user_password)
  user_password = check_password(users, user_name, get_input('Wrong Password! Password: ')) while users[user_name][:password] != user_password
  user_password
end

def check_username(users, user_name)
  user_name = check_username(users, get_input('Wrong Username. Username: ').to_sym) while users[user_name].nil?
  user_name
end

def register(users)
  new_username = username_validation(users, get_input('Username:').to_sym)
  new_password = password_validation(get_input('Password: '))
  new_name = full_name_validation(get_input('Name: '))
  new_email = email_validation(get_input('EMail-ID:- '))
  amount = amount_validation(get_input('Deposit some amount ')).to_i
  enter_user(users, new_username, new_password, new_name, new_email, amount)
  new_username
end

def enter_user(users, username, password, name, email, amount)
  new_users = {
    username => {
      name: name,
      password: password,
      email: email,
      balance: amount,
      transaction_history: [{ transaction: "Added #{amount}", date: Date.today.to_s }]
    }
  }
  users.merge!(new_users)
  puts users
end

def log_in(users)
  user_name = check_username(users, get_input('Username:').to_sym)
  check_password(users, user_name, get_input('Password:'))
  puts "Welcome #{user_name}"
  user_name
end

def withdraw_validation(users, username, amount)
  while users[username][:balance] < amount
    puts "Balance is #{users[username][:balance]}.Can't transact #{amount}"
    amount = amount_validation(get_input('Amount to be withdrawn:- ').to_i)
  end
  amount
end

def update_history(users, user_name, amount, message)
  date = Date.today.to_s
  new_transaction = { transaction: message + amount.to_s, date: date }
  users[user_name][:transaction_history] << new_transaction
end

def deposit(users, user_name, amount)
  users[user_name][:balance] = users[user_name][:balance] + amount
  update_history(users, user_name, amount, 'Deposited: ')
  users[user_name][:balance]
end

def withdraw(users, user_name, amount)
  users[user_name][:balance] = users[user_name][:balance] - amount
  update_history(users, user_name, amount, 'Withdrew: ')
  users[user_name][:balance]
end

def transfer(users, sender, receiver, transfer_amount)
  users[sender][:balance] -= transfer_amount
  users[receiver][:balance] += transfer_amount
  update_history(users, sender, transfer_amount, 'transferred amount  ')
  update_history(users, receiver, transfer_amount, 'Received amount ')
  users[sender][:balance]
end

def welcome(users)
  first_menu = ['Welcome User', '1. Register', '2. Log in', '3. Exit']
  puts first_menu
  case gets.chomp.to_i
  when 1
    register(users)
  when 2
    log_in(users)
  when 3
    puts 'Thanks for visiting'
    nil
  else
    puts 'Invalid choice! Enter again'
    welcome(users)
  end
end

def menu(users, user_name)
  loop do
    menu_items = ['Select Option', '1. View Balance', '2. Deposit', '3. Withdraw', '4. Transfer', '5. Transaction History', '6. Transaction history between dates', '7. Logout']
    puts menu_items
    choice2 = gets.chomp.to_i
    case choice2
    when 1
      puts users[user_name][:balance]
    when 2
      deposit_amount = amount_validation(get_input('Deposit Amount:- ')).to_i
      updated_balance = deposit(users, user_name, deposit_amount)
      puts "#{deposit_amount} Deposited. Now balance:- #{updated_balance}"
    when 3
      withdraw_amount = amount_validation(get_input('Withdraw Amount:- ')).to_i
      withdraw_amount = withdraw_validation(users, user_name, withdraw_amount)
      updated_balance = withdraw(users, user_name, withdraw_amount)
      puts "#{withdraw_amount} Withdrawn. Now balance:- #{updated_balance}"
    when 4
      receiver = check_username(users, get_input('Receiver Username').to_sym)
      amount = amount_validation(get_input('Amount to be Transferred:- ')).to_i
      amount = withdraw_validation(users, user_name, amount)
      updated_balance = transfer(users, user_name, receiver, amount)
      puts "#{amount} transferred to #{users[receiver][:name]}.Balance #{updated_balance}"
    when 5
      users[user_name][:transaction_history].each { |t| puts "#{t[:transaction]} #{t[:date]}" }
    when 6
      puts 'You have chosen to view history of transactions between two dates'
      from_date = get_input('Starting date (In the format YYYY-MM-DD) ')
      to_date = get_input('Ending date (In the format YYYY-MM-DD) ')
      date_range = (from_date..to_date).to_a
      users[user_name][:transaction_history].each do |t|
        puts "#{t[:transaction]}" if date_range.include? t[:date]
      end
    when 7
      puts "Bye #{user_name}"
      user_name = welcome(users)
    else
      puts 'Invalid choice. Please select carefully'
    end
    break if choice2 == 7
  end
  user_name
end

user_name = welcome(users)
user_name = menu(users, user_name) until user_name.nil?
