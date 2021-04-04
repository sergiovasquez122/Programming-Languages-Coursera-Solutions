class Exp
end

class Value < Exp
end

# inside each class fill out the row
# 3 methods inside each class
# filled Row a time
# one class per row
class Int < Value
  attr_reader :i
  def initialize i
    @i = i
  end

  def eval
    self
  end

  def toString
    @i.to_s
  end

  def hasZero
    i == 0
  end
  def add_values v # first dispatch
    v.addInt self
  end

  def addInt v # second dispatch: v is an int
    return Int.new(v.i + i)
  end

  def addString v # second dispatch: v is an String
    return MyString.new(v.s + i.to_s)
  end

  def addRational v # second dispatch: v is an Rational
    return MyRational.new(i * v.j + v.i, v.j)
  end
end

class Negate < Exp
  attr_reader :e
  def initialize e
    @e = e
  end
  def eval
    Int.new(~e.eval.i)
  end
  def toString
    "-(" + e.toString + ")"
  end
  def hasZero
    e.hasZero
  end
end

class Add < Exp
  attr_reader :e1, :e2
  def initialize(e1, e2)
    Int.new(e1.eval.i + e2.eval.i)
  end
  def toString
    "(" + e1.toString + " + " + e2.toString + ")"
  end
  def hasZero
    e1.hasZero ||  e2.hasZero
  end
  def noNegConstants
    if i < 0
      Negate.new(Int.new(-1))
    end
    self
  end
end

# adding new class is easy
# we can add a new class without altering any existing code
# adding new method requires we update all existing classes to have that method
class Mult < Exp
  attr_reader :e1, :e2
  def initialize(e1, e2)
    @e1 = e1
    @e2 = e2
  end

  def eval
    Int.new(e1.eval.i * e2.eval.i)
  end

  def toString
    "(" + e1.toString + " * " + e2.toString + ")"
  end

  def hasZero
    e1.hasZero || e2.hasZero
  end

  def noNegConstants
    Mult.new(e1.noNegConstants, e2.noNegConstants)
  end
end

class MyString < Exp
  def add_values v # first dispatch
      v.addString self
  end

  def add_int v # second dispatch: v is an int
      MyString.new(v.i.to_s + s)
  end

  def add_rational v # second dispatch: v is an Rational
      MyRational.new(v.i.to_s + "/" + v.j.to_s + s)
  end
end
# we have 9 cases for addition in 9 different methods
class MyRational < Exp
  def add_values v # first dispatch
      v.add_rational self
  end

  def add_int v # second dispatch: v is an int
      MyRational.new(v.i * j + i, j)
  end

  def add_string v # second dispatch: v is an rational
      MyString.new(v.s + i.to_s + "/" + j.to_s)
  end

  def add_rational v # second dispatch: v is an Rational
      MyRational.new(v.i * j + i * v.j, v.j * j)
  end
end
