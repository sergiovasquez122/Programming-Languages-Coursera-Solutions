(* Programming problem*)

(* eval | toString | hasZero *)
(* Int *)
(* Add *)
(* Negate *)

(* Define a datatype for expressions, with one constructor for each variant*)
(* All the data is defined in one place *)
datatype exp =
Int of int
             | Negate of exp
             | Add of exp * exp
             | Mult of exp * exp (* we later add Mult of exp * exp to the datatype *)
                                 (* we have to alter all the functions to accomodate *)
exception BadResult of string

(* implemented column at a time*)
fun add_values v1 v2 =
  case (v1, v2) of
       (Int i, Int j) => Int(i + j)
     | _ => raise BadResult "non-ints in addition"

fun mult_values v1 v2 =
  case (v1, v2) of
       (Int i, Int j) => Int(i * j)
     | _ => raise BadResult "non-int in multiplication"

fun eval e =
  case e of
       Int _ => e
     | Negate e1 => (case eval e1 of
                          Int i => Int(~i)
                        | _ => raise BadResult "Non-int in negate")

     | Add(e1, e2) => add_values (eval e1) (eval e2)
     | Mult(e1, e2) => mult_values (eval e1) (eval e2)

fun toString e =
  case e of
       Int i => Int.toString i
     | Negate e1 => "-(" ^ (toString e1) ^ ")"
     | Add(e1, e2) => (toString e1) ^  "+" ^ (toString e2)
     | Mult(e1, e2) => (toString e1) ^ "*" ^ (toString e2)


fun hasZero e=
  case e of
       Int i=> i = 0
     | Negate e1 => hasZero e1
     | Add(e1, e2) => (hasZero e1) orelse (hasZero e2)
     | Mult(e1, e2) => (hasZero e1) orelse (hasZero e2)

(* adding new function is easy *)
(* no need to edit any existing code *)
(* define what the function does given the particular datatype *)
fun noNegConstants e =
  case e of
       Int i => if i < 0 then Negate (Int(~i)) else e
     | Negate e1 => Negate(noNegConstants e1)
     | Add(e1, e2) => Add(noNegConstants e1, noNegConstants e2)
     | Mult(e1, e2) => Mult(noNegConstants e1, noNegConstants e2)

(* Binary Methods with Functional Decompostion *)
(* add_values is defining all 9 entires in this 2-D grid for hwo to add values in our langauge *)
fun add_values (v1, v2) =
  case (v1, v2) of
        (Int i, Int j) => Int (i + j)
        | (Int i, String s) => String(Int.toString i ^ s)
        | (Int i, Rational(j, k)) => Rational(i * k + j, k)
        | (String s, Int i) => String(s ^ Int.toString i)
        | (String s1, String s2) => String(s1 ^ s2)
        | (String s, Rational(i, j) => String(s ^ Int.toString i ^ "/" ^ Int.toString j)
        | (Rational _, Int _) => add_values(v2, v1) (* commutative: avoid duplication *)
        | (Rational (i, j), String s) => String(Int.toString i ^ "/" ^ Int.toString j ^ s)
        | (Rational(a, b), Rational(c, d)) => Rational(a * d + b * c, b * d)
        | _ => raise BadResult "non-values passed to add_values"
