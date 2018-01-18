module A
  def func
    puts 'hello'
  end
end

class Restaurant
end

a = Restaurant.new
a.extend A

