fun compose_opt f g x = 
  case g x of
       NONE => NONE
     | SOME y => case f (g x) of
                      NONE => NONE
                    | SOME x => SOME x

fun do_until f p x = 
  case p x of
       false => x
     | true => do_until f p (f x)

fun fixed_point f x = 
  case (f x = x) of
    true => x
     | false => fixed_point f (f x)

fun map2 f (x, y) = (f x, f y)

fun app_all f g x = foldr (fn (x, y) => x @ y) [] (map f (g x))

fun foldl f acc xs = 
  case xs of
       [] => acc
     | x::xs' => foldl f (f(acc, x)) xs'

fun foldr f acc xs =
      case xs of
             [] => acc
           | x::xs' => f(x ,(foldr f acc xs'))

fun partition f xs = 
  case xs of 
       [] => ([], [])
     | x::xs' => (let 
                        val (lhs, rhs) = partition f xs'
                  in
                    case f x of 
                         false => (x::lhs, rhs)
                       | true => (lhs, x::rhs)
                  end)

fun map f xs = 
  case xs of
       [] => []
     | x::xs' => (f x) :: map f xs'

fun map_with_foldr f xs = foldr (fn(x, xs) => (f x)::xs) [] xs

fun filter_with_foldr f xs = foldr(fn(x, xs) => if f x then x::xs else xs) [] xs
