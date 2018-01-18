module Power
end
class Human
  include Power
end

ram = Human.new
sham = Human.new
arjun = Human.new
arjun.extend Power
def ram.shout
  p ' i can shout'
end

p Human.class
p Human.superclass
p Human.ancestors
p Human.singleton_class
p ram.singleton_class.ancestors
p sham.singleton_class.ancestors
p arjun.singleton_class.ancestors
p ram.class.ancestors
p sham.class.ancestors
p arjun.class.ancestors
