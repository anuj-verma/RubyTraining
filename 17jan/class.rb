class Person
  attr_reader :fname, :lname #getter
  attr_writer :fname, :lname #setter
  Username = 'something'
  @name = 'priyanka'
  def self.open
    @name
  end
  def open
    @name
  end
=begin
  def initialize(fname, lname)
    @fname = fname
    @lname = lname
  end
=end
 def func
    @fname = 'abc'
   puts  Person::Username
 end
end
puts Person.open
#puts p = Person.new('priyanka', 'yadav')
p = Person.new
#p.fname = 'tanya'
p.lname = 'saroha'
p.func
puts p.fname
puts p.lname
