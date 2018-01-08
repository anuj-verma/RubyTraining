users_list = [{id: 1, balance: 765, password: "asda"}]
transactions_list = []
$is_logged_in = false

#user = {id: 2, balance: 765, password: "asda"}
#transaction = {user_id: 2, type: 1, amount: 10, transfer_user_id=2}


def user_id?(users_list, user_id)
	#done
	users_list.each_with_index do |item, list_index|
    if item[:id] == user_id
    	return list_index
    end
	end
	return false
end


#return new user_id
def register(users_list, password)
	#done
	new_user = {id: users_list.length + 1, balance: 0, password: password}
	users_list.append(new_user)

	return new_user[:id]
end


def login(users_list, user_id)
	#done
	if user_id?(users_list, user_id)
		$is_logged_in = user_id
		puts "User #{user_id} logged in."
	else
		puts "Would you like to register?(y/n)"
		register_or_not = gets
		if register_or_not.chomp.eql? 'y'
			puts "Enter your new password: "
			password = gets
			$is_logged_in = register(users_list, password.chomp)
		end
	end

end



def deposit(users_list, user_id, amount)
	#do
end


def withdraw(users_list, user_id, amount)
	#do
end


def transfer(users_list, user_id, transfer_user_id, amount)
	#do
end


puts login(users_list, 5)

puts $is_logged_in

