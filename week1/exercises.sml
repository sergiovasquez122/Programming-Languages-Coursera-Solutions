(* 1. Write a function 
* alternate : int list -> int
* that takes a list of numbers and 
* adds them with alternating sign. *)
fun alternate(xs : int list) = 
  if null xs
  then 0
  else (hd xs) - alternate(tl xs)
  (* 2. Write a function min_max : int list -> int * int that takes a non-empty
  * list of numbers, and return a pair (min, max of the min and maximum numbers
  * of the numbers in the list *)
fun min_max(xs : int list) = 
let 
  fun max_nonempty(xs : int list) = 
    if null (tl xs) 
    then hd xs
    else let val tail_ans = max_nonempty(tl xs)
         in 
           if (hd xs) > tail_ans
           then hd xs
           else tail_ans
         end
  fun min_nonempty(xs : int list) = 
    if null (tl xs) 
    then hd xs
    else let val tail_ans = min_nonempty(tl xs)
         in 
           if (hd xs)<> tail_ans
           then hd xs
           else tail_ans
         end
in
  (min_nonempty xs, max_nonempty xs)
end
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
(* 4. Write a function greeting : string option -> string there given a string
* option SOME name return the string "Hello there, ...!" where the dots would be
* replaced by name *)
fun greeting(s : string option) = 
  if isSome s
  then "Hello there, " ^ valOf s ^ "!"
  else "Hello there, you!"
 (* 5. Write a function repeat : int list * int list -> int list that given a
 * list of itnegers and another list of nonnegative integers, repeats the
 * integers in the first list according to the numbers indicated by the second
 * list *)
fun repeat(xs : int list, ys : int list) = 
  if null ys 
  then []
  else if (hd ys) = 0
  then repeat(tl xs, tl ys)
  else (hd xs) :: repeat(xs, (hd ys - 1):: (tl ys))
(* 6. Write a function addOpt : int option * int option -> int option tht given
* two optional integers, adds them if they are both present or returns NONE if
* at least one of the two arguments is NONE *)
fun addOpt(x : int option, y : int option) = 
  if isSome x andalso isSome y
  then SOME(valOf x + valOf y)
  else NONE
  (* 7. Write a function addAllOpt : int option list -> int option that given a
  * list to optional integrs, add those integers that are there *)
fun addAllOpt(xs : int option list) = 
  if null xs
  then NONE
  else 
    if null (tl xs)
    then hd xs
    else 
    let val tl_ans = addAllOpt(tl xs)
    in
        addOpt(hd xs, tl_ans)
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
  (* 10. Write a function zip : int list * int list -> int * int list tht given
  * two lists of integers creates consecutive pairs, and stops when one of the
  * lists is empty. *)
fun zip(xs : int list, ys : int list) = 
  if null xs orelse null ys
  then []
  else (hd xs, hd ys) :: zip(tl xs, tl ys)
  (* 12. Lesser challenge: Write a version zipOpt of zip with return type (int *
  * int) list option. This version should return SOME of a list when the
  * original lists have the samelength, and NONE if they do not. *)
fun zipOpt(xs : int list, ys : int list) = 
  if length xs <> length ys
  then NONE
  else SOME(zip(xs, ys))
  (* 13. Write a function lookup : (string * int) list * string -> int option
  * that takes a list of pairs (s, i) and also a string s2 to look up. it then
    * goes through the list of pairs looking for the string s2 in teh first
    * component. If it finds a math with corresponding number i, then it returns
    * SOME i. If it does not, it returns NONE. *)
fun lookup(xs : (string * int) list, key : string) = 
  if null xs 
  then NONE
  else let val first = #1 (hd xs)
           val second = #2 (hd xs)
       in 
         if first = key
         then SOME(second)
         else lookup (tl xs, key)
       end
(* 14. Write a function splitup : int list -> int list * int list that given a
* list of integers creates two list of integers, one containing the non-negative
* entries, the other containing the negative entries.Relative order must be
* preserved *)
fun splitup(xs : int list) = 
let 
    fun reverse(xs : int list, aux : int list) = 
      if null xs
      then aux
      else reverse(tl xs, (hd xs) :: aux)
  fun helper(xs : int list, neg : int list, pos : int list) =
        if null xs 
        then (reverse(neg,[]), reverse(pos, []))
        else if (hd xs) < 0 
        then helper(tl xs, (hd xs) :: neg, pos)
        else helper(tl xs, neg, (hd xs) :: pos)
in
  helper(xs, [], [])
end
(* 16. Write a function isSorted : int list -> boolean that given a list of
        * integers determines whether the list is sorted in increasing order. *)
fun isSorted(xs : int list) = 
  if null xs orelse null (tl xs) 
  then true
  else let
       val head = hd xs
       val next_elem = hd (tl xs)
       in 
         head < next_elem andalso isSorted(tl xs)
       end
(* 17. Write a function isAnySorted : int list -> boolean that given a list of
        *integers determines whether the list is sorted in increasing order *)
fun isAnySorted(xs : int list) = 
let fun descendingSorted(xs : int list) = 
    if null xs orelse null (tl xs)
    then true
    else 
      let val first = hd xs
          val second = hd (tl xs)
      in 
        first > second andalso descendingSorted(tl xs)
      end
in
  isSorted xs orelse descendingSorted xs
end
(* 18. Write a function sortedMerge : int list * int list -> int list that takes
* two list of integers that are each sorted from smallest to largest, and merges
* them into one sorted list.*)
fun sortedMerge(xs : int list, ys : int list) = 
if null xs 
then ys
else if null ys
then xs
else let val xs_head = hd xs
         val ys_head = hd ys
     in 
       if xs_head < ys_head 
       then xs_head :: sortedMerge(tl xs, ys)
       else ys_head :: sortedMerge(xs, tl ys)
     end
