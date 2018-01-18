class Operation
	attr_reader :number1, :number2

	def add(number1, number2)
		number1 + number2
	end
end

op1 = Operation.new
puts op1.add(4, 5) 

op2 = Operation.new

def op2.double(number)
	number + number
end

puts op2.double(10)

