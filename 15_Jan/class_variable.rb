class Restraunt
	@open = 'HI'
	
	def self.opens
		@open
	end

	def opens
		@open
	end
end

rest = Restraunt.new
puts rest.opens
puts Restraunt.open
