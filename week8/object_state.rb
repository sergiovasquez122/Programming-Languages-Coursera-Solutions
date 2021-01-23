# Objects have state
# An Object's state persists
# - Can grow and change from time object is created
#
# State only directly accessible from object's methods
# - Can read, write, extend the state
# - Effects persists for next method call
#
# State consists of instance variables
# - Syntax start with @
# - Spring into being with assignment
# -- So mis-spelling silently add new state
# - Using one not in state not an error
# 
# Creating an object returns a reference to a new object
# - Different states from every other object
#
# Variable assignments creates an alias
# - Aliasing means same object means same states
class A

  def initialize(f = 0)
    @foo = f
  end

  def m1
    @foo = 0
  end

  def m2 x
    @foo = @foo + x
    @bar = 0
  end

  def foo 
    @foo
  end
end
# A method named initialize is special
# - its caleld on a new object before new return
# - arguments to new are passed on to initialize
# - excellent for creating object invariants
class C
  dans_age = 38

  def self.reset_bar
    @@bar = 0
  end

  def initialize(f=0)
    @foo = f
  end

  def m2 x
    @foo += x
    @@bar += 1
  end

  def foo
    @foo
  end

  def bar
    @@bar
  end
end
