=begin
def my_map(input_array)
	i=0
	length = input_array.length
	if block_given?
		loop do
			yield(input_array[i])
			i = i + 1
		break if i == length
		end
	else
		p input_array
	end
end
=end

def my_map(input_array)
	if block_given?
		for i in input_array
			yield(i)
		end
	else
		p input_array
	end
end
numbers = [1, 2, 3, 4, 5]

my_map(numbers)
my_map(numbers) { |number| p number*3 }
	
