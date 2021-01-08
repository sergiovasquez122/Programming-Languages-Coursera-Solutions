fun sum1 xs = 
  case xs of 
       [] => 0
     | x::xs' => x + sum1 xs'

fun sum2 xs = 
    let fun f(xs, acc) = 
            case xs of
                 [] => acc
               | x::xs' => f(xs', x + acc)
    in
      f(xs, 0)
    end

fun fact1 n = if n = 0 then 1 else n * fact1(n - 1)

fun fact2 n = 
let fun aux(n, acc) = if n = 0 then acc else aux(n - 1, acc * n)
in
  aux(n, 1)
end

fun rev2 lst = 
let 
  fun aux(lst, acc) = 
    case lst of
         [] => acc
       | x::xs => aux(xs, x::acc)
    in
       aux(lst, [])
    end

