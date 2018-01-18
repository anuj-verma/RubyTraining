module Student
  def identity
    puts 'I am student'
  end
end
module Intern
 def identity
    puts 'I am intern'
 end
end

class Person
  include Intern
  extend Student
   def identity
    puts 'I am person'
  end

end
Person.identity
puts Person.superclass
puts Student.class.superclass
Person.new.identity
