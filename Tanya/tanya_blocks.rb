def sample_method(name)
	puts 'Method Starts Here'
	yield(name) if block_given?
	puts 'Method ends Here'
end

sample_method('Tanya') { |name| puts "My name is #{name}" }
sample_method('Pune') { |name| puts "My city is #{name}" }

=begin
sample_method { def printing(name)
									puts 'My name is ' + name
								end
								printing('Tanya')}
=end


