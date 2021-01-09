(* 0. Consider any of the extra Practice Problems from Section 1 and redo
them using pattern matching. 
*)
fun alternate(xs) = 
  case xs of
       [] => 0
     | x::xs' => x - alternate xs'

fun max(xs) = 
  case xs of
       [] => 0
     | x::[] => x
     | x::xs' => let 
                    val tl_ans = max(xs')
                 in case x > tl_ans of
                         true => x
                       | false => tl_ans
                 end

fun min(xs) = 
  case xs of
       [] => 0
     | x::[] => x
     | x::y::xs' => case x < y of
                         true => min(x::xs')
                       | false => min(y::xs')
fun cumsum(xs) = 
  let 
    fun reverse(xs, acc) = 
      case xs of
           [] => acc
         | x::xs' => reverse(xs', x::acc)

    fun helper(xs, curr, acc) = 
      case xs of
           [] => acc
         | x::xs' => helper(xs', curr + x, (curr+x)::acc)
  in
    reverse (helper(xs, 0, []), [])
  end

fun greeting(s) = 
  case s of
       NONE => "Hello there, you!"
     | SOME s => "Hello there, " ^ s ^ "!"

exception BadList

fun repeat(xs, ys) = 
  case (xs, ys) of
       ([], []) => []
     | (_::xs', 0::ys') => repeat(xs', ys')
     | (x::xs', y::ys') => x::repeat(x::xs', (y-1)::ys')
     | _ => raise BadList

fun addOpt(x, y) = 
  case (x, y) of 
       (SOME x', SOME y') => SOME(x' + y')
     | (_, _) => NONE 

fun any(xs) = 
  case xs of
       [] => false 
     | x::xs' => x orelse any xs'

fun all(xs) = 
  case xs of
       [] => true
     | x::xs' => x andalso all xs'

exception DifferentLengths

fun zip(xs, ys) = 
  case (xs, ys) of
       ([], []) => []
     | (x::xs', y::ys') => (x, y)::zip(xs', ys')
     | _ => raise DifferentLengths

fun ziprecycle(xs, ys) = 
let fun zipHelper(xs', ys', xs_shorter_than_ys) = 
  case (xs', ys', xs_shorter_than_ys) of  
       ([], [], _) => []
     | (x::xs', [], true) => []
     | ([], y::ys', true) => zipHelper(xs, y::ys', true)
     | (x::xs', [], false) => zipHelper(x::xs', ys, false)
     | ([], y::ys', false) => []
     | (x::xs', y::ys', e) => (x, y)::zipHelper(xs', ys', e)
in
  zipHelper(xs, ys, length xs < length ys)
end

fun zipOpt(xs, ys) = 
let 
  val equal_length = length xs = length ys
in
  case equal_length of
       true => SOME(zip(xs, ys))
     | _ => NONE
end

fun lookup(xs, s) =
  case xs of 
       [] => NONE
     | ((s', i))::xs' => (let val equal = s' = s
                          in 
                            case equal of 
                                 true => SOME i
                                 | _ => lookup(xs', s)
                          end)

fun splitup(xs, x) =
  case xs of
       [] => ([], [])
     | x'::xs' => let val (split1, split2) = splitup(xs',x)
                  in 
                    if x' < x
                    then (x'::split1, split2)
                    else (split1, x'::split2)
                  end

fun splitAt(xs, x) = 
  case xs of
       [] => ([], [])
     | x'::xs' => let val (split1, split2) = splitAt(xs',x)
                  in 
                    if x' < x
                    then (x'::split1, split2)
                    else (split1, x'::split2)
                  end

fun isSortedCmp(xs, cmp) = 
  case xs of
       [] => true
     | x::[] => true
     | x::y::xs' => cmp(x, y) andalso isSortedCmp(y::xs', cmp)

fun isSorted(xs) = 
  case xs of
       [] => true
     | x::[] => true
     | x::y::xs' => x <= y andalso isSorted (y::xs')

fun cmp(x, y) = x >= y

fun isAnySorted(xs) = 
  isSorted(xs) orelse isSortedCmp(xs, cmp)

fun sortedMerge(xs, ys) = 
  case (xs, ys) of
       ([], []) => []
     | ([], ys) => ys
     | (xs, []) => xs
     | (x::xs', y::ys') => if x < y
                           then x::sortedMerge(xs', y::ys')
                           else y::sortedMerge(x::xs', ys')

fun qsort(xs) = 
  case xs of
       [] => []
     | [x] => [x]
     | (x::xs') => let 
                     val (lhs, rhs) = splitAt(xs', x)
                   in 
                     lhs @ [x] @ rhs
                   end

fun divide(xs) = 
  case xs of
       [] => ([], [])
     | x::[] => ([x], [])
     | x::y::xs' => let 
                    val (lhs, rhs) = divide(xs')
                    in
                      (x::lhs, y::rhs)
                    end

fun not_so_quick_sort(xs) = 
  case xs of
       [] => []
     | [x] => [x]
     | l => 
         let 
           val (lhs, rhs) = divide(l)
           val lhs_sorted = not_so_quick_sort(lhs)
           val rhs_sorted = not_so_quick_sort(rhs)
         in
           sortedMerge(lhs_sorted, rhs_sorted)
         end

fun fullDivide(k, n) = 
  let 
    fun helper(n, acc) = 
      case (n mod k) of 
           0 => helper(n div k, acc + 1)
         | _ => (acc, n)
  in 
    helper(n, 0)
  end

fun multiply(xs) = 
  case xs of
       [] => 1
     | (x, 1)::xs' => x * multiply(xs')
     | (x, y)::xs' => x * multiply((x, y - 1)::xs')
