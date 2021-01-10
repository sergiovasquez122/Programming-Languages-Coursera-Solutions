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
fun is_older(xs : (int * int * int), ys : (int * int * int)) = 
let 
  val day_left = #1 xs
  val month_left = #2 xs
  val year_left = #3 xs
  val day_right = #1 ys
  val month_right = #2 ys
  val year_right = #3 ys
in
  if year_left > year_right then false
  else if year_left < year_right then true
  else if month_left > month_right then false
  else if month_left < month_right then true
  else if day_left > day_right then false
  else if day_left < day_right then true
  else false
end

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

fun what_month(day) = 
let 
    val months_durations_in_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30,
           31]
             in 
                  number_before_reaching_sum(day, months_durations_in_days) + 1
end

fun month_range(day1, day2) = 
let 
  fun helper(from, to) = 
  case from = to of 
     true => to::[]
   | _ => from::helper(from + 1, to)
in 
  case day1 > day2 of
       true => []
     | _ => helper(what_month(day1), what_month(day2))
end

fun oldest(dates) = 
let fun non_empty(dates) = 
    case dates of
         x::[] => x
       | x::y::l => if is_older(x, y) 
                    then non_empty(x::l)
                    else non_empty(y::l)
    in
      case dates of
           [] => NONE
         | l => SOME (non_empty(l))
end

fun number_in_months_challenge(dates, months) = 
let 
  val remove_dups = remove_duplicates(months)
in 
  number_in_months(dates, remove_dups)
end

fun dates_in_months_challenge(dates, months) = 
let 
  val remove_dups = remove_duplicates(months)
in
  dates_in_months(dates, remove_dups)
end

fun reasonable_date(day, month, year) = 
  let fun is_leap_year(year) = 
  ((year mod 400 = 0) orelse (year mod 4 = 0)) andalso year mod 100 <> 0

    val months_durations_in_days_regular = [31, 28, 31, 30, 31, 30, 31, 31, 30,
           31, 30, 31]
             val months_durations_in_days_leap = [31, 29, 31, 30, 31, 30, 31,
             31, 30, 31, 30, 31]

  in 
    if year < 0 
    then false
    else if month < 1 orelse month > 12
    then false
    else if is_leap_year(year)
    then 1 <= day andalso day <= get_nth(months_durations_in_days_leap, month)
    else 1 <= day andalso day <= get_nth(months_durations_in_days_regular, month)
  end
(* Problems 1-4 use these type definitions *)
type student_id = int
type grade = int
type final_grade = {id : student_id, grade : grade option}
datatype pass_fail = pass | fail

(*1. Write a function pass_or_fail of type {grade : int option, id : 'a} ->
* pass_fial that takes a final grade and return pass if the grade field contains
* SOME i for an i >= 75 *)
fun pass_or_fail({grade = g, id = x}) =
  case g of 
       NONE => fail
     | SOME i => if i >= 75 then pass else fail
(*2 Using pass_or_fail as a helper function, write a function has passed_of type
* {grade : int option, id : 'a} -> bool that returns true if and only if the
* grade field contins SOME if or an i >= 75 *)
fun has_passed(g) = 
  case pass_or_fail g of
       fail => false
     | pass => true
(* 3. Using has_passed as a helper function, write a function numbeer_psses that
* takes  list of type finl-grade nd returns how mny list elements hve passing
* grades *)
fun number_passed(xs) = 
  case xs of
       [] => 0
     | x::xs' => if has_passed x
                 then 1 + number_passed xs'
                 else number_passed xs'
(* 4. Write a function number_misgraded of type (pass_fail * final_grade) list
* -> int tht indicates how many list elements are mislabeled where mislabeling
* means a pair (pass, x) where has_passed x is false or (fial, x where
* has_passed x is true *)
fun number_of_misgraded(xs) =
  case xs of 
       [] => 0
     | (status, x)::xs' => (case (status, has_passed x) of 
                                 (fail, false) => number_of_misgraded(xs')
                               | (pass, true) => number_of_misgraded(xs')
                               | _ => 1 + number_of_misgraded(xs')
                               )
(* Problems 5-7 use these type definitions *)
datatype 'a tree = leaf | node of {value : 'a, left : 'a tree, right : 'a tree}
datatype flag = leave_me_alone | prune_me
(* 5. Write a function tree_height that accepts an 'a tree and evaluates to a
* height of this tree. The height of a tree is the length of the longest path to
* a left. Thus the height of a leaf is 0. *)
fun tree_height root = 
  case root of
       leaf => 0
     | node {value = _, left = l, right = r} => 1 + Int.max(tree_height l, tree_height r)
(* 6. Write a function sum_tree that takes an int tree and evaluates to the sum
* of all values in the node. *)
fun sum_tree root =
  case root of 
       leaf => 0
     | node {value = x, left = l, right = r} => x + sum_tree l + sum_tree r

(* Problems 9-16 use this type definition for natural numbers *)
datatype nat = ZERO | SUCC of nat

fun is_positive n =
  case n of
       ZERO => false
     | _ => true
