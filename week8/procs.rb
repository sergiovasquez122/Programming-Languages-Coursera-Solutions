# All a method can do with a block is yield to i
# - Cannot return it, store it in an object
# - But can also turn blocks into real closures
# - closures are instances of class Proc
#   -- called with method call
# 
# Blocks are "second-class"
# Procs are "first-class expressions"
#
# In ruby multiple ways to make proc object

# First-class makes closures more powerful than blocks
# This helps us understand what first-class means
