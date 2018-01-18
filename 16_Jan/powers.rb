class Shishya
	attr_reader :abilities
	def initialize(abilities)
		@abilities = abilities
	end
	def check(ability)
		puts abilities[ability.to_sym]
	end
end

class Guru
	def ashirwad(pupil_name, ability)
		pupil_name.abilities[ability.to_sym] = 'I can'
	end
	def shraap(pupil_name, ability)
		pupil_name.abilities[ability.to_sym] = 'I cant'
	end
end

arjun = Shishya.new(swim: 'I can', fly: 'I can', run: 'I can')
arjun.check('fly')

drona = Guru.new
drona.shraap(arjun, 'fly')
arjun.check('fly')
drona.ashirwad(arjun, 'fly')
arjun.check('fly')
arjun.check('swim')
drona.shraap(arjun, 'swim')
arjun.check('swim')

=begin
module Ashirwad
	def fly
		'I can fly'
	end

	def swim
		'I can swim'
	end
	
	def run
		'I can run.'
	end
end

module Shraap
	def fly
		'I cant fly'
	end

	def swim
		'I cant swim'
	end

	def run
		'I cant run.'
	end
end

class Shishya
	
end

class Guru
	include Ashirwad
	include Shraap
	def ashirwad(pupil_name, ability)
		pupil_name.extend Ashirwad
		#Ashirwad.instance_method( ability ).bind( self ).call
	end
	def shraap(pupil_name, ability)
		pupil_name.extend Shraap
		#Shraap.instance_method( ability ).bind( self ).call
	end
end

arjun = Shishya.new
karan = Shishya.new
drona = Guru.new
drona.ashirwad(arjun, 'fly')
puts arjun.fly
drona.shraap(karan, 'swim')
puts karan.swim
#puts arjun.fly
=end
=begin

class Guru
	include Ashirwad
	include Shraap
	def ashirwad(pupil_name, power)

	end
	def shraap(pupil_name, power)

	end
end


module Decision
	def ashirwad(pupil_name, power)
		#puts power
	end

	def shraap(pupil_name, power)
	end
end

class Guru
	include Decision
end

class Shishay
	include Good
	include Bad

end

include Good
include Bad
arjun = Shishay.new
drona = Guru.new
drona.ashirwad(arjun, fly)
=end