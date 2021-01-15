(* What is functional programming? 
* Functional Programming can mean a few different things
* 1. Avoiding mutations in most/all cases
* 2. Using functions as values
*)
(* First-class functions: can use them wherever we use value
* -functions are values too
* -arguments, reuslts, part of tuples *)
(* fun : int -> int*)
fun double x = 2 * x
(* fun : int -> int*)
fun incr x  = x + 1
(* (int -> int)*(int -> int)*int *)
val a_tuple = (double, incr, double (incr 7))
(* (int -> int) list *)
val a_list = [double, incr]
(*functions can argument to other functions and so on*)
val eighteen = (#1 a_tuple) 9;
(* int -> int -> int *)
fun double_or_triple x =
  if x mod 2 = 0
  then fn y => y * 2
  else fn y => y * 3
  (* function closures: functions can use bindings from outside the function
  * definitions 
  * -makes first-class functions much more powerful
  *)
fun inList x xs = List.exists (fn y => y = x) xs
