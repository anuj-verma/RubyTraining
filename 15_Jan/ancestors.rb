module Printing
	def prints(name)
		name
	end
end
module Numbers
	Input = 10
	def test
		puts "The input is #{Input}"
	end
	def square(number)
		number * number
	end
	def add(number1, number2)
		number1 + number2
	end
	def double(number)
		number + number
	end
end

module Calculate
	Input = 20
	def product(number1, number2)
		number1 * number2
	end
	def division(number1, number2)
		number1 / number2
	end
	def add(number1, number2)
		puts number1
		puts number2
		number1 - number2
	end
	class Student
		def name(name)
			puts 'this is inside module'
		end
	end
end

class Student
	include Calculate
	def name(name)
		puts 'this is outside module'
	end
end

priyanka = Student.new
priyanka.name('hey')

=begin
class Operation
	include Printing
	include Numbers
	include Calculate
	#def add(number1, number2)
#		number1 + number2
#	end
end

op1 = Operation.new
#puts op1.class.ancestors
puts op1.add(3,5)
=end