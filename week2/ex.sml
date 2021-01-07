datatype exp = Constant of int
             | Negate of exp
             | Add of exp * exp
             | Multiply of exp * exp

fun max_constant e = 
  case e of 
       Constant e => e
     | Negate e => max_constant e
     | Add(e1, e2) => Int.max(max_constant e1, max_constant e2)
     | Multiply(e1, e2) => Int.max(max_constant e1, max_constant e2)
