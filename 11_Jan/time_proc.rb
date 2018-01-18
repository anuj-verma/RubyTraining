square = proc{|number| number*number }

def calculate(input, code)
	start_time = Time.now
	code.call(input)
	end_time = Time.now
	end_time - start_time
end

puts calculate(10, square)
puts calculate(100, square)
puts calculate(1000, square)
puts calculate(10000, square)
