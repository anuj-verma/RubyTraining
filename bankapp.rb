user_information = {}
def deposit(user_information, id, amount)
	user_information[id][:amount] += amount;
	user_information[id][:transactions].append("#{amount.to_s} RS CREDITED ")
	p user_information
end

def withdraw(user_information, id, amount)
	if user_information[id][:amount] >= amount; 
		user_information[id][:amount] -= amount;
		user_information[id][:transactions].append("#{amount.to_s} RS DEBITED ")
	else
		p "Insufficient balance"
	end
	p user_information
end

def transfer(user_information , from , to, amount)
	if user_information[from][:amount] >= amount; 
		user_information[from][:amount] -= amount;
		user_information[to][:amount] += amount;
		user_information[from][:transactions].append("#{amount.to_s} RS TRANSFERD  TO #{to}")
		user_information[to][:transactions].append("#{amount.to_s} RS CREDITED   FROM #{from}")
	else
		p "Insufficient balance"
	end
	p user_information
end

def enter_id()
	p "Enter Your ID "
  gets.chomp.to_sym
end

def enter_password()
	p "Enter Password "
	gets.chomp
end


def enter_amount()
	p "Enter amount"
	gets.chomp.to_i
end

def perform_operations(user_information, id)
	
	loop do
		p "CHOOSE OPTION"
		p "1.Deposit  2.Withdraw 3.transfer 4.exit"
		option = gets.chomp
		case option
			when "1"
				amount = enter_amount()
				deposit(user_information, id, amount)	
			when "2"
				amount = enter_amount()
				withdraw(user_information, id, amount)
			when "3"
				while true do
				to = enter_id()
				if user_information[to] != nil
					amount = enter_amount()
					transfer(user_information, id, to, amount)
					break
				else
					p "enter valid user id,entered id does not exist"
					end
				end
			else
				break
				end
	break if(option == "4")
	end
end

while true do
	id = enter_id()
	if user_information[id] != nil 
		password = enter_password()
		if user_information[id][:password] == password
			perform_operations(user_information, id)
		else
			p "invalid password enter details again"
		end
		
	else
		p "ID does not exist"
		p "Enter Your Name :  "
		name = gets.chomp	
		password = enter_password()
		new_record = {id => {name: name , password: password , amount: 0 , transactions: []}}
		user_information.merge!(new_record)
		p user_information
	end
end


