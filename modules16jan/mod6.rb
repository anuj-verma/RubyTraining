module A
  def amethod
    p 'in a'
  end
end
module B
  extend A
  def bmethod
    p ' in b'
  end
end

class Some
  #extend B
  include B
end

Some.new.bmethod
Some.amethod
=begin
module A
  def amethod
    p 'in a'
  end
end
module B
  include A
  def bmethod
    p ' in b'
  end
end

class Some
  include B
end

Some.new.bmethod
Some.new.amethod
=end
