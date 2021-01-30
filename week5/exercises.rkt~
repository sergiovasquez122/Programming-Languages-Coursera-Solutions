#lang racket
(provide (all-defined-out))

(define (palindromic xs)
  (letrec ([ys (reverse xs)]
         [f (λ(xs ys)
              (cond [(null? xs) null]
                    [(cons (+ (car xs) (car ys))
                           (f (cdr xs) (cdr ys)))]))])
    (f xs ys)))