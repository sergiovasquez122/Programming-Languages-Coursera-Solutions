#lang racket
(provide (all-defined-out))
; The bindings in a file work like local defines i.e letrec
; - Like ML, you can refer to earlier bindings
; - Unlike ML, you can also refer to later bindings
; - But refer to later bindigns only in function bodies
;   - Because bindings are evaluated in order
;   - An error to use an undefined variable
; - Unlike ML, cannot define the same variable twice in module
;   - Would not make sense: cannot have both in environment
(define (f x) (+ x (* x b))) ; forward reference okay here
(define b 3)
(define c (+ b 4)) ; backward reference okay
; (define d (+  e 4))
(define e 5)
;(define f 17) ; not okay; f already defined in this module

; REPL works differently
; not quite like let* or letrec

; best to avoid recursive function definitions or forward references in REPL
; - Actually okay unless shadowing something - then weirdness ensues
; - And calling recursive functions is fine of course
