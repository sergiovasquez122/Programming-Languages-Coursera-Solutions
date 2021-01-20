#lang racket
(provide (all-defined-out))

; (struct foo (bar baz quux))
; Defines a new kind of thing and introduces several new functions
; (foo e1 e2 e2) returns "a foo" with bar, baz, quux fields holding results of evaluating e1, e2 and e3
; (foo? e) evalutes e and return true if and only if the result is something that was made with the foo function
; (foo-bar e) evaluates e. If teh result was made with the foo funcion, return the contents of the bar field, else an error
; (foo-baz e) evaluates e. If the result was made with the foo function, return the contents of the baz field, else an error
; (foo-quux e) evaluates 3. If the result was made with the foo function, return the contents of the quux field, else an error
(struct const (int) #:transparent)
(struct negate (e)#:transparent)
(struct add (e1 e2)#:transparent)
(struct multiply (e1 e2)#:transparent)
; For datatypes like exp, create one struct for each kind of exp
; - structs are like ML constructors!
; - but provide constructors, tester and extractor functions
; -- Instead of patterns
; -- E.g. const, const?, const-int
; - Dynamic typing means "these are the kind of exp" is "in comments" rather than a type system
; - Dynamic typing means "types" of fields are also "in comments"
(define (eval-exp e)
  (cond [(const? e) e]
        [(negate? e) (const (- (const-int (eval-exp (negate-e e)))))]
        [(add? e) (let ([v1 (const-int (eval-exp (add-e1 e)))]
                        [v2 (const-int (eval-exp (add-e2 e)))])
                    (const (+ v1 v2)))]
         [(multiply? e) (let ([v1 (const-int (eval-exp (multiply-e1 e)))]
                        [v2 (const-int (eval-exp (multiply-e2 e)))])
                    (const (* v1 v2)))]
         [true (error "eval-exp expected an exp")]))
; #:transparent is an optional attribute on struct definition
; - For us, prints struct values in REPL rather than hiding them

; #:mutable is another optional attribute on struct definition
; - can decide if each struct supports mutation, with usual advantages and disadvantages
; - mcons is just a predefined mutable struct

