# The rules of class-based OOP
# In Ruby:
# 1. All values are references to object
# 2. Objects communicate via method calls, also known as messsages
# 3. Each object has its own state
# 4. Every object is an instance of a class
# 5. An object's class determines the object's behavior
# - How it handles method calls
# - Class contains method definitions
class A
  def m1
    34
  end

  def m2(x, y)
    z = 7
    if x > y
      false
    else 
      x + y * z
    end
  end
end

class B
  def m1
    4
  end

  def m3 x
    x.abs * 2 + self.m1
  end
end
# ClassName.new creates a new object whose class is ClassName
# e.m evaluates e to an object and then calls its m method
# - Also know as "sends the m message"
# - Can also write e.m()
# Methods can takes arguments, call like e.m(e1, .., en)
# - Parentheses optional in some places, but recommended
#
# - Methods can use local variables
# -- Syntax stats with letter
# -- Scope is method body
#
# self is a special keyword in Ruby
# refers to the current object
# - The object whose method is executing
#
# So call another method on "same object" with self.m()
class C
  def m1
    print "hi "
    self
  end
  def m2
    print "bye "
    self
  end
  def m3
    print "\n"
    self
  end
end

