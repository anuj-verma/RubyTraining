class Guru
  attr_reader :name, :shishays

  def initialize(name, shishays)
    @name = name
    @shishays = shishays
  end

  def ashirvad(shishay, power)
    if shishays.include?(shishay)
      shishay.powers << power
      shishay.define_singleton_method(power) do
        "I can #{power}"
      end
    end
  end

  def shraap(shishay, power)
    if shishays.include?(shishay)
      shishay.powers.delete(power)
      shishay.instance_eval("undef #{power}")
=begin
      shishay.define_singleton_method(power) do
        "I can't #{power}"
      end
=end
    end
  end
end

class Shishay
  attr_reader :name, :powers
  
  def initialize(name, powers)
    @name = name
    @powers = powers
  end

  def method_missing(method_name)
    "I can't #{method_name}"
  end
end

arjun = Shishay.new('arjun', [])
bhim = Shishay.new('bhim', [])
yudha = Shishay.new('yudha', [])
param = Guru.new('param', [arjun, bhim])
bramha = Guru.new('bramha', [arjun, yudha])
param.ashirvad(arjun, 'fly'.to_sym)
puts arjun.fly
puts arjun.powers
param.ashirvad(arjun, 'swim'.to_sym)
puts arjun.swim
puts arjun.powers
param.shraap(arjun, 'fly'.to_sym)
puts arjun.fly
puts arjun.powers
param.shraap(yudha, 'run'.to_sym)
#puts yudha.run
bramha.ashirvad(yudha, 'run'.to_sym)
puts yudha.run

puts arjun.df
