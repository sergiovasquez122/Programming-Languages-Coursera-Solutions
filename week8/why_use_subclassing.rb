# Programmers often overuse subclassing in OOP languages
# Instead of subclassing Point could copy/paste the methods
# - works, but code reuse is nice
#
# Instead of subclassing Point, could use a Point instance variable
# - Define methods to send same message to the Point
# - But for ColorPoint, subclassing makes sense: less work and can use a ColorPoint wherever code expects a Point
