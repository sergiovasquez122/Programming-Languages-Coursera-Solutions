# "If it walks likea duck and quacks like a duck, it's a duck"
# - Or don't worry that it may not be a duck
#
# More code reuse; very OOP approach
# - What messages an object receive is "all that matters"
def mirror_update pt
  pt.x = pt.x * (-1)
end
# takes a point object and negate the x value
# - Makes sense, though a Point instance method more OOP
#
# closer: takes anythign with getter and setter methods for @x instance variable and multiples the x field by -1
# closer: takes with anything x= and x and calls x = with the result of multiplying x and -1
# duck typing: takes anything with method x= and x where result of x has a * method that can take -1. Sends reuslt of calling x the * message with -1 and sends that result to x=
# plus: maybe method is more useful in ways we did not anticipate
# minus: can abuse duck typing
def double x 
  x + x
end
