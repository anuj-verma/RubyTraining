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

class Operation
	include Numbers
	def demo
		puts 'This is a demo method'
	end
end

op1 = Operation.new
#op1.extend Numbers
puts op1.square(20)