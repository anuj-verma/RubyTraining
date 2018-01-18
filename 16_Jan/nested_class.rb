class Person
	def full_name(first_name, last_name)
		first_name + ' '  + last_name	
	end
	class Student
		def marks(subject1, subject2)
			score = (subject1 + subject2) / 2
		end
	end
end

tanya = Person.new
puts tanya.full_name('Tanya', 'Saroha')

priynka = Person::Student.new
puts priynka.marks(30, 60)
puts priynka.full_name('Priynka', 'Yadav') #raises exception
puts tanya.marks(20, 40) #raises exception