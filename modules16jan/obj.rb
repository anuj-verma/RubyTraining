class Guru
  def ashirwad(obj, method)
    obj.define_singleton_method(method){ p 'bk,f'}
  end
end

class Shishay
end

arjun = Shishay.new
guru
obj = Some.new
=begin
def obj.print
  p 'new method print'
end

obj.print
p obj.instance_eval( 'undef :print')
def obj.print
  p 'new method print22'
end

obj.print
=end
