fun only_lowercase sl = List.filter (fn x => Char.isLower (String.sub(x, 0))) sl

fun longest_string1 sl = foldl (fn(x, y) => if String.size x > String.size y
                                            then x else y) "" sl

fun longest_string2 sl = foldl(fn(x, y) => if String.size x >= String.size y then x else y) "" sl

fun longest_string_helper f sl = foldl (fn(x, y) => let val x_size =
  String.size x val y_size = String.size y in if f(x_size, y_size) then x else y end) "" sl

val longest_string3 = longest_string_helper (fn(x, y) => x > y)

val longest_string4 = longest_string_helper (fn(x, y) => x >= y)

val longest_lowercase = longest_string2 o only_lowercase

val rev_string = implode o rev o explode o (String.map Char.toUpper)

exception NoAnswer

fun first_answer f xs = 
  case xs of 
       [] => raise NoAnswer
     | x::xs' => case f x of
                      SOME x => x
                    | NONE => first_answer f xs'

fun all_answers f xs = 
let 
  fun helper(xs, acc) =
        case xs of
             [] => SOME(acc)
           | x::xs' => case f x of 
                            SOME y => helper(xs', acc @ y)
                          | NONE => NONE
        in 
          case helper(xs, []) of
               SOME(acc) => SOME(acc)
             | NONE => NONE
  end



datatype pattern = WildcardP 
                 | VariableP of string
                 | UnitP
                 | ConstantP of int
                 | ConstructorP of string * pattern
                 | TupleP of pattern list

datatype valu = Constant of int
              | Unit
              | Constructor of string * valu
              | Tuple of valu list

fun g f1 f2 p =
let 
  val r = g f1 f2 
  in 
     case p of
     WildcardP => f1()  
   | VariableP x => f2 x
   | ConstructorP(_, p) => r p
   | TupleP ps => List.foldl (fn(p, i) => (r p) + i) 0 ps
   | _ => 0
end

fun count_wildcards p = g (fn() => 1) (fn(x) => 0) p

fun count_wild_and_variable_lengths p = g (fn() => 1) (fn(x) => String.size x) p

fun count_a_var (s, p) = g (fn() => 0) (fn(x) => if x = s then 1 else 0) p
