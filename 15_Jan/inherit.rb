class Intern
	include Person
	def intern
		puts 'I am an intern'
	end
end

class Person
	def person
		puts 'I am a student'
	end
end

tanya = Person.new
tanya.person