class Shishya
	attr_reader :name
	def initialize(name)
		@name = name
	end

	def method_missing(m)  
    puts "#{name} cannot #{m}"
  end
end

class Guru
	def ashirvad(shishya, power)
		shishya.define_singleton_method(power) do
			puts "#{shishya.name} can #{power}"
		end
	end

	def shraap(shishya, power)
		shishya.instance_eval("undef #{power}")
	end
end

arjun = Shishya.new('Arjun')
karna = Shishya.new('Karna')
dronacharya = Guru.new

dronacharya.ashirvad(arjun, :fly)
dronacharya.ashirvad(arjun, :swim)
dronacharya.shraap(arjun, :fly)
arjun.fly
arjun.swim

dronacharya.ashirvad(karna, :run)
dronacharya.ashirvad(karna, :swim)
karna.swim
karna.run

karna.random_power
