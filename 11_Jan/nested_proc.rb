def double_the_square(input)
	double = Proc.new do |x|
		square = Proc.new do |y|
			y * y
		end
		sq = square.call(x)
		sq + sq
	end
	double.call(input)
end

def square_the_double(input)
	square = Proc.new do |x|
		double = Proc.new do |y|
			y + y
		end
		db = double.call(x)
		db * db
	end
	square.call(input)
end

puts double_the_square(5)
puts square_the_double(5)


=begin
	
rescue Exception => e
	
end

square = Proc.new{ |x| x*x }.
double = Proc.new{ |x| x+x }

def double_proc(input)
	square = Proc.new do |x|
		y = Proc.new {|x| x+x}.call(x)
		y*y
	end
	square.call(10)
end

double_proc(10)

def operation1(input, proc1)
	proc1.call(input)
end 

def operation2(input, proc1)
	proc1.call(input)
end

def operation3(input, proc1, proc2)
	proc2.call(proc1.call(input))
end

puts operation1(10, square)
puts operation2(10, double)
puts operation3(10, square, double)

#puts square.call(10)
#puts double.call(10)

=end