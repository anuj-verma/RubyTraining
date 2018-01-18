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
	module Calculate
		Input = 20
		def product(number1, number2)
			number1 * number2
		end

		def division(number1, number2)
			number1 / number2
		end
	end
end

class Operations
	include Numbers
	#extend Numbers
	#puts Input
end

puts Numbers.class.superclass
#puts Operations.add(2,3)
a = Operations.new
#puts a.add(2,2)
#puts a.product(3,10)
#a.test

=begin
module Numbers
	def square(number)
		number * number
	end
	def add(number1, number2)
		number1 + number2
	end
	def double(number)
		number + number
	end
	module Calculate
		def product(number1, number2)
			number1 * number2
		end

		def division(number1, number2)
			number1 / number2
		end
	end
end

class Operations
	include Numbers::Calculate
	include Numbers
end

a = Operations.new
puts a.add(2,2)
puts a.product(3,10)

=end

=begin
module Numbers
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

include Numbers
puts add(2,2)

class Operations
	#include Numbers
	#num1, num2
end

a = Operations.new
puts a.add(1, 5)
puts a.double(5)
puts a.square(5)
=end
#puts Numbers::Calculate::Input
#puts Numbers::Input
#puts Numbers.class

