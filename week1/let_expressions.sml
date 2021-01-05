(* fn : int -> int *)
fun silly1 (x : int) = 
let 
  val z = if x > 0 then x else 34
  val y = x + z + 9 
in
   if x > y then x * 2 else y * y
end

fun silly2() = 
let val x = 1
in 
  (let val x = 2 in x + 1 end) + (let val y = x + 2 in y + 1 end)
   end

(* fn : unit -> int * int * int *)
fun silly3() = 
let 
  val x = (let val x = 5 in x + 10 end) (* x = 15 *)
in (x, let val x = 2 in x end, let val x = 10 in let val x = 2 in x end end)
(* 15, 2, 2 *)
end
