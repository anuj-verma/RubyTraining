=begin
def my_function(name)

	puts 'method start'
	puts 'method end'
	yield(name)
		
end 

my_function("bhuvna") { |name|  puts "My name is #{name}"}
my_function("pune") { |city|  puts "my city is #{city}"}
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


def my_map(arr)
	new_arr = []
	arr.each {|number| new_arr << yield(number)}	
	p new_arr
end

my_map([1,2,3]) { |number| number*2 } 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

def read_input(type)
	p type
	yield	

end

name = read_input("Enter a integer") {gets.chomp.to_i }
p name
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
=end