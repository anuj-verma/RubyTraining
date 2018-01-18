
#The following code results in 'LocalJumpError'

test_proc = Proc.new{ return 'sadfasdfasd'}

def test_proc(proc)
	proc.call
	p '22222222'
end

p test_proc(test_proc)

#The following code will explain why we get that error

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

=begin
In the above code we have called method definig_method, this method has a proc named proc1 defined inside it.
We then pass it to another method caller_method where this proc1 is called.
Since there is a return statement in the proc, we return from the method where that proc is defined i.e defining_method.

Similarly in the first code, we had not defined proc inside any method, so it was trying to return from where it was,
which caused the "LocalJumpError" 
=end