class Customer

	attr_reader :name

	def adding_to_cart(name, item)
		@name = name
		puts 'Added item to cart'
		puts item	
	end

	def billing(cost)
		puts 'bill is'
		puts cost
	end

end

tanya = Customer.new

tanya.adding_to_cart('Tanya', 'Maggi')
tanya.billing(15)
puts tanya.name
