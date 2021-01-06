(* 1. fun : (int * int * int) * (int * int * int) -> bool 
* (#1 x) = day
* (#2 x) = month
* (#3 x) = year
* *)
fun is_older(d1 : int * int * int, d2 : int * int * int) = 
let 
  val lhs_day = #1 d1
  val lhs_month = #2 d1
  val lhs_year = #3 d1
  val rhs_day = #1 d2
  val rhs_month = #2 d2
  val rhs_year = #3 d2
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
