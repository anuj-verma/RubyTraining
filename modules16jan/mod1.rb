module Yug
  def age
    p 'age'
  end
  class Guru
    POWER = 'FLY'
  end
  class Special
  end
end
p self
p Yug.instance_method(:age).bind(self).call 
p Yug::Special.ancestors
Yug::Guru::POWER
