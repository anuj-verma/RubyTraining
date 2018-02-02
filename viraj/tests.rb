# OUTER_COLOR = 'red'
# class Car
# 	def get_color
# 		COLOR
# 	end
# 	COLOR = OUTER_COLOR + "!"
# end

# car1 = Car.new
# p Car::COLOR

module A
	ABC = 1
	module B
		ABC = 2
	end
end

class Test
	include A
	@open = true
	# a class method
	def self.open
		@open
	end
	def method1
		5
	end
end

test_obj = Test.new
p test_obj.class.ancestors

