#code to deonstrate how self is used to define function for class, and how methods are defined for objects of that class

class Person
	def self.full_name(first_name, last_name)
		first_name + ' '  + last_name
	end
end

puts Person.full_name('hi', 'World')


class Person
	def full_name(first_name, last_name)
		first_name + ' '  + last_name
	end
end

tanya = Person.new
puts tanya.full_name('Tanya', 'Saroha')
