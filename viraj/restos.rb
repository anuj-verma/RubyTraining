class Resto
	attr_reader :name, :dishes
	def initialize(name, dishes)
		@name = name
		@dishes = dishes
	end

	def search_dishes(query)
		dishes.each { | dish |
			return name if(dish.name.downcase == query.name.downcase && dish.price == query.price)
		}
		false
	end
end

class Dish
	attr_reader :name, :price
	def initialize(name, price)
		@name = name
		@price = price
	end
end

class Main
	attr_reader :restos, :query
	def initialize
		@restos = get_info
		@query = get_query
	end

	def get_query
		puts 'Enter dish name:'
		dish_name = gets.chomp.to_s
		puts 'Enter price: '
		dish_price = gets.chomp.to_i
		Dish.new(dish_name, dish_price)
	end

	def find_restos
		result = []
		for resto in restos
			result << resto.search_dishes(query) if resto.search_dishes(query)
		end
		result
	end

	def get_info
		restos = []
		restos << Resto.new('Box8', [Dish.new('Rajma', 30),
																			Dish.new('Dal', 20),
																			Dish.new('Vada Pav', 50)])
		restos << Resto.new('Loacvore', [Dish.new('Sabji', 40),
																			Dish.new('Dal', 10),
																			Dish.new('Vada Pav', 30)])

		restos << Resto.new('Box8', [Dish.new('Ice cream', 10),
																			Dish.new('Sandwich', 20),
																			Dish.new('Vada Pav', 30),
																			Dish.new('Burger', 30)])

		restos
	end
end

p Main.new.find_restos