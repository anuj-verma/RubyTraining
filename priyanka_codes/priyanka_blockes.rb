def random(name)
	puts 'Method Start'
 	puts yield(name) if block_given?
	puts 'Method End'
end

random('priyanka'){ |name|  "i am #{name}" }
