
#second way of including some methods as class or instance method
module Yug
  def self.included(base)
    p self
    base.extend Guru
    p 'in Yug included'
  end
  def yug_method
    p 'yug_method'
  end
end

module Guru
  def guru_method
    p self 
    p 'guru_method'
  end
end

class Human
  include Yug
end

Human.guru_method
Human.new.yug_method
