(* every ml function takes exactly one argument *)
fun sorted3_tuple(x, y, z) = z >= y andalso y >= x

val t1 = sorted3_tuple(7, 9, 11)

val sorted3 = fn x => fn y => fn z => z >= y andalso y >= x

val add = fn x => fn y => x + y

val sub = fn x => fn y => x - y

(* syntatic sugar for currying *)
fun sorted3_nicer x y z = z >= y andalso y >= x

val t4 = sorted3_nicer 7 9 11

fun add_nicer x y = x + y
fun sub_nicer x y = x - y

fun f(a, b, c) = a + b + c

fun add_3 a b c = a + b + c

fun fold f acc xs = 
  case xs of
       [] => acc
     | x::xs' => fold f (f(acc, x)) xs'

fun sum xs = fold (fn(x ,y) => x + y) 0 xs
