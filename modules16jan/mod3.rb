module A
  module B
    def bmethod
      p 'b'
    end
  end
  module C
    def cmethod
      p 'c'
    end
  end
end

class Some
  include A::B
  extend A::C
end

Some.cmethod
#Some.new.cmethod #undefined method error
Some.new.bmethod
