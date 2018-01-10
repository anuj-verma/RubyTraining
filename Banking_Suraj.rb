$User_Array = []

$Account_ID = 1200

def accept_info
   
     puts "If You are not a registered user.. Complete Your Registration First.."
     hash = Hash.new

     puts "Enter Your Name: "
     hash[:Name] = gets.chomp
     
     puts "Enter Your City: "
     hash[:City] = gets.chomp

     puts "Enter Your Email: "
     hash[:Email] = gets.chomp # Validations Needed..
     
     $Account_ID += 11
     hash[:Account_ID] = $Account_ID;
     
     puts "Your Account_ID is #{hash[:Account_ID]}"

     puts "Please Create a strong password..."
     hash[:Password] = gets.chomp

     hash[:Account_Balance] = 500

     $User_Array.push(hash)
     puts "You Are Successfully Logged IN..."
     show_menu($Account_ID)
    # puts $User_Array
end 

def validate_aid_pwd(input_uid,input_pwd)
    i=0
    flag=0
    loop do
      if ($User_Input[i][:Account_ID] == input_uid)
         if($User_Input[i][:Password] == input_pwd)
	   flag=1
	   break
	 end
      end
    end

    if(flag == 1)
      show_menu(aid)
    else
      puts "Something Went Wrong.. Please Provide Correct Account ID and Password..."
      accept_inputs()
    end
end

def  deposit_funds(input_acc_ID, deposit_amt)
 
     i=0

     loop do

     if($User_Array[i][:Account_ID] == input_acc_ID)
          $User_Array[i][:Account_Balance] = $User_Array[i][:Account_Balance] + deposit_amt
     
          puts "Amount Deposited Successfully..."
	  puts "Now.., Your Current balance has become Rs. #{$User_Array[i][:Account_Balance]}"
          break
     end
     i += 1
    end
    show_menu(input_acc_ID)
end 


def withdraw_funds(input_acc_ID, withdraw_amt)

     i=0

     loop do

     if($User_Array[i][:Account_ID] == input_acc_ID)
          $User_Array[i][:Account_Balance] = $User_Array[i][:Account_Balance] - withdraw_amt
     
          puts "Amount Withdrawn Successfully..."
	  puts "Now.., Your Current balance has become Rs. #{$User_Array[i][:Account_Balance]}"
          break
     end
     i += 1
    end
    show_menu(input_acc_ID)

end

def transfer_funds(source_acc_ID, dest_acc_ID,transfer_amt)

     i=0

     loop do


     if($User_Array[i][:Account_ID] == source_acc_ID)
          $User_Array[i][:Account_Balance] = $User_Array[i][:Account_Balance] - transfer_amt
          
	  puts "Your Account Balance has now Become #{$User_Array[i][:Account_Balance]}" 
          puts "Amount Transfered Successfully..."
     end  
     if($User_Array[i][:Account_ID] == dest_acc_ID)
          $User_Array[i][:Account_Balance] = $User_Array[i][:Account_Balance] + transfer_amt
     

	  break
     end
     i += 1
    end
    show_menu(input_acc_ID)
end

def accept_inputs()

puts "Please Enter Your Account_ID: "
 uid=gets.to_i
 if($User_Array.empty?)
   puts "You Haven't registered yet.. Complete Your Registartion First.."
   accept_info()
 else
   puts "Enter Your Password: "
   password = gets.to_i
   validate_aid_pwd(aid,password)
 end
end
def show_menu(aid)
 puts "Welcome.. Please Select An Operation..."
 puts "------Menu-----"
 puts "1.Register\n2.Deposit\n3.Withdraw\n4.Transfer\n"

 choice=gets.to_i

case choice

	when 1
     		accept_info()
	when 2  
	        puts "----Deposit Funds----"
	        puts "Enter Amount To Be Deposited: "
		deposit_amt = gets.to_i
	        deposit_funds(aid,deposit_amt) 
	when 3
	        puts "---- Withdraw Funds----"
	        puts "Enter Amount To Be Withdrawn: "
                withdraw_amt = gets.to_i
		withdraw_funds(aid,withdraw_amt)
	when 4 
	        puts "----Transfer Funds----"
	        puts "Enter Account_ID of a person to transfer Money: "
		target_aid = gets.to_i

		puts "Enter Amount To Be transfered: "
		transfer_amt = gets.to_i
		transfer_funds(aid,target_aid,transfer_amt)
	else
	     puts "Invalid Choice.. Please Enter Appropriate One..."
   end
end

accept_inputs() # This method will read the initial credentials provided by the user for Login purpose...

show_menu()     # This method dispalys the menu of provided services...
