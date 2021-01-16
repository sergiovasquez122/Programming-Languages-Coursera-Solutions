#lang racket
(provide (all-defined-out))

; Thunks let you skip expensive computations if they are not needed
; Great if you take the true-branch
; worst if you end up using the thunk more than once
; In general, might not know how many times a result is needed

(define (slow-add x y)
  (letrec ([slow-id (λ(y z)
                      (if (= 0 z)
                          y
                          (slow-id y (- z 1))))])
    (+ (slow-id x 5000) y)))

(define (my-mult x y-thunk)
  (cond [(= x 0) 0]
        [(= x 1) (y-thunk)]
        [(true (+ (y-thunk) (my-mult (- x 1) y-thunk)))]))