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

class Student
	include Calculator
	def sum(number1, number2)
		puts 'This is sum from Student Class'
		number2 + number1
	end
end

tanya = Student.new
tanya.sum(2,6)

