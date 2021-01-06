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
(* 11. Challenge: Write a version zipRecycle of zip, where when on lsit is empty
* it starts recycling from its start until the other list completes *)
fun zipRecycle(xs : int list, ys : int list) = 
let 
  val xs_length = length xs
  val ys_length = length ys
  fun helper(xs' : int list, ys' : int list) = 
      if null xs' andalso xs_length > ys_length 
      then []
      else if null ys' andalso xs_length < ys_length
      then []
      else if null xs' andalso xs_length < ys_length
      then (hd xs, hd ys')::helper(tl xs, tl ys')
      else if null ys' andalso xs_length > ys_length
      then (hd xs', hd ys)::helper(tl xs', tl ys)
      else (hd xs', hd ys')::helper(tl xs', tl ys')
   in
     if xs_length = ys_length
     then zip(xs, ys)
     else helper(xs, ys)
end
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
(* 15. Write  version splitAt : int list * int -> int list * int list of the
* previous function that takes an extra threshold parameter, and uses that
* instead of 0 as the separating point for the two resulting lists *)
fun splitAt(xs : int list, threshold : int) = 
let 
    fun reverse(xs : int list, aux : int list) = 
      if null xs
      then aux
      else reverse(tl xs, (hd xs) :: aux)
  fun helper(xs : int list, neg : int list, pos : int list) =
        if null xs 
        then (reverse(neg,[]), reverse(pos, []))
        else if (hd xs) < threshold 
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
(* 19. Write a sorting function qsort : int list -> int list that works as
* follows : Takes the first element out, and usess it as the "threshold" for
* splitAt.it then recursively sorts the two lists produced by splitAt. Finally
* it brings the two lists together. *)
fun qsort(xs : int list) = 
  if null xs 
  then []
  else
    let 
      val head = hd xs
      val rest = tl xs
      val (lhs, rhs) = splitAt(rest, head)
    in
      qsort(lhs) @ [head] @ qsort(rhs)
    end
(* 20. Write a function divide : int list -> int list * int list that takes a
* list of integers and produces two lists by alternating elements between the
* lists. *)
fun divide(xs : int list) = 
let 
    fun reverse(xs : int list, aux : int list) = 
      if null xs
      then aux
      else reverse(tl xs, (hd xs) :: aux)
  fun helper(xs : int list, lhs : int list, rhs : int list) = 
      if null xs
      then (reverse(lhs,[]), reverse(rhs, []))
      else if null (tl xs)
      then helper(tl xs, (hd xs)::lhs, rhs)
      else 
        let val first = hd xs
            val second = hd (tl xs)
        in 
            helper(tl (tl xs), first :: lhs, second :: rhs)
        end
in
   helper(xs, [], [])
end
(* 21. Write another sorting function not_so_quick_sort : int list -> int list
* that works as follows : Given the initial list of integers, splits it two
* lists using divide, then recursively sorts those two lists, then merges them
* together with sortedMerge *)
fun not_so_quick_sort(xs : int list) = 
  if null xs
  then []
  else if null (tl xs) 
  then [hd xs]
  else 
    let 
      val (lhs, rhs) = divide(xs)
      val lhs_sorted = not_so_quick_sort(lhs)
      val rhs_sorted = not_so_quick_sort(rhs)
    in
      sortedMerge(lhs_sorted, rhs_sorted)
    end
(* 22. Write a function fullDivide : int * int -> int * int that given two numbers
* k and n it attempts to evenly divide k into n as many times as possible, and
* returns a pair (d, n2) where d is the number of times while n2 is the resuling
* after all tose divisions *)
fun fullDivide(k : int, n : int) = 
let 
  fun helper(n : int ,accum : int) = 
    if n mod k <> 0
    then (accum, n)
    else helper(n div k, accum + 1)
in
    helper(n, 0)
end
(* 23. Using fullDivide write a function factorize : int -> (int * int) list
* that given a numer n returns a list of pairs (d, k) where d is a prime number
* dividing n and k is the numer of times it fits. The pairs should be in *) 
fun factorize(n : int) = 
let fun helper(current_n, divisor) = 
        if divisor > current_n 
        then []
        else if current_n mod divisor <> 0
        then helper(current_n, divisor + 1)
        else
          let 
            val (times_went_in, new_dividend) = fullDivide(divisor, current_n)
          in
            (divisor, times_went_in)::helper(new_dividend, divisor + 1)
          end
in
  helper(n, 2)
end
(* 24. Write a function multiply : (int * int) list -> int that given a
* factorization of a number n as described in the previous problem computes back
* the number n.*)
fun multiply(xs : (int * int) list) = 
  if null xs 
  then 1
  else 
    let fun pow(x : int, y: int) = 
    if y = 0
    then 1
    else x * pow(x, y - 1)
      
      val x = #1 (hd xs)
      val y = #2 (hd xs)
    in
      pow(x, y) * multiply(tl xs)
    end
