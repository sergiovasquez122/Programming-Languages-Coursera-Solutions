fun only_capitals sl = List.filter (fn x => Char.isUpper (String.sub(x, 0))) sl

fun longest_string1 sl = foldl (fn(x, y) => if String.size x > String.size y
                                            then x else y) "" sl

fun longest_string2 sl = foldl(fn(x, y) => if String.size x >= String.size y then x else y) "" sl

fun longest_string_helper f sl = foldl (fn(x, y) => let val x_size =
  String.size x val y_size = String.size y in if f(x_size, y_size) then x else y end) "" sl

val longest_string3 = longest_string_helper (fn(x, y) => x > y)

val longest_string4 = longest_string_helper (fn(x, y) => x >= y)

val longest_capitalized  = longest_string3 o only_capitals

val rev_string = implode o rev o explode

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

datatype pattern = Wildcard
                 | Variable of string
                 | UnitP
                 | ConstP of int
                 | TupleP of pattern list
                 | ConstructorP of string * pattern

datatype valu = Const of int
              | Unit
              | Tuple of valu list
              | Constructor of string * valu

fun g f1 f2 p =
let 
  val r = g f1 f2 
  in 
     case p of
     Wildcard  => f1()  
   | Variable x => f2 x
   | TupleP ps => List.foldl (fn(p, i) => (r p) + i) 0 ps
   | ConstructorP(_, p) => r p
   | _ => 0
end

fun count_wildcards p = g (fn() => 1) (fn(x) => 0) p

fun count_wild_and_variable_lengths p = g (fn() => 1) (fn(x) => String.size x) p

fun count_some_var(s, p) = g (fn() => 0) (fn(x) => if x = s then 1 else 0) p

fun check_pat p = 
let fun no_repeats xs = 
  case xs of 
       [] => true
     | x::xs' => not (List.exists (fn y => x = y) xs') andalso no_repeats xs'

fun s f1 f2 p =
let 
  val r = s f1 f2 
  in 
     case p of
     Wildcard => f1()  
   | Variable x => f2 x
   | ConstructorP(_, p) => r p
   | TupleP ps => List.foldl (fn(p, i) => (r p) @ i) [] ps
   | _ => []
end

fun to_string_list p = s (fn() => []) (fn(x) => [x]) p
in 
  no_repeats(to_string_list p)
end

fun match(v, p) = 
  case (v, p) of
       (_, Wildcard) => SOME []
     | (Unit, UnitP) => SOME []
     | (_, Variable s) => SOME [(s, v)]
     | (Const i, ConstP j) => if i = j
                                    then SOME []
                                    else NONE
     | (Tuple(vs), TupleP(ps)) => if length vs <> length ps
                                  then NONE
                                  else let 
                                    val vs_ps = ListPair.zip(vs, ps)
                                    val matches = all_answers match vs_ps
                                       in 
                                         case matches of 
                                              NONE => NONE
                                            | SOME matches => SOME matches
                                       end
     | (Constructor(s1, v), ConstructorP(s2, p)) => (let 
                                                   val matches = match(v, p) 
                                                   in if s1 = s2 then 
                                                       case matches of 
                                                            NONE => NONE
                                                          | SOME xs => SOME xs
                                                      else NONE 
                                                    end)
      | _ => NONE

fun first_match v ps = 
let 
  val zipped_list = map (fn x => (v, x)) ps
  val first = first_answer match zipped_list
in 
  SOME first
end 
handle NoAnswer => NONE
