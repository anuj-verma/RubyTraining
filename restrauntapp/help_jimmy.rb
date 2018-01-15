require 'yaml'

def load_data
  YAML.load_file('data.yml')
end

def save_data(rlist)
  File.open('data.yml', 'w') do |f|
    f.write(rlist.to_yaml)
  end
end

class Dish
  def initialize(item:, price:)
    @item = item
    @price = price
  end
end

class Restaurant
  attr_accessor :name, :menu
  def initialize(name:, menu:)
    @name = name
    @menu = menu
  end

  def add
    print 'Enter the name of restraunt:'
    @name = gets.chomp
    puts 'Enter menu of restraunt'
    @menu = {}
    loop do
      print 'Enter item and price(n to quit): '
      item, price = gets.chomp.split(' ')
      break if item == 'n'
      @menu.store(item.to_sym, Dish.new(item: item, price: price.to_f))
    end
  end
end

class RestaurantGuide
  attr_accessor :restraunt_list
  def initialize(list:)
    @restaurant_list = list
  end

  def create_guide
    loop do
      obj = Restaurant.new(name: nil, menu: {})
      obj.add
      @restaurant_list << obj
      print "\nDo you want to continue adding restaurant(y/n): "
      option = gets.chomp
      puts
      break if option == 'n'
    end
    save_data(@restaurant_list)
  end

  def search_guide(item:, price:)
    @restaurant_list.map do |restaurant|
      if restaurant.menu.key?(item.to_sym) && price >= restaurant.menu[item.to_sym].price
        restaurant.name
    end
  end
end

def main
  list = load_data
  list ||= []
  r_list = RestaurantGuide.new(list: list)
  # r_list.create_guide
  loop do
    print 'Enter menu item and price: '
    item, price = gets.chomp.split(' ')
    break if item == 'n'
    puts r_list.search_guide(item: item, price: price.to_f).compact
  end
end

main
