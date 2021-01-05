(* fun : int -> int list *)
fun countup_from1(x : int) = 
let 
  fun count(from : int, to : int) = 
    if from = to
    then to :: []
    else from :: count(from + 1, to)
in
  count(1, x)
end

(* fun : int -> int list *)
fun countup_from1_better(x : int) = 
let 
  fun count(from : int) = 
    if from = x 
    then from :: []
    else from :: count(from + 1)
in 
  count 1
end
