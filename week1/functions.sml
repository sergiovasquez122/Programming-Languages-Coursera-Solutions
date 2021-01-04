(* works only if y >= 0 *)
fun pow(x : int, y : int) = 
  if y = 0 
  then 1
  else x * pow(x, y - 1)

fun cube(x : int) = 
  pow(x, 3)

val sixtyFour = cube 4

val fourtyTwo = pow(2, pow(2, 2))
