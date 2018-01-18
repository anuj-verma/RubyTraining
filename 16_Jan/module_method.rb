module Pupil
  A = 10
  def p_name
    puts 'I am a student name'
  end
  module Pupils
    def self.p_class
      puts 'I am a student class'
    end
  end
end

module Professor
  def p_name
    puts 'I am a professor name'
  end
end

class College
  include Pupil
  include Professor

  def p_name(module_name)
   module_name.instance_method( :p_name ).bind( self ).call
  end
end

ait = College.new
puts Pupil::A
Pupil::Pupils::p_class
ait.p_name(Pupil)
ait.p_name(Professor)
#Pupil.instance_method( :p_name ).bind( ait ).call

#ait.p_class
#ait.extend Pupil
#ait.p_name
#ait.include Professor #raises an exception
#ait.p_name
