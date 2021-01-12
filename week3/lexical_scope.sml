(* function bodies can usee any bindings in scope *)
(* lexical scope: where the function was called not the environment where it was
* called *)

(* 1 *) val x = 1
            (* x maps to 1 *)
(* 2 *) fun f y = x + y

(* 3 *) val x = 2

(* 4 *) val y = 3

(* 5 *) val z = f (x + y)
