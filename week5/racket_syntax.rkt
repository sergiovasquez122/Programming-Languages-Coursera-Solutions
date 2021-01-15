#lang racket

; Racket has an amazingly simple syntax

; A term (anything in the language) is either:
; An atom : #t, #f, 34, "hi", null, 4.0, x, ...
; A special form, define, lambda, if
;   Macros will let us define our own
; A sequence fo terms in parens
;   If t1 a special form, semantics of sequence is special
;   Else a function call

; Example: (+ 3 (car xs)) sequence with three terms, + not a special so a function call
; Example: (λ(x) (if x "hi" #t))

; can use [ anywhere you use ( but must match with ]

; By parenthesizing everything, converting the program text into a tree representing the prgoram is trivial and unambigious
; - Atoms are leaves
; - Sequences are nodes with elements as children
; - (no other rules)
; Also makes indentations easy
(define cube
  (λ(x)
    (* x x x)))
; no need to discuss operator precedence (x + y * z)
(define foo
  (λ (x y z)
    (+ x (* y y (- z y)))))
; HTML takes the same approach
; some reason, LISP/Scheme/Racket is the target of subjective parenthesis-bashing
; it's just syntax
