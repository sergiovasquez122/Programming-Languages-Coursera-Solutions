(* structures without using signatures really only provide namespace management 
* using signatures give a type for modules 
* this allows us to provide interfaces that code outside the module must obey *)
signature MATHLIB = 
sig
  val fact : int -> int
  val half_pi : real
  val doubler : int -> int
end
(* If the signature provides something the structure 
*  does not provide we would get a error from the typechecker reminding us we
*  didn't provide it *)
structure MyMathLib :> MATHLIB =
struct
  fun fact(n) = 
  let 
    fun accum(n, acc) = 
        case n of
             0 => acc
            |n => accum(n - 1, acc * n)
  in 
    accum(n, 1)
  end

  val half_pi = Math.pi / 2.0;

  fun doubler y = y + y
end
(* In general
*  signatures can be written as 
*  signatures SIGNAME  =
*  sig type-for-bindigns end
*
*  -Can include variables, types, datatypes, and exceptions 
*  defined in module
*
*  -Ascribing a signature to a module
*  structure MyModule :> SIGNAME = 
*  struct bindings end
*  -Module will not type-check unless it matches the signature, meaning it has
*  all the bindings as the right types
*)

(* the real value of signatures is to hide bindings and type definitions
*
* hiding details is the most important strategy for writing correct, robust,
* reusuable software
*
* so first remind ourselves that functions already do well for some form of hiding *)
fun double x = x * 2
fun double x = x + x
val y = 2
fun double x = x + y
(* have private top-level functions *)
signature MATHLIB2 = 
sig
  val fact : int -> int
  val half_pi : real
  (* did not provide doubler binding so cannot be used directly, still can be
  * used inside the module *)
end

structure MyMathLib2 :> MATHLIB2 =
struct
  fun fact(n) = 
  let 
    fun accum(n, acc) = 
        case n of
             0 => acc
            |n => accum(n - 1, acc * n)
  in 
    accum(n, 1)
  end

  val half_pi = Math.pi / 2.0;

  fun doubler y = y + y
end
