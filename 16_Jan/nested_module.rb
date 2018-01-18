module Calculator
	def sum(number1, number2)
		puts 'This is sum from Calculator Module'
		number2 + number1
	end

	def prodcut(number1, number2)
		puts 'This is product from Calculator Module'
		number1 - number2
	end
end
module Advanced
	include Calculator
	def square(number)
		number * number
	end
 
end

class Student
	include Advanced
	#def sum(number1, number2)
	#	puts 'This is sum from Student Class'
	#	number2 + number1
	#end
end

tanya = Student.new
puts tanya.square(5)
puts tanya.sum(3, 4)


=begin
module Calculator
	def sum(number1, number2)
		puts 'This is sum from Calculator Module'
		number2 + number1
	end

	def prodcut(number1, number2)
		puts 'This is product from Calculator Module'
		number1 - number2
	end

	module Advanced
		def square(number)
			number * number
		end
	end 
end

class Student
	include Calculator::Advanced
	include Calculator
	def sum(number1, number2)
		puts 'This is sum from Student Class'
		number2 + number1
	end
end

tanya = Student.new
puts tanya.sum(2,6)
puts tanya.square(5)
=end