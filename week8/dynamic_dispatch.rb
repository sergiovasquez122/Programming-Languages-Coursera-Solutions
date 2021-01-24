class Point
  attr_accessor :x, :y
 
  def initialize(x, y)
    @x = x
    @y = y
  end

  def distFromOrigin
    Math.sqrt(x * x + y * y)
  end
end

class ThreeOfPoint < Point
  attr_accessor :z

  def initialize(x, y, z)
    super(x, y)
    @z = z
  end

  def distFromOrigin
    d = super
    Math.sqrt(d * d + z * z)
  end
end
