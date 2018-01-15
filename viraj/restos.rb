class Resto
	attr_reader :name, :menu
	def initialize(name, menu)
		@name = name
		#(e.g) menu = [{name: 'Rajma', price: 30}, {name: 'Dal', price: 20}]
		@menu = menu
	end

	def search_menu(query)
		name if menu.include?(query)
	end
end

class RestoFinder
	def initialize
		@restos = input_info
		@query = input_query
	end

	def input_query
		puts 'Enter dish name:'
		dish_name = gets.chomp.to_s
		puts 'Enter price: '
		dish_price = gets.chomp.to_i
		{ name: dish_name, price: dish_price }
	end

	def find_restos
		result = []
		for resto in @restos
			result << resto.search_menu(@query) if resto.search_menu(@query)
		end
		result
	end

	def input_info
		restos = []
		restos << Resto.new('Box8', [{name: 'Rajma', price: 30},
																			{name: 'Dal', price: 20},
																			{name: 'Vada Pav', price: 50}])
		restos << Resto.new('Loacvore',[{name: 'Sabji', price: 40},
																					{name: 'Dal', price: 10},
																		 			{name: 'Vada Pav', price: 30}])

		restos << Resto.new('Flavours',[{name: 'Ice cream', price: 10},
																		 			{name: 'Sandwich', price: 20},
																		 			{name: 'Vada Pav', price: 30},
																		 			{name: 'Burger', price: 30}])
		restos
	end
end

p RestoFinder.new.find_restos