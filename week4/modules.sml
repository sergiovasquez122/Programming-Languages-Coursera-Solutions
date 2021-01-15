(*for large programs, one 'top-level' sequence of bindings is poor 
* -Especially because a binding can use all earlier(non-shadowed) bindings *)

(* so ML defines modules
*  structure MyModule = struct bindings end
*  
*  Inside a module, can use earlier bindings as usual
*  -can have any kind of bindings(val, datatype, exception... 
*  Outside a module, refer to earlier module bindings via
*  ModuleName.bindingName
*  -Just like List.foldl and String.toUpper, now you can define your own modules 
*  -The syntax for calling functions inside of 
        *  modules is ModuleName.bindingName so that the module that contains
        *  the function map is List *)
structure MyMathLib = 
struct
  fun fact x = 
    if x = 0 
    then 1
    else x * fact(x - 1)

  val half_pi = Math.pi / 2.0

  fun doubler y = y * 2
end

val pi = MyMathLib.half_pi + MyMathLib.half_pi

val twenty_eight = MyMathLib.doubler 14
(* output of repl
structure MyMathLib :
  sig
        val fact : int -> int
        val half_pi : real
        val doubler : int -> int
   end
val pi = 3.14159265359 : real
val twenty_eight = 28 : int
val it = () : unit
*)

(* So far this is just namespace management
* -giving a hierachy to names to avoid shadowing
* -allows different modules to reuse names
* -very important, but not interesting *)
