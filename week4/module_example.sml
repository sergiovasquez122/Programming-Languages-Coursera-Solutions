(* By revealing the datatype definition, we let clients violate our invariants
* by directly creating values of tyep Rational1.rational *)
signature RATIONAL_A = 
sig
  datatype rational = Whole of int | Frac of int * int
  exception BadFrac
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end
(* Key idea: An ADT must hide the concrete type definition so clients cannot
* create invariant-violating values of the type directly *)
signature RATIONAL_B = 
sig 
  type rational(* means the type exists, but clients do not know its definition *)
  exception BadFrac
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end

structure Rational1 :> RATIONAL_B = 
struct

  datatype rational = Whole of int | Frac of int * int
  exception BadFrac

  fun gcd(x, y) = 
    if x = y
    then x
    else if x < y
    then gcd(x, y - x)
    else gcd(y, x)

  fun reduce r =
    case r of 
         Whole _ => r
       | Frac(x, y) => 
           if x = 0
           then Whole 0
           else let 
             val d = gcd(abs x, y) in
             if d = y
             then Whole(x div d)
             else Frac(x div d, y div d)
                end

  fun make_frac(x, y) = 
    if y = 0
    then raise BadFrac
    else if y < 0 
    then reduce(Frac(~x, ~y))
    else reduce(Frac(x, y))

  fun add(r1, r2) = 
    case (r1, r2) of
         (Whole(i), Whole(j)) => Whole(i + j)
       | (Whole(i), Frac(j, k)) => Frac(j + k * i, k)
       | (Frac(j, k), Whole(i)) => Frac(j + k * i, k)
       | (Frac(a, b), Frac(c, d)) => reduce (Frac(a * d + b * c, b * d))

  fun toString r = 
    case r of
         Whole i => Int.toString i
       | Frac(a, b) => (Int.toString a) ^ "/" ^ (Int.toString b)
end
(* Nothing a client can do to violate invariants and properties 
* only way to make first rational is make_frac
* after that only make_frac, add and toString 
* outside world doesn't know where rational is a datatype*)

(* signatures hide implementation details from the users and can be used to
* define abstract types and enforce representation invariants. Signatures sdo
* this by hiding function signatures and data type constructors *)

(* two way to use signatures for hiding 
* 1. Deny binding exists
* 2. Make types abstract *)

(* Exposing the Whole constructor poses no problem *)
signature RATIONAL_C = 
sig
  type rational
  exception BadFrac
  val Whole : int -> rational
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end
