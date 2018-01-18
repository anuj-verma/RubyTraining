my_proc = Proc.new{ |x| return x; }
my_lambda = -> { return "222" }

def method1(message, my_proc)
	puts message
	my_proc.call(2)
	#Proc.new { return '33' }.call
	puts 'hey, i am proc method'
end

def method2(message, &my_lambda)
	puts message
	p my_lambda.call
	puts 'hey, i am lambda method'
end

method1('Yes', my_proc)
method2('No'){my_lambda}

=begin
def add(message)
	puts message
	Proc.new { |num| num + 2}
end

def subtract(message)
	puts message
	-> (num) { num - 2 } 
end

num1 = 1

result1 = add('Hello')
result2 = subtract('Hi')

puts result1.call(num1)
puts result1.class

puts result2.call(num1)
puts result2.class

puts num1


def add(message)
	puts message
	Proc.new { |num1| num1 + 2}
end

num1 = 1
result = add('Hello')
puts result.call(num1, 2)
puts result.class
puts num1

def add(message)
	puts message
	num1 = 2
	num2 = 3
	num3 = 4
	Proc.new { num1=10 }
end

#num1 = 3
#num2 = 4
#num3 = 6

result = add('Hello')
puts result.call
puts num1


#reference nahi pass karta, value is passed.
def add(message)
	puts message
	Proc.new { |num1| num1 + 2}
end

num1 = 1
result = add('Hello')
puts result.call(num1)
puts result.class
puts num1

def my_map(input_array, &my_proc)
			#my_proc(1).call
	if block_given?
		for i in input_array
			my_proc(i).call
		end
	else
		p input_array
	end
end

numbers = [1, 2, 3, 4, 5]

my_proc = Proc.new { |number| number*3 }
my_map(numbers){my_proc}
=end
