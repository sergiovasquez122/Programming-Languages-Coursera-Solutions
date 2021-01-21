#lang racket
; The most interesting and mind-bending part of the homework is tha tthe language being has first-class closures
; - with lexical scope of course
(struct closure (env fun) #:transparent)
; Fortunately, what you have to implement is what we have been stressing since we first learned about closures
; How do use the right evironment for lexicla scope when functions return other functions, store them in data structures
; the interpreter uses a closure data structure to keep the environment it will ned to use later
; evaluate a function expresssion
; A function is not a value; a closure is a value
; - Evaluating a funtion returns a closure
; - Create out of the function the current environment whne the function was evaluated
; evaluate a function call


; example
; (call e1 e2)
; Use current enviroment to evalue e1 to a closure
; - Error if result is a value that is not a closure
; Use current environment to evaluate e2 to a value
; Evaluate closure's function body in the closure's environment extended to
; - Map the function's arguement-name to the argument-value
; - and for recursion, map the functions' name to the whole closure
; This is the same semantics we learned a few weeks ago "coded up"
; Give a closure the code part is only ever evaluated using the evironment part, not the evironment at the call-site

