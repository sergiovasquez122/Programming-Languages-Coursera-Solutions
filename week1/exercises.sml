(* 1. Write a function 
* alternate : int list -> int
* that takes a list of numbers and 
* adds them with alternating sign. *)
fun alternate(xs : int list) = 
  if null xs
  then 0
  else (hd xs) - alternate(tl xs)
  (*3. write a function cumsum : int list -> int list that takes a list of
          * numbers and returns a list of the partial sumsof the numbers. *)
fun cumsum(xs : int list) =
let 
  fun helper(ls : int list, currsum : int) = 
  if null ls
  then []
  else let val head = hd ls
           val tail = tl ls
           val result = currsum + head
       in 
         (result) :: helper(tail, result)
       end
in
  helper(xs, 0)
end
(* 8. Write a function any : bool list -> bool that given a
* list of booleans return true if there is at least one of them that is true,
* otherwise return false. *)
fun any(xs : bool list) = 
  if null xs
  then false
  else (hd xs) orelse any(tl xs)
  (* 9. Write a function all : bool list -> bool that given a list of booleans
  * return true if all of them true, otherwise return false.*)
fun all(xs : bool list) = 
  if null xs
  then true
  else (hd xs) andalso all(tl xs)
