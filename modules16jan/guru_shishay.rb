module Ashirwad
  def fly
    puts 'I CAN FLY'
  end
  def swim
    p 'I CAN SWIM'
  end
  def run_fast
    p 'I CAN RUN FAST'
  end 
end

module Sharap
  def fly
    puts 'I CANNOT FLY'
  end
  def swim
    p 'I CANNOT SWIM'
  end
  def run_fast
    p 'I CANNOT RUN FAST'
  end
end

class Guru
  def ashirwad(obj, method)
    obj.extend Ashirwad
    obj.send(method)
  end
  def sharap(obj, method)
    obj.extend Sharap
    obj.send(method)
  end
end


class Shishay
end


guru = Guru.new
arjun = Shishay.new
ram = Shishay.new
guru.ashirwad(arjun, 'fly')
arjun.fly
arjun.swim
p arjun.methods
guru.sharap(arjun, 'fly')
guru.sharap(ram, 'swim')
guru.ashirwad(ram, 'swim')
guru.sharap(ram, 'run_fast')
#module_name.instance_method(:fly).bind(self).call
