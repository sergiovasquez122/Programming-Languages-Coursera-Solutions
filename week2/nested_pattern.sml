fun len' xs =
  case xs of
       [] => 0
     | x::xs' => 1 + len' xs'

fun len' xs = 
  case xs of
       [] => 0
     | _::xs' => 1 + len' xs'

exception BadTriple

fun zip3 list_triple = 
  case list_triple of 
       ([], [], []) => []
     | (x::xs, y::ys, z::zs) => (x, y, z)::zip3(xs, ys, zs)
     | _ => raise BadTriple

fun unzip3 lst =
  case lst of
       [] => ([], [], [])
       | (a, b, c)::t1 => let 
                           val (l1, l2, l3) = unzip3 t1
                          in
                            (a::l1, b::l2, c::l3)
                          end

fun nondecreasing intlist = 
  case intlist of
       [] => true
     | _::[] => true
     | x::y::xs' => x <= y andalso nondecreasing (y::xs')

datatype sgn = P | N | Z

fun multsign(x1, x2) = 
let fun sign x = if x = 0 then Z else if x > 0 then P else N
in 
  case (sign x1, sign x2) of
       (Z, _) => Z
     | (_, Z) => Z
     | (P, P) => P
     | (N, N) => P
     | (N, P) => N
     | (P, N) => N
end
