def input_data
	yield gets.chomp if block_given?
end

# puts "Enter integer"
# num = input_data { |num| num.to_i}
# puts num.class

def my_map! nums
	for i in 0..nums.length - 1
		nums[i] = yield(nums[i])
	end
	nums
end

def my_map nums
	new_nums = []
	for num in nums
		new_nums << yield(num)
	end
	new_nums
end


nums = [1,2,3]
p my_map(nums) {|num| num*6}
p nums