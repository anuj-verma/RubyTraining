class Car
	attr_reader :name, :size
	attr_writer :name, :size
	def initialize(name, size)
		@name = name
		@size = size
		puts name
	end
end

car1 = Car.new('Maruti', 'Big')
car2 = Car.new('Suzuki', 'Very Big')

#puts car1.name
puts car1.name = 'Tanya'


=begin
class Car
	self.attr_reader :name, :size, :category
	
	def initialize(name, size)
		@name = name
		@size = size
		#size = 'very very big'
		#puts size
	end

	def colour(category)
		@category = category
		puts 'I am colour method'
		#color = color
	end

end

car1 = Car.new('Maruti', 'Big')
car2 = Car.new('Suzuki', 'Very Big')


#puts car1.name
#puts car2.name
#puts car1.size
#puts car2.size
#puts car1.colour('Green', 'Amazing')
puts car1.category
=end