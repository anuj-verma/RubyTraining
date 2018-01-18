module A
  Abc = 'A'
  module B
    Abc = 'B'
  end
end

puts A::B::Abc
