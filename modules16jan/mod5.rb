module Yug
  def self.extended(base)
    p 'in yug extended'
    base.include Guru
  end
 def yug_method
    p 'in yug_method'
  end

end

module Guru
  def guru_method
    p 'in guru_method'
  end
end

class Human
  extend Yug
end

Human.yug_method
Human.new.guru_method

