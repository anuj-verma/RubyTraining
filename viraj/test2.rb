class A
	private
	def meth1
		1
	end
end

class B < A
	def meth2
		meth1	#no error
	end
end

p B.new.meth2 #prints 1