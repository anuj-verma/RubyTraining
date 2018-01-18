require 'date'
user_information = { id1: { name: 'priyanka',
                            password: 'abc',
                            amount: 0,
                            transactions: [
                              { transaction: '100.0 Rs CREDITED',
                                date: '2017-11-09' },
                              { transaction: '100.0 Rs DEBITED',
                                date: '2018-01-01' }
                            ] },
                      id2: { name: 'tanya', password: 'abc', amount: 0, transactions: [] } }
def deposit(user_information, id, amount)
  update_amount(user_information, id, amount, 'credited')
  p "#{amount} rs Credited"
end

def withdraw(user_information, id, amount)
  return p 'Insufficient Balance' unless user_information[id][:amount] >= amount
  update_amount(user_information, id, -amount, 'debited')
  p "#{amount} RS Debited"
end

def update_amount(user_information, id, amount, msg)
  user_information[id][:amount] += amount
  amount = -amount if amount < 0
  new_hash = { transaction: "#{amount} RS #{msg} ", date: Date.today.to_s }
  user_information[id][:transactions] << new_hash
end

def transfer(user_info, from, to, amount)
  return p 'Insufficient Balance' unless user_info[from][:amount] >= amount
  p "#{amount} RS Transfered to #{to}"
  update_amount(user_info, to, amount, 'credited')
  update_amount(user_info, from, -amount, 'debited')
end

def validate_input(expr, input)
  expr.match?(input)
end

def read_input(expr, msg, msg2)
  p msg2
  input = gets.chomp
  return input if validate_input(expr, input)
  until validate_input(expr, input)
    p "Invalid #{msg} Please Enter Again"
    input = gets.chomp
  end
  input
end

def enter_amount
  p 'Enter amount'
  amount = gets.chomp
  return amount.to_f if validate_input(/\A[0-9]+\z/, amount) && amount.to_f > 0
  loop do
    p 'Enter Valid amount'
    amount = gets.chomp
    break if validate_input(/\A[0-9]+\z/, amount) && amount.to_f > 0
  end
  amount.to_f
end

def check_dates(date1, date2)
  return false if Date.parse(date2) < Date.parse(date1)
  true
end

def show_transactions(user_information, id, first_date, last_date)
  user_information[id][:transactions].each do |transaction|
    range = (first_date..last_date)
    result = "#{transaction[:transaction]} ON #{transaction[:date]}"
    p result if range.include?(transaction[:date])
  end
end

def recipient_userid(user_information, id, expr)
  to = read_input(expr, 'ID', 'ID,must not contain spaces').to_sym
  return to if !user_information[to].nil? && to != id
  p ' enter valid user id '
  recipient_userid(user_information, id, expr)
end

def read_date
  regex = /\A\d{4}-\d{2}-\d{2}\z/
  date = gets.chomp
  return date if regex.match?(date)
  p 'Invalid date,enter date in yyyy-mm-dd format'
  read_date
end

def review_transaction(user_info, id)
  p 'enter from date in yyyy-mm-dd format'
  from = read_date
  p 'enter from to in yyyy-mm-dd format'
  to = read_date
  return show_transactions(user_info, id, from, to) if check_dates(from, to)
  p ' Invalid to date'
  review_transaction(user_info, id)
end

def operations(user_information, id, idexp)
  loop do
    p 'CHOOSE OPTION'
    p '1.Deposit  2.Withdraw 3.transfer 4.review transaction 5.Available Balance 6.exit'
    option = gets.chomp
    case option
    when '1'
      amount = enter_amount
      deposit(user_information, id, amount)
    when '2'
      amount = enter_amount
      withdraw(user_information, id, amount)
    when '3'
      p 'Enter Recipient ID'
      to = recipient_userid(user_information,	id, idexp)
      amount = enter_amount
      transfer(user_information, id, to, amount)
    when '4'
      review_transaction(user_information, id)
    when '5'
      p "Available Balance : #{user_information[id][:amount]} rs"
    end
    break unless option != '6'
  end
end

def verify_password(user_information, id)
  p 'Enter Password'
  password = gets.chomp
  return true if user_information[id][:password] == password
  p 'Wrong Password'
  verify_password(user_information, id)
end

def login(user_information, idexp)
  p 'Enter ID'
  id = read_input(idexp, 'ID', 'ID must not contain spaces and empty string').to_sym
  return p 'ID Does Not Exist Signup First' unless !user_information[id].nil?
  operations(user_information, id, idexp) if verify_password(user_information, id)
end

def get_unique_id(user_information, expr)
  id = read_input(expr, 'ID', 'ID must not contain spaces and empty string').to_sym
  return id unless user_information.key?(id)
  loop do
    p 'Given ID Already Exist, Enter ID Again'
    id = read_input(expr, 'ID', 'ID must not contain spaces and empty string').to_sym
    break unless user_information.key?(id)
  end
  id
end

def signup(user_information, idexp, nameexp, passexp)
  p 'Enter ID'
  id = get_unique_id(user_information, idexp)
  p 'Enter Your Name'
  name = read_input(nameexp, 'Name', 'please enter fullname')
  p 'Enter Password'
  password = read_input(passexp, 'Password', 'password must contain one special character,one small case letter,one capital letter and one digit')
  new_record = { id => { name: name, password: password, amount: 0, transactions: [] } }
  user_information.merge!(new_record)
  p 'New Record Created'
  p user_information[id].slice(:name, :amount)
end

def menu(user_information)
  passexp = /(?=.*[a-z]+)(?=.*[A-Z]+)(?=.*[0-9]+)(?=.*\W+)/
  nameexp = /\A[a-zA-z]+ [a-zA-z]+\z/
  idexp = /[^''|' ']/
  loop do
    p '1. Login 2.Signup 3.Exit'
    choice = gets.chomp
    case choice
    when '1'
      login(user_information, idexp)
    when '2'
      signup(user_information, idexp, nameexp, passexp)
    end
    break unless choice != '3'
  end
end
menu(user_information)
