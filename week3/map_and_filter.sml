fun map'(f,xs) = 
  case xs of
       [] => []
     | x::xs' => (f x)::map'(f, xs')

val x1 = map'((fn x => x + 1), [4, 8, 12, 16])
val x2 = map'(hd, [[1], [2], [3], [4, 5]])
val x3 = map'((fn x => x mod 2 = 0), [4, 8, 12, 16, 17])

fun filter'(f, xs) = 
  case xs of
       [] => []
     | x::xs' => if f x 
                 then x :: filter'(f, xs')
                 else filter'(f, xs')

fun is_even x = x mod 2 = 0
fun is_odd x = not (is_even x)
fun all_even_snd xs = filter'(fn (_, v) => is_even v, xs)
