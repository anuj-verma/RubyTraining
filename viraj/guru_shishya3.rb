#returns error if method doesn't exist
class Shishya
	attr_reader :name
	def initialize(name)
		@name = name
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
dron = Guru.new


dron.ashirvad(arjun, :fly)
dron.ashirvad(arjun, :swim)
dron.shraap(arjun, :fly)

arjun.swim
arjun.fly
