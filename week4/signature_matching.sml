(* structure Foo :> BAR *)
(* Every non-abstract type in BAR is provided in Foo *)
(* Every abstract type in BAR is provided in Foo in some way*)
(* EVery val-binding in BAR is provided in Foo, possibly with a more general
* and/or less abstract internal type *)
(* Every exectpion in BAR is provided in Foo*)
(* Foo can have more bindings *)
