#lang racket
; Time to build a colsure is tiny: a struct with two fields
; Space to store closures might be large if environmetn is large
; - But environments are immutable, so natural and correct to have lots of sharing. e.g, of lists tails
; - Still, end up keeping around bindings that are not needed
; Alternatively used in practice. When creating a closure, store a possibly-smaller environment holding only the variables that are free variales in the function body
; - Free variables: Variables that occur, not counting shadowed uses of the same variable name
; - A function body would never need anything else from the environment

; Free variables examples
; (λ() (+ x y z)) ; (x, y, z)
; (λ(x) (+ x y z)) ; (y, z)
; (λ(x) (if x y z)) ; (y, z)
; (λ(x) (let ([y 0]) (+ x y z)) ; (z)
; (λ (x y z) (+ x y z)) ; {}
; (λ(x) (+ y (let ([y z])) (+ y y)))) ; {y z}

; So does the interpreter have to analyze the code body every time it creates a closure;
; No: before evaluation begins, compute free variables of every function in program and store this information with the function
; Compaared to naive store-entire-environment approach, building a closure now takes more time but less space
; -- and time proportional to number of free variables
; -- and various optimizations are possible
; [also use a much better data structure for looking up variables than a list]

