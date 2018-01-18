square = Proc.new{ |x| x*x}

def operation(input, proc1)
	proc1.call(input)
	yield(input) if block_given?
end

puts operation(5,square)
puts operation(5,square){|x| x+x}

def test_method(input)
	yield(input) if block_given?
end

puts test_method(10){|x| x*x}


