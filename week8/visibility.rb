# We know "hiding things" is essential for modularity and abstraction
#
# OOP generally have various ways to hide instance variables, methods, classes
#
# In Ruby, object state is always state
#
# - Only an object's methods can access its instance variables
# - Not even another instance of the same class
#
# - to make object/state public we use getter/setters
#
# :attr_reader :foo :bar
# :attr_accessor :foo, :bar
#
# despite sugar: getters/setters are just methods
#
# three visibilities for methods in ruby
# - private
# - protected
# - public
#
# method are public by default
# - multiple ways to change a method's visibility
