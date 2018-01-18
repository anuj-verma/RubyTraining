
looop = Proc.new do |x| 
	i = 10
 	while i < x
    i*i*i
    i += 1
	end
end

def calculate(input, code)
	start_time = Time.now
	code.call(input)
	end_time = Time.now
	end_time - start_time
end

#calculate(20, looop)
#calculate(100, looop)
#calculate(1000, looop)
puts calculate(10000, looop)
