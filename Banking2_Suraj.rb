$user_records_hash = Hash.new

$account_ID = 1200

def validate_email(str)

    if /\A\w+@{1}\w+\.com${1}/.match?(str)
    	str
    else
    	puts "Please Enter a valid email ID..."
    	email = gets.chomp
    	validate_email(email)
    end
end
def validate_name(str)
	if /\A[a-zA-Z]+[\s]{0,1}[a-zA-Z]*[\s]{0,1}[a-zA-Z]*[\s]{0}[0-9]{0}/.match(str)
		return str
	else
		puts "Enter a valid Name please.."
		name = gets.chomp
		validate_name(name)
	end
end

def cannot_be_empty
	str = ""
	while str.length < 3
		puts "Should contain at least 3 characters. Please Enter Again"
		str = gets.chomp
	end
	str
end

def validate_length()

	str = ""
    puts "Password Should Contain At Least 5 characters in it.."
    while str.length < 5
    	puts "Please Enter Again..."
    	str = gets.chomp
    end
      return str.chomp
end

def validate_aid_pwd(input_aid,input_pwd)
	if($user_records_hash[input_aid].nil?)
		puts "Seems Like You Are Not a registered user.. please register Yourself First"
        accept_info

    elsif ($user_records_hash[input_aid][:password] != input_pwd)
     	puts "Seems Like You Have Entered a Wrong Password.. Try Again..."
     	accept_id_pwd
    else
     	puts "\nYou Are Successfully Logged In..\n"
     	show_logged_in_menu(input_aid)
    end
end

def accept_info

     hash = Hash.new

     puts "Enter Your Name: "
     name = gets.chomp
     hash[:name] = validate_name(name)
     puts "Enter Your City: "
     hash[:city] = gets.chomp
        if hash[:city].length < 3
        	hash[:city] = cannot_be_empty
        end

     puts "Enter Your Email: "
     
     str = gets.chomp
     if str.length <= 0
     	str = cannot_be_empty
     end

     str = validate_email(str)
     hash[:Email] = str 
         
     $account_ID += 11
     hash[:account_ID] = $account_ID;
     
     puts "Your Account_ID is #{hash[:account_ID]}"

     puts "Please Create a password, containing at least 5 characters in it..."
     hash[:password] = gets.chomp
     if hash[:password].length < 5
          str = validate_length()
          hash[:password] = str
     end
          

     hash[:account_balance] = 500

     $user_records_hash[$account_ID] = hash

      #puts $user_records_hash

     puts "You Are Successfully registered.."
     puts "\n\nNow Enter Your Login Credentials To Login.."
     
     accept_id_pwd

#     puts "Details are as follows \n #{$user_records_hash}"
end

def accept_id_pwd
    
    puts "\nEnter Your Account ID: "
    aid = gets.to_i

    puts "\nEnter Your Password: "
    pwd = gets.chomp

    validate_aid_pwd(aid,pwd)     
end

def show_basic_menu
    puts "Select an Operation..."
    puts "\n1. Register\n\n2. login"
    choice=gets.to_i
    case choice
    when 1
    	accept_info
    when 2
    	accept_id_pwd
    else
    	puts "Invalid choice.. Please make an appropriate one..."
    	show_basic_menu
    end
end



def deposit_funds(acc_id, deposit_amt)
    
	$user_records_hash[acc_id][:account_balance] += deposit_amt
	puts "Rs.#{deposit_amt} Are Successfully Deposited"
    puts "Your current Account Balance is: #{$user_records_hash[acc_id][:account_balance]}"
    show_logged_in_menu(acc_id)
end

def withdraw_funds(acc_id,withdraw_amt)

	   $user_records_hash[acc_id][:account_balance] -= withdraw_amt
	   puts "Rs. #{$user_records_hash[acc_id][:account_balance]} Withdrawed..."
	   puts "Your Balance After Withdraw is Rs. #{$user_records_hash[acc_id][:account_balance]}"
       show_logged_in_menu(acc_id)
end

def transfer_funds(source_id,target_id,transfer_amt)

	$user_records_hash[source_id][:account_balance] -= transfer_amt
	$user_records_hash[target_id][:account_balance] += transfer_amt
    puts "Tranfered Successfully...."
    puts "Your Account Balance After This Money Transfer is: #{$user_records_hash[source_id][:account_balance]}"    
    show_logged_in_menu(source_id)
end



def show_logged_in_menu(input_aid)

 puts "\nWelcome.. Please Select An Operation...\n"
 puts "\n------Menu-----"
 puts "\n1.Deposit\n2.Withdraw\n3.Transfer\n4.Show Account Balance\n5.Logout\n"

 choice = gets.to_i

  case choice
   when 1
   	       puts "How Much Amount You Wish To Deposit: "
   	       deposit_amt = gets.to_i
           deposit_funds(input_aid,deposit_amt)
   when 2
   	       puts "How Much Amount You Wish To Withdraw: "
   	       withdraw_amt = gets.to_i
           withdraw_funds(input_aid,withdraw_amt)
   when 3
   	       puts "Enter Target Account ID: "
   	       target_id = gets.to_i
   	       puts "How much amount you wish to Transfer: "
   	       transfer_amt = gets.to_i
   	       transfer_funds(input_aid,target_id,transfer_amt)
   when 4
   	       puts "Your Account Balance is #{$user_records_hash[input_aid][:account_balance]}"
   	       show_logged_in_menu(input_aid)
   when 5
           show_basic_menu() 
   	else
   		   puts "Invalid Choice... Please make an appropriate one..."
   	
   end 
end

show_basic_menu
