(* lexical scope: use environment where function is defined *)
(* dynamic scope: use environment where function is called *)
(* lexical scope is how programming work nowadays *)
(*1. function meaning does not depend on variable names use *)
fun f1 y = 
  let 
    val x = y + 1
  in
    fn z => x + y + z 
  end

fun f2 y = 
let 
  val q = y + 1
in
  fn z => q + y + z
end

val x = 17 (* irrelevant *)
(* f1 and f2 are equivalent under lexical scoping but differ in dynamic scoping
* *)
val a1 = (f1 7) 4 (*f1 does not depend on x in lexical scope but does in dynamic
scope *)
val a2 = (f2 7) 4(*f2 wouldn't work if use with dynamic scoping*)

fun f g = let val x = 9 in g() end
val x = 7
fun h() = x + 1 (* would evaluate to 8 under lexical scope *)
val y = f h (* would evaluate to 10 under dynamic scoping *)

(* 2. functions can be type-checked and reasoned about where defined *)
val x = 1
fun f y =  
  let 
    val x = y + 1
  in 
    fn z => x + y + z 
end

val x = "hi"
val g = f 7
val z = g 4
(* 3. Closures can easily store the data they need *)
fun greaterThanX x = fn y => y > x
 
fun filter'(f, xs) =
  case xs of
       [] => []
     | x::xs' => if f x
                 then x::filter'(f, xs')
                 else filter'(f, xs')

fun noNegatives xs = filter'(greaterThanX ~1, xs)
fun allGreater(xs, x) = filter'(greaterThanX x, xs)
(* dynamic scope is convienient for some situations, racket allows this *)
(* exceptions act a little bit like dynamic scope *)
