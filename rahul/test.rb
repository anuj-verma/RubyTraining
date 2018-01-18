def print_msg(name)
  puts 'method start'
  yield(name) if block_given?
  puts 'method end'
end

print_msg('rahul'){ |name| puts "my name is #{name}" }
print_msg('pune'){ |name| puts "city is #{name}" }
