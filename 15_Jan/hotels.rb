class Restraunt
	attr_reader :name, :menu
	def initialize(name, menu)
		@name = name
		@menu = menu
	end

	def search(dish, price)
		self.menu.each do |m|
			puts m.dish_name.name #if m.dish_name.name == dish and m.dish_price.price == price
		end
	end
end

class Menu
	attr_reader :type, :dish_name, :dish_price
	def initialize(menu, dish_name, dish_price)
		@menu = menu
		@dish_name = dish_name
		@dish_price = dish_price
	end
end

class Dish
	attr_reader :name
	def initialize(name)
		@name = name
	end
end

dish1 = Dish.new('Rajma')
dish2 = Dish.new('Dal')
dish3 = Dish.new('Vada Pav')
dish4 = Dish.new('Ice cream')
dish5 = Dish.new('Sabzi')
dish6 = Dish.new('Sandwich')
dish7 = Dish.new('Burger')

menu1 = Menu.new('Lunch', dish1, 30)
menu2 = Menu.new('Lunch', dish2, 20)
menu3 = Menu.new('Snacks', dish3, 50)

menu

box8 = Restraunt.new('Box 8', [ menu1, menu2, menu3])
locavore = Restraunt.new('Locavore', [])
box8.search('Rajma', 30)

#  'Vada Pav' => 50, 'Dal' => 10)
#locavore = Hotel.new('Lacavore') #'Dal' => 10, 'Vada_Pav' => 30, 'Sabji' => 40)
#flavours = Hotel.new('Flavours') #Ice cream' => 10, 'Sandwich' => 20, 'Burger' => 30, 'Vada Pav' => 30)

#hotels = [box8, locavore, flavours]

#request = Hotel.new('', {})
#request.search(dish_name, price, hotels)
=begin
class Hotel
	attr_reader :menu, :name
	def initialize(name, menu)
		@menu = menu
		@name = name
	end

	def search(dish_name, price, hotels)
		hotels.each do |hotel|
			puts hotel.name if hotel.menu[dish_name] == price
		end
	end
end


dish_name = 'Dal'
price = 10

box8 = Hotel.new('Box 8', 'Rajma' => 30,  'Vada Pav' => 50, 'Dal' => 10)
locavore = Hotel.new('Lacavore', 'Dal' => 10, 'Vada_Pav' => 30, 'Sabji' => 40)
flavours = Hotel.new('Flavours', 'Ice cream' => 10, 'Sandwich' => 20, 'Burger' => 30, 'Vada Pav' => 30)

hotels = [box8, locavore, flavours]

request = Hotel.new('', {})
request.search(dish_name, price, hotels)
=end

=begin
class Hotels
	attr_reader	:menu, :hotels
	def initialize(item)
		@menu = item
	end
	def search (dish_name, price)
		menu[dish_name.to_sym] == price
	end
end

dish_name = 'Dal'
price = 10
results = []
#dish_name = 'Vada_Pav'
#price = 30

box8 = Hotels.new({ Rajma: 30,  Vada_Pav: 50, Dal: 10})
locavore = Hotels.new({ Dal: 10, Vada_Pav: 30, Sabji: 40})
flavours = Hotels.new({ Ice_cream: 10, Sandwich: 20, Burger: 30, Vada_Pav: 30})

result1 = box8.search(dish_name, price)
results << 'Box 8' if result1 == true

result2 = locavore.search(dish_name, price)
results << 'Locavore' if result2 == true

result3 = flavours.search(dish_name, price)
results << 'flavours' if result3 == true

puts results
=end