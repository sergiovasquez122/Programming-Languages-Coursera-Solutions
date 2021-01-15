#lang racket

(provide (all-defined-out))
; empty list: null
; cons constructor: cons
; access head of list: car
; access tail of list: cdr
; check for empty: null?
; (list e1 - en) for building lists
; names car and cadr are a historical accident
(define (sum xs)
  (if (null? xs)
      0
      (+ (car xs) (sum (cdr xs)))))

; append function in racket so we define our own with different name
(define (my-append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (my-append (cdr xs) ys))))

; map
(define (my-map f xs)
  (if (null? xs)
      null
      (cons (f (car xs)) (my-map f (cdr xs)))))

; filter
(define (my-filter f xs)
  (if (null? xs)
      null
      (if (f (car xs))
          (cons (car xs) (my-filter f (cdr xs)))
          (my-filter f (cdr xs)))))

(define (mu-filter 
(define (squared x)
  (* x x))

(define l1 (my-map squared (list 1 2 3 4 5)))
(define l2 (my-filter even? (list 1 2 3 4 5 )))
(define l3 (my-filter odd? (list 1 2 3 4 5 )))
(define l4 (my-map (λ(x) (+ x 1))
                   (cons 1 (cons 2 (cons 3 (cons 4 (cons 5 null)))))))

