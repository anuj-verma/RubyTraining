module Somemodule
 def add(number1, number2)
   number1 + number2
 end
 def multiply(number1, number2)
   number1 * number2
 end
 module Somemodule2
   def show
     p 'IN SOMEMODULE2'
   end
 end
end

class Operation
  include Somemodule::Somemodule2
 
=begin
  attr_reader :number1, :number2
  def initialize(number1, number2)
    @number1 = number1
    @number2 = number2
  end
=end
end
o = Operation.new
 o.show
=begin
 puts o.multiply(3, 4)
=end
