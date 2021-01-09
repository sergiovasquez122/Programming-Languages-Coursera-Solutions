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

fun addAllOpt(xs) = 
let 
  fun helper(xs, acc) = 
    case xs of 
         [] => acc
       | x::xs => case (x, acc) of
                       (NONE, acc)=> helper(xs, acc)
                     | (SOME x, SOME acc) => helper(xs, SOME (x + acc))
                     | (SOME x, NONE) => helper(xs, SOME x)
in
  helper(xs, NONE)
end

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

fun factorize(n) = 
let fun helper(current_n, divisor) = 
case divisor > current_n of
     true => []
   | _ => (case current_n mod divisor <> 0 of 
                true => helper(current_n, divisor + 1)
              | _ => 
                  let val (times_went_in, new_dividend) = fullDivide(divisor,
                  current_n)
                  in
                    (divisor, times_went_in)::helper(new_dividend, divisor + 1)
                  end)
in 
  helper(n, 2)
end

fun multiply(xs) = 
  case xs of
       [] => 1
     | (x, 1)::xs' => x * multiply(xs')
     | (x, y)::xs' => x * multiply((x, y - 1)::xs')

fun find_elem(xs, x) =
  case xs of
       [] => false
     | x'::xs' => x' = x orelse find_elem(xs', x)

fun remove_duplicates(xs) = 
let fun helper(xs, aux) =
  case xs of
       [] => aux
     | x::xs' => (case find_elem(aux, x) of 
                         false => helper(xs', x::aux)
                       | _ => helper(xs', aux)
     )
in
  helper(xs, [])
end

fun generate_factors(xs, curr) = 
  case xs of
       [] => [curr]
     | x::xs' => let val with_hd = curr * x
                val list_with = generate_factors(xs', with_hd)
       val list_without = generate_factors(xs', curr)
                 in
                   list_without @ list_with
                 end

fun unroll_helper(xs) = 
  case xs of 
       [] => []
     | ((x, y)::xs) => case y of
                            0 => []
                          | _ => x::unroll_helper((x, y - 1)::xs)

fun unroll(xs) = 
  case xs of
       [] => []
     | x::xs' => unroll_helper(xs) @ unroll(xs')

fun all_products(xs) = 
  case xs of
       [] => []
     | x::xs => 
         let 
           val unrolled = unroll(x::xs)
           val factors = generate_factors(unrolled, 1)
           val factors_no_dups = remove_duplicates(factors)
           val sorted = qsort(factors_no_dups)
         in 
           sorted
         end
(* Writing hw 1 using pattern matching *)
fun number_in_month(xs, x) = 
  case xs of 
       [] => 0
     | (day, month, year)::xs' => (case month = x of
                       true => 1 + number_in_month(xs', x)
                      | _ => number_in_month(xs', x))

fun number_in_months(dates, months) = 
  case months of 
       [] => 0
     | m::months' => number_in_month(dates, m) + number_in_months(dates, months')

fun dates_in_month(dates, month) = 
  case dates of
       [] => []
     | (day', month', year')::dates' => (case month' = month
                                         of 
                                         true => (day', month',
                                         year')::dates_in_month(dates, month')
                                            | _ => dates_in_month(dates, month')
                                         )

fun dates_in_months(dates, months) = 
  case months of 
       [] => []
     | m::months' => dates_in_month(dates, m) @ dates_in_months(dates, months')

fun get_nth(str, n) = 
  case (n, str) of
       (_, []) => raise List.Empty
     | (1, s::str') => s
     | (n, s::str') => get_nth(str', n - 1)

fun date_to_string(day, month, year) = 
  let val months = ["January", "February","March", "April", "May", "June", "July","August", "September", "October", "November", "December"]
    val month_str = get_nth(months, month)
  in 
    month_str ^ " " ^ Int.toString(day) ^ ", " ^ Int.toString(year)
  end

fun number_before_reaching_sum(sum, xs) = 
let 
  fun helper(curr_sum, nth, xs) = 
      case xs of
           [] => raise List.Empty
         | x::xs' => if x + curr_sum < sum
                     then helper(x + curr_sum, nth + 1, xs')
                     else nth
in
  helper(0, 0, xs)
end
