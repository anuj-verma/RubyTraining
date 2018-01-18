numbers = [1, 2, 3, 4]

def method_map(input_array)
  output_array = []
  input_array.each do |entry|
    output_array.push(yield(entry)) if block_given?
  end
  output_array
end

new_array = method_map(numbers) do |number|
  number * 5
end

p new_array
