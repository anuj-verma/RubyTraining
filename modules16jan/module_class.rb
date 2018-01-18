module Mymethod
  class Array
    def map
      puts 'mymap'
    end
  end
end

puts  Mymethod::Array.ancestors
puts Array.ancestors
