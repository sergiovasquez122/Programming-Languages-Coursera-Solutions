fun sum_triple(triple : int * int * int) = 
  case triple of
       (x, y, z) => x + y + z

fun full_name(r : {first : string, middle : string, last : string}) = 
  case r of
       {first = x, middle = y, last = z} => x ^ " " ^ y ^ " " ^  z

fun full_name(r : {first : string, middle : string, last : string}) = 
let val {first = x, middle = y, last = z} = r
in
  x ^ " " ^ y ^ " " ^ z
end

fun sum_triple(triple : int * int * int) = 
  let val (x, y, z) = triple
  in
    x + y + z
  end

fun full_name {first = x, middle = y, last = z} = 
  x ^ " " ^ y ^ " " ^ z

fun sum_triple(x, y, z) = 
  x + y + z

fun rotate_left(x, y, z) = (y, z, x)

fun rotate_right triple = rotate_left(rotate_left triple)
