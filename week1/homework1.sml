fun is_older(d1 : int * int * int, d2 : int * int * int) = 
let 
  val lhs_day = #3 d1
  val lhs_month = #2 d1
  val lhs_year = #1 d1
  val rhs_day = #3 d2
  val rhs_month = #2 d2
  val rhs_year = #1 d2
in 
  if lhs_year = rhs_year andalso lhs_month = rhs_month andalso lhs_day = rhs_day 
  then false
  else if rhs_year < lhs_year
  then false
  else if rhs_month < lhs_month
  then false
  else if rhs_day < lhs_day
  then false
  else true
end
(*2. Write a function number_in_month that a lists of dates and month and
* returns how many dates in the list are in the given month*)
fun number_in_month(xs : (int * int * int) list, x : int) = 
  if null xs
  then 0
  else 
    let 
      val curr_element = hd xs
      val month = #2 curr_element 
                                         in 
                                           if x = month 
                                           then 1 + number_in_month(tl xs, x)
                                           else number_in_month(tl xs, x)
end
(*3. Write a function number_in_months that takes a list of dates and a list of months
* and retursn the number of dates in teh list of dates that are in any of the
* months in the lists of months*)
fun number_in_months(dates : (int * int * int) list, months : int list) = 
  if null months
  then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months)
  (* -> (int * int * int)  list *)
fun dates_in_month(dates : (int * int * int) list, month : int) = 
  if null dates
  then []
  else 
    let 
      val curr_element = hd dates
      val curr_month = #2 curr_element 
    in 
      if curr_month = month 
      then curr_element::dates_in_month(tl dates, month)
      else dates_in_month(tl dates, month)
    end
(* 5. Write a function dates_in_months that takes a list of dates and a list of
        * months and returns a list holding the dates from the argument list of
               * dates that are in any of the months in the list of months *)
fun dates_in_months(dates : (int * int * int) list, months : int list) = 
  if null months
  then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)
(* 6. Write a function get_nth that takes a list of strings and an int n and
* returns the nth element of the list where the head of the list is 1st.*)
fun get_nth(xs : string list, n : int) = 
  if n = 1
  then hd xs
  else get_nth(tl xs, n - 1)
(* 7. Write a function date_to_string that takes a date and returns a string of
        * the form January 20, 2013 *)
fun date_to_string(date : int * int * int) = 
let 
  val day = Int.toString(#3 date)
  val month = Int.toString(#2 date)
  val year = Int.toString(#1 date)
in
  month ^ " " ^ day ^ ", " ^ year
end
(* 8. Write a function number_before_reaching_sum that takes an int called sum
* and an int list. and returns an int. you should return an int n such that the
* first n element of the list add to less than sum, but the first n + 1 elements
* of the list add to sum or more *)
fun number_before_reaching_sum(sum : int, xs : int list) = 
let 
  fun accum(curr_sum : int, n : int,xs : int list) = 
    if (hd xs) + curr_sum >= sum
    then n
    else accum(curr_sum + (hd xs),n + 1, tl xs)
in
    accum(0, 0,xs)
end
(* 9. Write a function what_month that takes a day of the year and return what
* month that day is in. *)
fun what_month(day : int) = 
let 
  val months_durations_in_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in 
   number_before_reaching_sum(day, months_durations_in_days) + 1
end
(* 10. Write a unction month_range that takes two days of the year day1 and day2
* and returns an int list [m1, m2, ..., mn] where m1 is the month day1, m2 is
* tmonth of day1 +1 and mn is day2 *)
fun month_range(day1 : int, day2 : int) = 
  if day1 > day2
  then []
  else 
    let fun helper(from : int, to : int) = 
    if from = to 
    then to :: []
    else from :: helper(from + 1, to)
    in
      helper(what_month(day1), what_month(day2))
    end
(* 11. Write a function oldest that takes a list of dates and evaluates to an (int *
* int * int) option. It evaluates to NONE if the list has no dates and SOME d if
* the date d is the oldest dte in the list*)
fun oldest(dates : (int * int * int) list) = 
  if null dates
  then NONE
  else 
    let 
      fun helper(dates : (int * int * int) list) = 
        if null (tl dates)
        then hd dates
        else 
          let 
            val head = hd dates
            val tl_ans = helper(tl dates)
          in
            if is_older(head, tl_ans)
            then head
            else tl_ans
          end
    in
      SOME(helper dates)
end
(* 12.  Write functino number_in_months_challenge and dates_in_months_challenge that
* are like your solutions to problem 3 and 5 except having a month in the second
* arguement multiple times has no more effect than having it once. *)
fun find_elem(xs : int list, x : int) =
  if null xs
  then false
  else x = (hd xs) orelse find_elem(tl xs, x)

fun remove_duplicates(xs : int list) = 
let fun helper(xs : int list, aux : int list) = 
if null xs
then aux
else 
  if find_elem(aux, hd xs)
  then helper(tl xs, aux)
  else helper(tl xs, (hd xs) :: aux)
in 
  helper(xs, [])
end

fun number_in_months_challenge(dates : (int * int * int) list, months : int
  list) = 
  if null months 
  then 0
  else 
    let
      val months' = remove_duplicates(months)
    in
      number_in_month(dates, hd months') + number_in_months(dates, tl months')
    end

fun dates_in_months_challenge(dates : (int * int * int) list, months : int list)
  = if null months
    then []
    else 
      let 
        val months' = remove_duplicates months
      in
        dates_in_month(dates, hd months') @ dates_in_months(dates, tl months')
      end
(* 13. Write a function reasonable_date that takes a date and determines if it
* describes a real date in the common era. *)
fun reasonable_date(date : int * int * int) = 
let 
  fun is_leap_year(year : int) = 
    ((year mod 400 = 0) orelse (year mod 4 = 0)) andalso year mod 100 <> 0

  fun get_nth(xs : int list, n : int) = 
  if n = 1
  then hd xs
  else get_nth(tl xs, n - 1)

  val day = #1 date
  val month = #2 date
  val year = #3 date
  val months_durations_in_days_regular = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  val months_durations_in_days_leap = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
in
  if year < 0
  then false
  else if month < 1 orelse month > 12
  then false
  else if is_leap_year(year)
  then day <= get_nth(months_durations_in_days_leap, month)
  else day <= get_nth(months_durations_in_days_regular, month)
end
