(* structures without using signatures really only provide namespace management 
* using signatures give a type for modules 
* this allows us to provide interfaces that code outside the module must obey *)
signature MATHLIB = 
sig
  val fact : int -> int
  val half_pi : real
  val doubler : int -> int
end

structure MyMathLib :> MATHLIB =
struct
  fun fact(n) = 
  let 
    fun accum(n, acc) = 
        case n of
             0 => acc
            |n => accum(n - 1, acc * n)
  in 
    accum(n, 1)
  end

  val half_pi = Math.pi / 2.0;

  fun doubler y = y + y
end
