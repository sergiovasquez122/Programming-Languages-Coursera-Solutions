fun curry f = fn x => fn y => f (x, y)

fun uncurry f(x, y) = f x y

fun range(i, j) = if i > j then [] else i :: range(i + 1, j)

val countup = (curry range) 1

fun other_curry f = fn x => fn y => f y x

fun other_curry2 f x y = f y x

val xs = countup 7
