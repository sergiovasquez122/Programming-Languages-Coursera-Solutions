#lang racket
(provide (all-defined-out))
; Dynamic typing

; Major topic coming later: Contrasting static typing (e.g, ML)
; with dynamic typing (e.g Racket)

; For now:
; - Frustrating not to catch "little errors" like (n * x) until you test your functions
; - But you can use very flexible data structures and code without convincing a type checker that it makes sense

; Example:
; - A list that can contain number or other lists
; - Assuming lists or numbers "all the way down", sum all the numbers ...
(define xs (list 4 5 6))

(define ys (list (list 4 5) 6 7 (list 8) 9 2 3 (list 0 1)))

(define zs (list false "hi" 14))

(define (sum1 xs)
  (if (null? xs)
      0
      (if (number? (car xs))
          (+ (car xs) (sum1 (cdr xs)))
          (+ (sum1 (car xs)) (sum1 (cdr xs))))))
; second version that skips over values that are not list or numbers
(define (sum2 xs)
  (if (null? xs)
      0
      (if (number? (car xs))
          (+ (car xs) (sum2 (cdr xs)))
          (if (list? (car xs))
              (+ (sum2 (car xs)) (sum2 (cdr xs)))
              (sum2 (cdr xs))))))
; sum2 still assume that first argument is a list
; will not work for (sum2 "hi")
(define (sum3 xs)
  (if (list? xs)
      (sum2 xs)
      0))