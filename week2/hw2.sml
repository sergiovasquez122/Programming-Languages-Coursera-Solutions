(*Write a function all_exception_option, which takes a string and  string list.
* Return None if the string is not in the list, else return SOME lst where lst
* is identical to the argument list except for the string si not in it. you may
* assume the string is in the list at most once*)
fun all_except_option(x, xs) = 
  case xs of
       [] => NONE
     | x'::xs' => if x' = x
                 then SOME (xs')
                 else (case all_except_option(x, xs') of
                           NONE => NONE
                         | SOME xs' => SOME(x'::xs'))

fun get_substitutions1(xs, s) = 
  case xs of 
       [] => []
     | x::xs' => (case all_except_option(s, x) of
                      NONE => get_substitutions1(xs', s)
                    | SOME(x') => x'@ get_substitutions1(xs', s))

fun get_substitutions2(xs, s) = 
let 
  fun helper(xs, acc) = 
    case xs of
         [] => acc
       | x::xs' => (case all_except_option(s, x) of
                         NONE => helper(xs', acc)
                       | SOME(x') => helper(xs', acc @ x')) 
in 
  helper(xs, [])
end

fun similar_names(xs, {first=f,middle=m,last=l}) = 
let 
  val subs_xs = get_substitutions1(xs, f)
  fun helper(xs) = 
    case xs of
         [] => [] 
       | x::xs' => {first=x,middle=m,last=l}::helper(xs')
in
  {first = f, middle = m, last = l}::helper(subs_xs)
end

datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw

exception IllegalMove

fun card_color(c) = 
  case c of
       (Clubs, _) => Black
     | (Spades, _) => Black
     | _ => Red

fun card_value(c) = 
  case c of
       (_, Num x) => x
     | (_, Ace) => 11
     | _ => 10

fun remove_card(cs, c, e) = 
  case cs of
       [] => raise e
     | c'::cs' => if c = c'
                  then cs'
                  else let val rest = remove_card(cs', c, e)
                       in c'::rest
                       end

fun all_same_color(cs) = 
  case cs of 
       [] => true
     | x::[] => true
     | x::y::cs' => card_color x = card_color y andalso all_same_color(y::cs')

fun sum_cards(cs) = 
let 
  fun helper(cs, acc) =
      case cs of 
           [] => acc
         | c::cs => helper(cs, card_value c + acc)
in
  helper(cs, 0)
end

fun score(cs, goal) =
let 
  val card_sum = sum_cards(cs) 
  val prelim_score = if card_sum > goal 
                     then 3 * (card_sum - goal)
                     else (goal - card_sum)
in 
  if all_same_color(cs)
  then prelim_score div 2
  else prelim_score 
end

fun officiate(card_list, move_list, goal) = 
let 
  fun current_status(held_cards, card_list, move_list) = 
    case (card_list, move_list) of
         (_, []) => score(held_cards, goal)
       | ([],  Draw::ms') => score(held_cards, goal)
       | (c::cs', Draw::ms') => (if sum_cards(c::held_cards) > goal
                                 then score(c::held_cards, goal)
                                 else current_status(c::held_cards, cs', ms'))
       | (card_list, (Discard(c))::ms') => current_status(remove_card(held_cards, c, IllegalMove), card_list, ms')
in
  current_status([], card_list, move_list)
end
