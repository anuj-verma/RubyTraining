module Superman
  def fly
    #super it will give nomethoderror as their  is no method fly in its parent
    p self # object of human
    p 'superman can fly'
  end
end

module Spiderman
=begin  def fly
    p 'in spiderman'
    super
  end
=end
end

class Human
  include Superman
  include Spiderman
  def fly
    p ' in human'
    super
  end
end

Human.new.fly
