def test_method(input)
	Proc.new{|x| return x%2==0}.call(input)
	puts 'hi'
end

puts test_method(5)

puts test_method(6)

proc = Proc.new{ return 'sadfasdfasd'}

def test_proc(proc)
	proc.call
	p '22222222'
end

p test_proc(proc)
p '111111'