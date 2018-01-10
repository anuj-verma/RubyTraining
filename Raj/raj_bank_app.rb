@balance= { id1: 123 , id2: 456 , id3:  789}
@users  = { id1: 'raj' , id2: 'kamal' , id3: 'lashkari' }
@record = { id1: 'Deposited 123' , id2: 'Deposited 456', id3: 'Deposited 789'}
def main
  loop do
    print "\n\t\tMenu\n\n"
    print "\t1. New account\n"
    print "\t2. Login\n"
    print "\t3. Exit\n\n"
    print "\tChoice : "
    choice=gets.to_i
    case choice
      when 1
        create_user
      when 2
        login
      when 3
        exit
      else
        print "#{choice} is not a valid option !!!\n"
    end
  end
end
def create_user
  print "User ID : "
  user_id = gets.chomp.to_sym
  if( @users.has_key?( user_id ))
    print "User ID already exist !!!\n"
  else
    print "Set password : "
    @users[ user_id ] = gets.chomp
    print "Initial balance : "
    @balance[ user_id ] = gets.to_i
  end
  main
end
def login
  print "User ID : "
  user_id = gets.chomp.to_sym
  if( @users.has_key?( user_id ) == false)
    print "User ID doesn't exist !!!\n"
  else
    print "Enter password : "
    password = gets.chomp
    if( @users [ user_id ] == password )
      print "Logged in successfully !!!\n\n"
      menu( user_id )
    else
      print "Access denied !!!\n"
    end
  end
end
def menu( user_id )
  loop do
    print "\n\n\tbalance = #{@balance[user_id]}\n"
    print "\n\t Menu\n\n"
    print "\t1. Deposit\n"
    print "\t2. Withdraw\n"
    print "\t3. Transfer\n"
    print "\t4. History\n"
    print "\t5. Logout\n\n"
    print "\tChoice :"
    choice = gets.to_i
    case choice
    when 1
      deposit( user_id )
    when 2
      withdraw( user_id )
    when 3
      transfer( user_id )
    when 4
      history( user_id )
    when 5
      break
    else
      print "#{choice} is not a valid option !!!"
    end
  end
  main
end
def deposit( user_id )
  print "Enter ammount to deposit : "
  ammount = gets.to_i
  @balance[ user_id ] = @balance[ user_id ] + ammount
  @record [ user_id ] = @record [ user_id ] + "Deposited #{ammount}\n"
  print "Ammount deposited successfully !!!\n"
end
def withdraw( user_id )
  print "Enter ammount to withdraw : "
  ammount = gets.to_i
  if( @balance[ user_id ] < ammount )
    print "Insufficient @balance !!!\n"
  else
    @balance[ user_id ] = @balance[ user_id ] - ammount
    @record [ user_id ] = @record [ user_id ] + "Withdrawn #{ammount}\n"
    print "Ammount withdrawn successfully !!!\n"
  end
end
def transfer( user_id )
  print "Enter user id to transfer into : "
  user_id2 = gets.chomp.to_sym
  if( @users .include? ( user_id2 ) )
    print "Enter ammount to transfer : "
    ammount = gets.to_i
    @balance[ user_id2 ] = @balance[ user_id2 ] + ammount
    @balance[ user_id  ] = @balance[ user_id  ] - ammount
    @record [ user_id  ] = @record [ user_id  ] + "\nTransfered #{ammount} to #{user_id2}\n"
    @record [ user_id2 ] = @record [ user_id2 ] + "\nTransfered #{ammount} from #{user_id}\n"
    print "Ammount transfered successfully !!!\n"
  else
    print "No such user exist !!!\n"
  end
end
def history(user_id)
  print "#{@record[ user_id ]}"
end
main
