class Restaurant
  @open = true
 attr_reader :name 
  def initialize(name)
    @name = name
  end
  def self.open
    @open
  end
end

puts Restaurant.open
obj = Restaurant.new('priyanka')

def obj.name1
  puts obj.name
end
obj.name1

