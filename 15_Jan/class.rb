class Person
	attr_reader :first_name, :last_name
	hands = 2
	def name(name1, name2)
		@first_name = name1
		@last_name = name2
		puts hands
	end

	def age(years)
		years
	end
end

p1 = Person.new
puts p1.name('Tanya', 'Saroha')
#puts p1.age(21)
#puts p1.first_name
#puts p1.last_name

