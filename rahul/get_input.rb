def get_input(type)
  puts "enter #{type}"
  yield if block_given?
end

get_input('string') {puts gets.chop.class}
get_input('integer') {puts gets.chop.to_i.class}

