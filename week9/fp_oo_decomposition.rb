class Exp
end

class value < Exp
end

class Int < value
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
end
