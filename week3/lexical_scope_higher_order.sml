val x = 1

fun f y =
  let 
    val x = y + 1
  in 
    fn z => x + y + z
  end

val x = 3 (* irrelevant *)

val g = f 4 (* function that adds 9 to argument *)

val y = 5 (* irrelevant *)

val z = g 6 (* evaluated to 15 *)
