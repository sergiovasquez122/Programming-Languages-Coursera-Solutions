# Pure object-oriented: all values are objects
# Class-based: Every object has a class that determines behavior
# - Like Java, unlike Javascript
# - Mixins
# Dynamically typed
# Convenient reflection: Run-time inspection of objects
# Very dynamic: Can change class during execution
# Blocks and libaries encourages lots of closure idioms
# syntax, scoping rules, semantics of a "scripting langage"
# - Variable "sprint to life" on use
# - Very flexible arrays
# Scripting language
class Hello
  
  def my_first_method
    puts  "Hello, world!"
  end

end

x = Hello.new
x.my_first_method
