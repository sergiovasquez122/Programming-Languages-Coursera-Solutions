(*type synonyms creates another name for a type that is interchangable with
* existing type*)
type foo = int
(* Can be useful for more complicated types *)
datatype suit = Club | Diamond | Heart | Spade

datatype rank = Jack | Queen | King | Ace | Num of int

type Card = suit * rank

type name_record = {student_num : int option,
first : string, middle : string option, last : string}
