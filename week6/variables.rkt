#lang racket
; Interpreters so far have been for language without variables
; - no let-expressions, functions-with-arguments, etc.
; An evironment is a mapping from variables to values
; - Only ever put pairs of strings and values in the evironment
; Evaluation takes place in an evironment
; We'll have a list of pairs
; - Evironment passed as argument to interpreter helper function
; - A variable expresssion looks up the variable in the environment
; - Most subexpressions use same environment as outer expressions
; - A let-expresssion evaluates it body in a larger environment
; So now a recursive heper function has all the intersting stuff.
; (define (eval-under-env e env)
          ;; (cond _ ; case for each kind of expression
; recursive calls must "pass down" correct environment
; The eval-exp just calls eval-under-env with same expressions and the empty environment
; eval-under-env would be helper function one could define locally inside eval-exp