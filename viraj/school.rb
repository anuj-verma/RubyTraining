class Teacher
	attr_reader :name, :certificates_count, :prizes_count, :students
	def initialize(name, students)
		@name = name
		@certificates_count = 0
		@prize_count = 0
		@students = students
	end

	def give_certificate(student)
		if(students.include?(student))
			@certificates_count += 1
			p "Certificate given to #{student.name}"
		end
	end

	def give_prize(student)
		if(students.include?(student))
			@prize_count += 1
			p "Prize given to #{student.name}"
		end
	end
end

class Student
	attr_reader :name, :marks
	def initialize(name, marks)
		@name = name
		@marks = marks
	end

	def collect_certificate(teacher, student = self)
		teacher.give_certificate(student)
	end

	def collect_prize(teacher)
		teacher.give_prize(self)
	end
end

class Parent
	def check_marks(student)
		student.marks
	end
end

class Principal
	attr_reader :teachers, :name
	def initialize(name, teachers)
		@teachers = teachers
		@name = name
	end
	def check_certificates
		puts 'Certificates: '
		teachers.each do |teacher|
			puts "#{teacher.name}: #{teacher.certificates_count}"
		end
	end

	def check_prizes
		teachers.each do |teacher|
			puts "#{teacher.name}: #{teacher.prizes_count}"
		end
	end
end

arjun = Student.new('Arjun', 70)
karan = Student.new('Karan', 80)
ram = Student.new('Ram', 89)
laxman = Student.new('Laxman', 96)

teacher1 = Teacher.new('teacher1', [karan, arjun])
teacher2 = Teacher.new('teacher2', [ram, laxman])

principal1 = Principal.new('Principal 1', [teacher1, teacher2])

arjun.collect_certificate(teacher1, karan)
arjun.collect_certificate(teacher1, arjun)
arjun.collect_prize(teacher1)

principal1.check_certificates