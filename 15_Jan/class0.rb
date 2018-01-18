class Mathematics
	X = 10
	def test(number)
		number * X
	end

	def sum(number1, number2)
		number1 + number2
	end

	def diff(number1, number2)
		number1 - number2
	end

	def product(number1, number2)
		number1 * number2
	end

	def division(number1, number2)
		number1 / number2
	end
end

x = 10
y = 5

result1 = Mathematics.new
puts result1.sum(x, y)
puts result1.diff(x, y)
puts result1.product(x, y)
puts result1.division(x, y)
puts result1.test(20)