(* fundamental software-engineering idea
*
* made easier with
* - Abstraction
* - Fewer side effects 
*)

(* Must reason about equivalence all the time 
* Code maintenance: Can I simply this code
  Backward compatibility: Can I add new features without changing how any old
  features work? 
  Optimization: Can I make this code faster
  Abstraction: Can an external client tell I made that change *)

(* Two functions are equivalent if they have the same observable behavior no
* matter how they are used anywhere in any program *)

(* Given equivalent arguments, they 
* -Produce equivalent results
* -Have the saem termination behavior
* -Mutate memory in the same way
* -Do the same input/output
* -Raise the same exceptions *)

(* Notice it is much easier to be equivalent if 
* -there are fewer possible arguments 
* -we avoid side-effects mutations, input/output and exceptions *)
(* these functions are equivalent *)
fun f x = x + x

val y = 2
fun g x = y * x (* fun g x = 2 * x *)
(* these functions are not equivalent depending on f*)
fun g(f, x) = (f x) + (f x)

val y = 2
fun g (f, x) = 
  y * (f x)
(* great reason for "pure" functional programming (ex: haskell)*)
