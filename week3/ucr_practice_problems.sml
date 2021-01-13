(* Write each of the following SML functions. Once you have written the
* functions, try to reason about the most general type the SML type checker
* would assign to the function binding *)
(* including helper functions *)
val map = List.map
val filter = List.filter
val foldl = List.foldl
val exists = List.exists
val filter = List.filter
(* Write a function swap_pair that takes the values a and b and returns a pair
* that has the given values in the reverse order they were passed in*)
(* fun : 'a * 'b ->  b' * a' *)
fun swap_pair(a, b) = (b, a)
(* Write a function swap_pairs_list that takes a list of pairs and returns a
* list of pairs with each of the original pairs values swapped *)
(* fun : (a' * b') list -> (b' * a') list *)
fun swap_pairs_list xs = map swap_pair xs
(* Write a function size t hat that takes a list and return sthe number of elements in that list *)
(* fun : a' list -> int *)
fun size xs = foldl (fn(_, y) => y + 1) 0 xs
(*Write a function contains that takes a value and a list and return true if the
* given value is in the list *)
(* fun : ''a -> ''a list -> bool *)
fun contains x xs = exists (fn k => k = x) xs
(* Write a function remove_all that takes a value and a list and returns a list
* of the values in the original list not equal to the given value *)
(* fun : ''a -> ''a list -> ''a list *)
fun remove_all x xs = filter (fn y => y <> x) xs
type cart = real * real
datatype shape = 
        Circle of cart * real
               | Square of cart * real
               | Rectangle of cart * real * real

fun area s = 
  case s of
       Circle(_, radius) => radius * radius * Math.pi 
     | Square(_, length) => length * length
     | Rectangle (_, l, w) => l * w


fun in_quadrant_one s = 
  case s of
       Circle((x, y), _) => x > 0.0 andalso y > 0.0
     | Square((x, y), _) => x > 0.0 andalso y > 0.0
     | Rectangle((x, y), _, _) => x > 0.0 andalso y > 0.0

fun quadrant_one_only xs = filter in_quadrant_one xs


fun construct_squares xs = map (fn x => Square((Real.fromInt x, Real.fromInt x), Real.fromInt (abs x)) ) xs

datatype exp = Constant of int
             | Negate of exp
             | Add of exp * exp
             | Multiply of exp * exp

fun eval e = 
  case e of 
       Constant i => i
     | Negate ei => ~(eval ei)
     | Add(e1, e2) => eval e1 + eval e2
     | Multiply(e1, e2) => eval e1 * eval e2
