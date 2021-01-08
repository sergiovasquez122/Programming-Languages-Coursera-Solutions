(* one-of types are good for enumerating a fixed set of options*)
datatype suit = Club | Diamond | Heart | Spade

datatype rank = Jack | Queen | King | Ace | Num of int

(* useful when you can have a different data in different situtations *)
datatype id = StudentNum of int 
            | Name of string * (string option) * string

datatype exp = Constant of int
             | Negate of exp
             | Add of exp * exp
             | Multiply of exp * exp

fun eval e = 
  case e of 
       Constant i => i
     | Negate e2 => ~ (eval e2)
     | Add(e1, e2) => eval e1 + eval e2
     | Multiply(e1, e2) => (eval e1) * (eval e2)

fun number_of_adds e = 
  case e of 
       Constant i => 0 
     | Negate e2 => number_of_adds e
     | Add(e1, e2) => 1 + number_of_adds e1 + number_of_adds e2
     | Multiply(e1, e2) => number_of_adds e1 + number_of_adds e2

fun at_least_one_multiplication e = 
  case e of
       Constant i => false
     | Negate e2 => at_least_one_multiplication e2
     | Add(e1, e2) => at_least_one_multiplication e1 orelse
     at_least_one_multiplication e2
     | Multiply(e1, e2) => true

fun max_constant e = 
  case e of 
       Constant e => e
     | Negate e => max_constant e
     | Add(e1, e2) => Int.max(max_constant e1, max_constant e2)
     | Multiply(e1, e2) => Int.max(max_constant e1, max_constant e2)
