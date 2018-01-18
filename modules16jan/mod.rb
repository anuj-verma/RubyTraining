module A
  def self.hello
    p 'hello'
  end

  def func
    puts 'A'
  end
end

A::hello

=begin
module B
 def func
    puts 'B'
  end
end
module C
   def func
    puts 'C'
  end
end

class Some
  extend A
end

Some.hello

=begin
Some.extend A
Some.func
p Some.ancestors
Some.extend B
Some.func
Some.extend C
Some.func

Some.extend B
Some.func
p Some.ancestors
=end
