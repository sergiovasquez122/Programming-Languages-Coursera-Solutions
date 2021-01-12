fun fold(f, acc, xs) = 
  case xs of
       [] => acc
     | x::xs => fold(f, f(acc, x), xs)

fun f1 xs = fold(fn(x, y) => x + y, 0, xs) (* sum list *)
fun f2 xs = fold(fn(x, y) => x andalso y >= 0, true, xs) (* determine if all elements are non-negative*)
fun f3(xs, lo, hi) = 
  fold(fn(x, y) => x + (if y >= lo andalso y <= hi then 1 else 0), 0, xs)

fun f4(xs, s) =
let 
  val i = String.size s
in 
  fold(fn (x, y) => x andalso String.size y < i, true, xs)
end

fun f5(g, xs) = fold(fn(x, y) => x andalso g y, true, xs)

fun f4again(xs, s) = 
let 
  val i = String.size s
in 
  f5(fn y => String.size y < i, xs)
end
(* functions like map, filter, and fold are much more powerful thanks to
* closures and lexical scope *)
