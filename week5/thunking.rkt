#lang racket
(provide (all-defined-out))

(define (factorial-normal x)
  (if (= x 0)
      1
      (* x (factorial-normal (- x 1)))))
; - Function arguments are eager (call-by-value)
; evaluated once before called in the function
; - conditional branches are not eager
(define (my-if-bad x y z)
  (if x y z))

(define (factorial-bad n)
  (my-if-bad (= n 0) ; all function arguments attempted to evaluted
             1
             (* n (factorial-bad (- n 1)))))

(define (my-if-strange-but-works e1 e2 e3)
  (if e1 (e2) (e3)))

(define (factorial-okay x)
  (my-if-strange-but-works
   (= x 0)
   (λ() 1)
   (λ() (* x (factorial-okay (- x 1))))))
; A zero-argument function used to delay evaluation is called a thunk
(define b (λ() (+ 3 2)))