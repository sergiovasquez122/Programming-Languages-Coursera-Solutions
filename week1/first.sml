(* This is a comment. this is our first program. *)

val x = 34; (* int *)
(* static environment: int *)
(* dynamic environment: x -> 34 *)

val y = 17;
(* static environment: x : int, y : int *)
(* dynamic environment: x -> 34, y -> 17 *)

val z = (x + y) + (y + 2);
(* static environment: x : int, y : int, z : int *)
(* dynamic environment: x -> 34, y -> 17, z -> 70 *)

val q = z + 1;
(* static environment: x : int, y : int, z : int , q : int *)
(* dynamic environment: x -> 34, y -> 17, z -> 70, q -> 71 *)
(* first everything typechecked and if that passes everything runs *)
val abs_of_z = if z < 0 then 0 - z else z;

val abs_of_z_simpler = abs z;

(* A variable binding 
* val z = (x + y) + (y + 2) *)

(*Syntax is just how you write something, semantics is what that sometimes
* means*)
