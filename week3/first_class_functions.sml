(* First-class functions: can use them wherever we use value*)
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
