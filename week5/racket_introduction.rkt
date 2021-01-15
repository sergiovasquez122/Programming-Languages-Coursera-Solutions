#lang racket

(provide (all-defined-out))

(define x 3) ; val x = 3

(define y (+ x 2)) ; + is a function, call it here

(define cube1
  (lambda (x)
    (* x (* x x))))

(define cube2
  (lambda (x)
    (* x x x)))

; functions can take any number of arguments, not syntatic sugar
(define (cube3 x)
  (* x x x))

(define (pow1 x y) ; x to the yth power (y must be non-negative
  (if (= y 0)
      1
      (* x (pow1 x (- y 1)))))

(define pow2
  (lambda (x)
    (lambda (y)
      (pow1 x y))))

(define three-to-the (pow2 3))
(define sixteen ((pow2 4) 2))