fun compose(f, g) = fn x => f(g x)
(* ('b -> 'c)*('a -> 'b) -> ('a -> c) *)

fun sqrt_of_abs i = Math.sqrt (Real.fromInt(abs i))

val sqrt_of_abs_better = Math.sqrt o Real.fromInt o abs

infix !>
fun x !> f = f x

fun sqrt_of_abs_different i = i !> abs !> Real.fromInt !> Math.sqrt
(* a o c o b 5 *)
fun b x = x
fun c x = x
fun a x = x

fun compositions x = x !> b !> c !> a

fun backup1(f, g) = fn x => case f x of NONE => g x
                                        |SOME y => y

fun backup2(f, g) = fn x => f x handle _ => g x
