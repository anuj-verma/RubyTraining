def mymap(array)
	result = []
	for number in array do
	result << yield(number)
	end if block_given?
end

numbers = [1, 2, 3]

print "#{mymap(numbers){ |number| number*2 }} \n" 
