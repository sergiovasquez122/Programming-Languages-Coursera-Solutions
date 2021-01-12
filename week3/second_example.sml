fun f g = 
  let 
    val x = 3 (* irrelevant *)
  in
    g 2
  end

val x = 4

fun h y = x + y (* function that adds 4 to argument *)

val z = f h (* evaluates to 6 *)
