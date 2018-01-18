module Numbers
	Input = 10
	def test
		puts "The input is #{Input}"
	end
	def square(number)
		number * number
	end
end

module Calculate	
	def add(number1, number2)
		number1 + number2
	end
	def double(number)
		number + number
	end
end

class Operation
	extend Numbers
	include Calculate
	def demo
		puts 'This is a demo method'
	end
end

puts Operation.square(10)
op1 = Operation.new
puts op1.add(20, 39)