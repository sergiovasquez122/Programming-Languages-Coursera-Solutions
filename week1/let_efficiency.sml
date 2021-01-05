(* int * int -> int list *)
fun countup(from : int, to : int) = 
  if from = to
  then to :: []
  else from :: countup(from + 1, to)
(* int * int -> int list *)
fun countdown(from : int, to : int) = 
  if from=to
  then to :: []
  else from :: countdown(from - 1, to)
(* int list -> int *)
fun bad_max(xs : int list) = 
  if null xs
  then 0 (* bad style, but not important right now *)
  else if null (tl xs)
  then hd xs
  else if hd xs > bad_max(tl xs)
  then hd xs
  else bad_max(tl xs)
(* int list -> int *)
fun good_max(xs : int list) = 
  if null xs
  then 0
  else if null (tl xs)
  then hd xs
  else let 
       val rest_of_list_max = good_max(tl xs)
       val head = hd xs
       in 
         if rest_of_list_max < head
         then head
         else rest_of_list_max
       end
