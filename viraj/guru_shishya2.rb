module Fly
	def fly
		if powers.include?('fly')
			puts "#{name} can fly"
		else
			puts "#{name} cannot fly"
		end
	end
end

module Run
	def run
		if powers.include?('run')
			puts "#{name} can run"
		else
			puts "#{name} cannot run"
	end
end
end

module Swim
	def swim
		if powers.include?('swim')
			puts "#{name} can swim"
		else
			puts "#{name} cannot swim"
		end
	end
end

class Shishya
	attr_accessor :powers
	attr_reader :name
	def initialize(name)
		@name = name
		@powers = []
	end

	def method_missing(m, *args)  
    puts "#{name} cannot #{m}"  
  end 
end

class Guru
	def ashirvad(shishya, power)
		shishya.powers << power
		case power
		when 'fly'
			shishya.extend(Fly)
		when 'run'
			shishya.extend(Run)
		when 'swim'
			shishya.extend(Swim)
		end
	end

	def shraap(shishya, power)
		shishya.powers.delete(power)
		case power
		when 'fly'
			shishya.undef(:fly)
		when 'run'
			shishya.undef(:run)
		when 'swim'
			shishya.undef(:swim)
		end
	end
end

arjun = Shishya.new('Arjun')
karna = Shishya.new('Karna')
dronacharya = Guru.new

dronacharya.ashirvad(arjun, 'fly')
dronacharya.ashirvad(arjun, 'swim')
dronacharya.shraap(arjun, 'fly')
arjun.fly
arjun.swim

dronacharya.ashirvad(karna, 'run')
dronacharya.ashirvad(karna, 'swim')
karna.swim
karna.run
