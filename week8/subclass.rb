# Subclasses, inheritance and overriding
# - The essence of OOP
# A class definition has a superclass
# The superclass affects the class definition:
# - Class inherits all method definitions from superclass
# - But class can override method definitions as desired
#
# Unlike java
# - No such things as "inheriting fields" since all objects create instance variables by assigning to them
# - subclassing has nothing to do with a type system: can still call any method on any object
class Point
  attr_accessor :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end
  def distFromOrigin
    Math.sqrt(@x * @x + @y * @y)
  end
  def distFromOrigin2
    Math.sqrt(x * x + y * y)
  end
end

class ColorPoint < Point
  attr_accessor :color
  def initialize(x, y, c = "clear")
    super(x, y) # call initialize method in point class
    @color = c
  end
end
# using methods like isa and instance of is usually non-OOP style
# - Disallows other things that act like a duck
