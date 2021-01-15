(* according to our definition of equivalence, these two functions are
* equivalent but we learned on is awful *)

(* T(n) = 2 * T(n - 1) + O(1) 
*  T(n) = O(2**n) *)
fun bad_max xs = 
  case xs of
       [] => raise List.Empty
     | x::[] => x
     | x::xs' => 
         if x > bad_max xs'
         then x
         else bad_max xs'

(* T(n) = O(n) *)
fun good_max xs = 
  case xs of
       [] => raise List.Empty
     | x::[] => x
     | x::y::xs' => let val y = good_max xs'
                    in if x < y 
                       then y
                       else x
                    end

(* different definitions of equivalence for different jobs *)
(* PL equivalence: given same inputs, same outputs and effects 
* -Good: lets us replace bad_max with good_max 
* -Bad: vice versa, ignores performance in the extreme *)

(* Asymptotic equivalence: ignore constant factors 
* -Good: focus on the algorithm and efficiency for large inputs
* -Bad: ignores 'four times faster' *)

(* System equivalence: Account for constant overheads
* -Good: faster means different and better
* -Bad: Beware overtuning on 'wrong' inputs. definition does not let you 'swap'
* in a different algorithm*)

(* Claim by Dan Grossman: 'Computer scientists implictly use all three every day'*)
