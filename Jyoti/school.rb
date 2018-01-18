# Parents can only view all students marks
class Parent
  def view_all_marks
    Student.all_students_marks
  end
end

# Principal can view distributed certificate, prize count and marks
# But can not modify them
class Principal
  def view_all_marks
    Student.all_students_marks
  end

  def view_all_certificates
    Student.all_certificate_holders
  end

  def view_all_prizes
    Student.all_prize_holders
  end
end

# Teacher can give marks, certificate, prize
class Teacher
  @@certificate_count = 0
  @@prize_count = 0
  attr_reader :certificate_count, :prize_count

  def self.certificate_count
    @@certificate_count
  end

  def give_prize(student)
    unless student.prize_collected 
      student.prize_collected = true
      puts "#{student.name} is given Prize "
      @@prize_count += 1
    else
      puts "#{student.name} has already collected prize"
    end
  end

  def give_certificate(student)
    unless student.certificate_collected
      student.certificate_collected = true
      puts "#{student.name} is given certificate "
      @@certificate_count += 1
    else
      puts "#{student.name} has already collected certificate"
    end
  end

  def give_marks(student)
    if student.exam_given
      puts "Enter marks for #{student.name}"
      gets.chomp.to_i
    else
      puts "#{student.name} need to give exam before getting marks "
    end
  end

  def self.certificate_report
    puts "\tTotal Certificates given : #{@@certificate_count}"
  end

  def self.prize_report
    puts "\tTotal Prize given : #{@@prize_count}"
  end
end

# Student can request for marks, certificate, prize
class Student
  def initialize(name)
    @name = name
    @exam_given = false
    @marks = 0
    @exam_given = false
    @certificate_collected = false
    @prize_collected = false
  end

  attr_accessor :marks, :certificate_collected, :prize_collected
  attr_reader :exam_given, :name

  def self.all_certificate_holders
    puts '***ALL CERTIFICATE HOLDERS***'
    ObjectSpace.each_object(self).to_a.each do |stud|
      if stud.certificate_collected
        puts "#{stud.name} is given certificate"
      end
    end
  end

  def self.all_prize_holders
    puts '***ALL PRIZE HOLDERS***'
    ObjectSpace.each_object(self).to_a.each do |stud|
      puts "#{stud.name} is given prize" if stud.prize_collected
    end
  end

  def self.all_students_marks
    puts '*** ALL STUDENTS MARKS ***'
    ObjectSpace.each_object(self).to_a.each do |stud|
      puts "#{stud.name} ---- #{stud.marks}" if stud.exam_given
    end
  end

  def give_exam(guru)
    @exam_given = true
    @marks = 0
    @marks = guru.give_marks(self)
  end

  def request_prize(teacher)
    teacher.give_prize(self)
  end

  def request_certificate(teacher)
    if exam_given == false
      puts "Exam not given by #{name}"
    else
      teacher.give_certificate(self)
    end
  end

  def request_friend_certificate(teacher, friend)
    unless friend.exam_given
      puts "Exam not given by #{friend.name}"
    else
      teacher.give_certificate(friend)
    end
  end
end

jyoti = Student.new 'Jyoti'
pooja = Student.new 'Pooja'

guru = Teacher.new

principal = Principal.new

jyoti.request_certificate(guru)

puts jyoti.request_friend_certificate(guru, pooja)
jyoti.request_certificate(guru)

Teacher.prize_report
Teacher.certificate_report

Student.all_certificate_holders
Student.all_prize_holders

jyoti.give_exam(guru)
pooja.give_exam(guru)

jyoti.request_certificate(guru)
jyoti.request_friend_certificate(guru, pooja)

jyoti.request_prize(guru)
puts "\n***Principal*** "

principal.view_all_marks
principal.view_all_prizes
principal.view_all_certificates

Teacher.prize_report
Teacher.certificate_report
