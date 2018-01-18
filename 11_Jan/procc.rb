def defining_method
	puts 'This is big method'
	proc1 = Proc.new { return 'HI I Am proc1 inside big method'}
	caller_method(proc1)
	puts 'this is end of big method'
end

def caller_method(a)
	puts 'Hi I am small method'
	a.call
	puts 'Hi this is end of small method'
end

defining_method
