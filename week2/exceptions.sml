fun hd xs =
  case xs of
       [] => raise List.Empty
     | x::_ => x

fun maxlist(xs, ex) = 
  case xs of
       [] => raise ex
     | x::[] => x
     | x::xs' => Int.max(x, maxlist(xs', ex))
