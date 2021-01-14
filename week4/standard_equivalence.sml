(* using or not using syntatic sugar is always equivalent 
* by definition, else it wouldn't be syntatic sugar *)
fun g x = not x

fun f x = x andalso g x

fun f' x = 
  if x 
  then g x 
  else false 
(* evaluation order matters, 
 * these functions are not equivalent.*)
fun f x = x andalso g x

fun f x = 
  if g x 
  then x 
  else false

(* three general equivalences that always work for functions in any decent
* language *)
(* 1. consistently rename bound variables and uses *)
val y = 14
fun f x = x + y + x 

val y = 14
fun f z = z + y + z
(* these functions are not equivalent *)
val y = 14
fun f x = x + y + x (* evaluates to 2 * x + y *)

val y = 14
fun f y = y + y + y (* shadows top level y and evaluates to 3 * y *)

(* these functions are not equivalent *)
fun f x = 
let val y = 3 
    in x + y (* evaluates to x + 3*)
end

fun f y = 
let val y = 3
      in y + y (* shadows other and evaluates to 6 *)
end
(* 2. use a helper function or not and caller's should not be able to tell *)
(* these functions are equivalent *)
val y = 14
fun g z = (z + y + z) + z
  
val y = 14
fun f x = x + y + x
fun g z = (f z) + z
(* still need to be careful about environments in which functions were created 
* these functions are not equivalent *)
val y = 14
val y = 7
fun g z = (z + y + z) + z

val y = 14
fun f x = x + y + x
val y = 7
fun g z = (f z) + z
(* quiz question: 
* are the functions f and g equivalent in the code below? *)
fun f x = x + x
val x = 10 
val y = 30
fun g y = y + y
(* these functions are equivalent, g shadows the y in scope and then add y to
* itself effectively doubling the value of y. these provides the same result of
       * doubling which f does and hence they are equivalent *)

(* 3. unnecessary function wrapping still make a function equivalent *)
(* these two functions are equivalent *)
fun f x = x + x
fun g y = f y

fun f x = x + x
val g = f
(* if calling function has side-effects might not be equivalent *)
