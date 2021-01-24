# Hashes like arrays but
# - Keys can be anything; strings and symbols common
# - No natural ordering like numeric indices
# - Different syntax to make them
# Like a dynamic record with anything for field names
# - often pass a hash rather than many arguments
#
# Ranges like arrays of contiguos numbers but
# - More efficiently represented so large ranges fine
#
# have many of the same methods, particularly iterators
# - Great for duck typing
def foo a
  a.count {|x| x * x < 50}
end
