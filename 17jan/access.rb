class Papa
  protected
   def money
  end

  public
  def ask_mummy
    tooth_brush
    self.money
   # beta_money
  end

  private 
  def tooth_brush
  end
end

class Beta < Papa
  def beta_money
  end
  def beta_tooth
    tooth_brush
    money
  end
end

class Friend
  def borrowed_tooth(obj)
    obj.beta_tooth
   # money undefined method_error
  end
end


b1 = Beta.new
p1 = Papa.new
f1 = Friend.new
f1.borrowed_tooth(b1)
p1.ask_mummy
b1.beta_tooth
#p1.money
#b1.money
#b1.beta_tooth
#Friend.new.borrowed_tooth(b1)
#Beta.new.ask_mummy
#Papa.new.money
#Papa.new.ask_mummy
#Papa.new.tooth_brush
