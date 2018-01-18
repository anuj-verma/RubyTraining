module A

  def self.included base
    base.send :include, InstanceMethods
    base.send :extend, ClassMethods
  end

  module InstanceMethods
    def my_instance_method
      "module A instance method"
    end
  end

  module ClassMethods
    def my_class_method
      "module B class method"
    end
  end
end

class MyClass
  include A
end

p MyClass.new.methods
p MyClass.new.my_instance_method
p MyClass.my_class_method

