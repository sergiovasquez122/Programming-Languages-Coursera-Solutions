(* Write each of the following SML functions. Once you have written the
* functions, try to reason about the most general type the SML type checker
* would assign to the function binding *)

(* Write a function swap_pair that takes the values a and b and returns a pair
* that has the given values in teh reverse order they were passed in*)

(* fun : 'a * 'b ->  b' * a' *)
fun swap_pair(a, b) = (b, a)

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

val filter = List.filter

fun in_quadrant_one s = 
  case s of
       Circle((x, y), _) => x > 0.0 andalso y > 0.0
     | Square((x, y), _) => x > 0.0 andalso y > 0.0
     | Rectangle((x, y), _, _) => x > 0.0 andalso y > 0.0

fun quadrant_one_only xs = filter in_quadrant_one xs

val map = List.map

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
