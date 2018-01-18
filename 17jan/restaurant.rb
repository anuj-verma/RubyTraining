class Dish
  attr_reader :name
  def initialize(name)
    @name = name
  end
end

class Menu
  attr_reader :dish_name, :dish_price, :type 
  def initialize(dish_name, dish_price, type)
    @dish_name = dish_name
    @dish_price = dish_price
    @type = type
  end
end

class Restaurant
  @@restaurants = []
  @@result = []
  attr_reader :name, :menu 
   def initialize(name, menu)
    @name = name
    @menu = menu
    @@restaurant << self
   end
  def search(item, price)
    @@restaurants.each do |restaurant|
      @@result << menu.dish.name if menu.dish.name == item && menu.price == price }
    p @@result
  self.menu.each{ |m| puts m.dish.name  }
  end
end

dish1 = Dish.new('Vadapav')
dish2 = Dish.new('Rajma')
dish3 = Dish.new('Dal')
dish4 = Dish.new('Icecream')
dish5 = Dish.new('sandwich')
dish6 = Dish.new('Burger')
dish7 = Dish.new('Sabji')

Restaurant.new('BOX8',  [Menu.new(dish1, 50, 'Snacks'), Menu.new(dish2, 30, 'Lunch'), Menu.new(dish3, 20, 'Lunch'])
Restaurant.new('Locavore', [Menu.new(dish1, 50, 'Snacks'), Menu.new(dish3, 10, 'Lunch'), Menu.new(dish7, 40, 'Lunch)'])
=begin
class Restaurant
  @@restaurants = []
  @@result = []
  attr_reader :menu, :name

  def initialize(name, menu)
    @name = name
    @menu = menu
    @@restaurants << self
  end

  def search(item, price)
    @@restaurants.each{ |restaurant| @@result << restaurant.name if restaurant.menu[item] == price }
    p @@result
  end
end

Restaurant.new('Box8', Vadapav: 50, Rajma: 30, Dal: 20)
Restaurant.new('Flavours', Icecream: 10, Sandwich: 20, Burger: 30, Vadapav: 40)
Restaurant.new('Locavore', Vadapav: 50, Dal: 10, Sabji: 40)
restaurants = Restaurant.new('', {})

p 'Enter dish name'
dish = gets.chomp.to_sym
p 'Enter price'
price = gets.chomp.to_i
restaurants.search(dish, price)
=end
