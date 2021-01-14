val x = 42
(* f : t1 * t2 * t3 -> t4 *)
(* z : int since it is added to an int *)
(* y : bool since it the value for a conditional *)
(* w : alpha' since it is not used in the argument *)
(* t4 : int since it must have the same type of its branch statements which must
* be the same *)
(* f : bool * int * 'a -> int *)
fun f(y, z, w) = if y then z + x else 0
(* note this shadows the previous function *)
(* f : t1 -> t2 *)
(* x : t1 since it is the argument of f*)
(* y :  t2 *)
(* z : t3 *)
(* x : t2 * t3 since it is pattern matched to retrieve a tuple *)
(* t2 : int since abs s.t int -> int *)
(* t3 : int since z is added to an int *)
(* f : int * int -> int *)
fun f x = 
let val (y, z) = x in
  (abs y) + z
end
(* sum : t1 -> t2 *)
(* xs : t1 *)
(* x : t3 *)
(* xs : t3 list *)
(* t2 must be an int *)
(* t3 must be an int *)
(* sum : int list -> int *)
fun sum xs = 
  case xs of
       [] => 0
     | x::xs' => x + sum(xs')
(* bad function *)
(* bad_sum : t1 -> t2 *)
(* xs : t1 *)
(* t2 : int *)
(* x : t3 *)
(* xs : t3 list *)
(* x must also be an t3 since since called *)
(* contradicts previous declaration *)
fun bad_sum xs = 
  case xs of
       [] => 0
     | x::xs' => x + bad_sum x
(* example with Polymorphic types *)
(* length' : t1 -> t2 *)
(* t2 must be of type int since it is the type of the value returned from one of
       * the case expressions
       * x : t3 
       * xs : t3 list
       * t1 : t3 list
       *
       * length' : t3 list -> int 
       * length' : 'a list -> int *)
fun length' xs = 
  case xs of
       [] => 0
     | x::xs' => 1 + length' xs
(* compose (t1 * t2) -> t3 *) 
(* x : t4 *)
(* g : t4 -> t5 *)
(* f : t5 -> t6 *)
(* t3 : t6 *)
(* compose (t5 -> t6) * (t4 -> t5) -> t4 -> t6*)
(* compose (a' -> b') * (c' -> a') -> c' -> b'*)
fun compose (f, g) = fn x => f (g x)
(* f : t1 * t2 * t3 -> t4 *)
(* t4 : (t1, t2, t3) by first clause*)
(* t4 : (t2, t1, t3) by second clause*)
(* t1 = t2 *)
(* t4 : (t1, t1, t3) *)
(* f : 'a * 'a * 'b -> ('a, 'a, 'b)*)
fun f(x, y, z) = 
  if true
  then (x, y, z)
  else (y, x, z)
