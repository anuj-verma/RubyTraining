user_information = {}
def deposite(user_information , id)
	p "Enter amount to deposit"
	amount = gets.chomp
	amount = amount.to_i
	user_information[id][:amount] += amount;
	user_information[id][:transaction].append("#{amount.to_s} RS CREDITED ")
	p user_information
end

def withdraw(user_information , id)
	p "Enter amount to withdraw"
	amount = gets.chomp
	amount = amount.to_i
	if user_information[id][:amount] >= amount; 
		user_information[id][:amount] -= amount;
		user_information[id][:transaction].append("#{amount.to_s} RS DEBITED ")
	else
		p "Insufficient balance"
	end
	p user_information
end

def transfer(user_information , from , to)
	p "Enter amount to transfer"
	amount = gets.chomp
	amount = amount.to_i
	if user_information[from][:amount] >= amount; 
		user_information[from][:amount] -= amount;
		user_information[to][:amount] += amount;
		user_information[from][:transaction].append("#{amount.to_s} RS TRANSFERD  TO #{to}")
		user_information[to][:transaction].append("#{amount.to_s} RS CREDITED   FROM #{from}")
	else
		p "Insufficient balance"
	end
	p user_information
end




while true do
	p "Enter Your ID "
	id = ":" +  gets.chomp

	if user_information[id] != nil 
  	p "Enter Password "
		password= gets.chomp
		if user_information[id][:password] == password
			flag = 0
			while flag == 0 do
				p "CHOOSE OPTION"
				p "1.Deposit  2.Withdraw 3.transfer 4.exit"
				option = gets.chomp
				case option
				when "1"
					deposite(user_information , id)	
				when "2"
					withdraw(user_information , id)
				when "3"
					while true do
						p "Enter  ID  to transfer money"
						to = ":" +  gets.chomp
						if user_information[to] != nil
							transfer(user_information , id , to)
							break
						else
							p "enter valid user id,entered id does not exist"
						end
					end
				else
					flag = 1	
					break
				end
			end
		else
			p "invalid password enter details again"
		end
		
	else
		p "ID does not exist"
		p "Enter Your ID :  "
		id = ":" +  gets.chomp
		p "Enter Your Name :  "
		name = gets.chomp	
		p "Enter Your Password "
		password = gets.chomp
		new_record = {id => {:name => name , :password => password , :amount => 100 , :transaction => []}}
		user_information.merge!(new_record)
		p user_information
	end
end


