def read_input(message)
	puts message
	yield if block_given?
end

read_input('Enter an Integer') do	value = gets.chomp.to_i 
																	puts value.class 
															 end 

read_input('Enter a String') do value = gets.chomp
																puts value.class
														 end


