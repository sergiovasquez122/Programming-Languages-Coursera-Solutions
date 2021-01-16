#lang racket
; Unlike ML, Racket really has assignment statements
; - But used only when appropriate
;       (set! x e)
; For the x in the current environment, subsequent lookups of x
; get the result of evaluating expression e
; - Any code using this x will be affected
; - Like x = e in Java, C, Python, etc
; Once you have side-effects, sequences are useful;
; (being e1 e2 ... en)
(define x (begin
            (+ 5 3)
            (* 3 8)
            (- 3 2)))
; when using the begin special form,
; the result of the final expression is the
; returned value. Thus, x is bound to 1,
; which is the result of (- 3 2)
(define b 3)
(define f (λ(x) (* 1 (+ x b))))
(define c (+ b 4)); 7, in the environment c is 7
(set! b 5) ; henceforth, in this environment b is 5
(define z (f 4)) ; 9, it look ups b in the environment which is 5 so it's result is 9
(define w c) ; 7, c is 7 in the current environment, so w is also 7. 
; - Environment for closure determined when function is defined, but body is evaluted when funtion is called
; - Once an expresssion produces a value, it is irrelevant how the value was produced
(define a_ 10) ; in the environment a_ is 10
(define f_ (lambda (x) (* 3 (+ a_ x)))) 
(set! a_ 3); in the environment a_ is now 3
(define b_ (f 3)); f is evaluted lookups a_ which is 3 and does the arithmetic (* 3 (+ 3 3)) = 18
; Mutating top-level definitions is particularly problematic
; - What if any code could do set! on anything?
; - How could we defend against this?
; A general principle: If something you need not to change might change, make a local copy of it.
(define b__ 3)
(define f__
  (let ([b__ b__])
    (λ(x) (* 1 (+ x b__)))))
; - Primitives like + and * are just predefined variables bound to functions
; - But maybe that means that they are mutable
(define f___
  (let ([b b]
        [+ +]
        [* *])
    (λ(x) (* 1 (+ x b)))))
; - Even that won't work if f use other functions that use thing that might get mutationed - all functions would nee to copy everything mutable they used
; Actually don't have to worry about this
; In racket
; - Each file is a module
; - If a module does not use set! on a top-level variable, then Racet makes it constant and forbids set! outside the module
; - Primitives like +, * and cons are in a module that does not mutate them
;   - problem solved
; Showed the concept of copying to defend against mutation
; - Easier defense: Do not allow mutation
; - Mutable top-level bindings a highly dubious idea