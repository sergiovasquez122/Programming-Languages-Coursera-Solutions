datatype my_int_list = Empty | Cons of int * my_int_list

val one_two_three = Cons(1, Cons(2, Cons(3, Empty)))

fun append_mylist(xs, ys) = 
  case xs of
       Empty => ys
     | Cons(x, xs') => Cons(x, append_mylist(xs', ys))

fun length'(xs) = 
  case xs of
       Empty => 0
     | Cons(x, xs') => 1 + length' xs'

fun null'(xs) = 
  case xs of
       Empty => false
     | _ => true

fun tl'(xs) = 
  case xs of
      Cons(x, xs') => xs'
     | Empty => Empty

fun hd'(xs) = 
  case xs of
       Cons(x, xs') => SOME x
     | Empty => NONE

fun inc_or_zero(x) = 
  case x of
       NONE => 0
     | SOME i => i + 1

fun sum_list xs = 
  case xs of
       [] => 0
     | x::xs' => x + sum_list xs'

fun append(xs, ys) = 
  case xs of
       [] => ys
     | x::xs' => x::append(xs', ys)
