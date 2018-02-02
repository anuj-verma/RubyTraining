class Resto
  attr_reader :name, :dishes
  def initialize(name, dishes)
    @name = name
    @dishes = dishes
  end

  def search_dishes(query)
    dishes.each do |dish|
      if dish.name.casecmp(query.name).zero? && dish.price <= query.price
        return name
      end
    end
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
    @restos = input_info
    @query = input_query
  end

  def input_query
    puts 'Enter dish name:'
    dish_name = gets.chomp.to_s
    puts 'Enter price: '
    dish_price = gets.chomp.to_i
    Dish.new(dish_name, dish_price)
  end

  def find_restos
    result = []
    restos.each do |resto|
      result << resto.search_dishes(query) if resto.search_dishes(query)
    end
    result
  end

  def input_info
    restos = []
    restos << Resto.new('Box8', [Dish.new('Rajma', 30),
                                 Dish.new('Dal', 20),
                                 Dish.new('Vada Pav', 50)])
    restos << Resto.new('Loacvore', [Dish.new('Sabji', 40),
                                     Dish.new('Dal', 10),
                                     Dish.new('Vada Pav', 30)])

    restos << Resto.new('Box8', [Dish.new('Ice cream', 10),
                                 Dish.new('Vada Pav', 30)])

    restos
  end
end

p Main.new.find_restos
