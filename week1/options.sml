(* int list -> int *)
fun old_max(xs : int list) = 
  if null xs 
  then 0 
  else if null (tl xs)
  then hd xs
  else 
    let val tl_ans = old_max(tl xs)
        val head = hd xs
    in 
      if head < tl_ans
      then tl_ans
      else head
    end
(* int list -> int option *)
fun max1(xs : int list) = 
  if null xs
  then NONE
  else 
    let 
    val tl_ans = max1(tl xs)
    in
      if isSome tl_ans andalso valOf tl_ans > hd xs 
      then tl_ans
      else SOME(hd xs)
    end
(* int list -> int option *)
fun max2(xs : int list) = 
  if null xs
  then NONE
  else let 
    fun max_nonempty(xs : int list) = 
      if null (tl xs)
      then hd xs
      else let val tl_ans = max_nonempty(tl xs)
               val head = hd xs
           in 
             if head > tl_ans
             then head
             else tl_ans
           end
       in 
         SOME(max_nonempty xs)
       end
