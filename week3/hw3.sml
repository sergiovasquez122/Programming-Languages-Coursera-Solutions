fun only_lowercase sl = List.filter (fn x => Char.isLower (String.sub(x, 0))) sl

fun longest_string1 sl = foldl (fn(x, y) => if String.size x > String.size y
                                            then x else y) "" sl

fun longest_string2 sl = foldl(fn(x, y) => if String.size x >= String.size y then x else y) "" sl

fun longest_string_helper f sl = foldl (fn(x, y) => let val x_size =
  String.size x val y_size = String.size y in if f(x_size, y_size) then x else y end) "" sl

val longest_string3 = longest_string_helper (fn(x, y) => x > y)

val longest_string4 = longest_string_helper (fn(x, y) => x >= y)

val rev_string = implode o rev o explode o (String.map Char.toUpper)
