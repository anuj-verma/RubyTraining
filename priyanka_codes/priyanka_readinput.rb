=begin def read_input(message)
	puts yield(gets.chomp).class if block_given?
end


read_input('Enter Integer') do |input|
	input = input.to_i
	end
read_input('Enter String') do |input|
	input
	end
read_input('Enter Float') do |input|
	input = input.to_f
	end
=end

def read_input(expr)
	input = gets.chomp
	return input if(expr.match?(input))

	loop do
   p ' invalid enter again'
	input = gets.chomp
	break if( expr.match?(input)) 
	end
end

expr =  /\A[a-zA-z0-9]+\z/

p 'enter name'
read_input(expr)
=begin read_input(expr)do |expr, input|
		 expr.match?(input) ? true : false
	end
=end
