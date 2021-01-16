#lang racket
(provide (all-defined-out))

; the infinite sequence of ones
(define ones (λ () (cons 1 ones)))

; returning a pair and the second argument will be evaluted resulting in infinite loop
; racket is an eager language, it will try to evaluate it
; will work in haskell
; (define ones-really-bad (cons 1 ones-really-bad))


;(define ones-bad (λ() (cons 1 (ones-bad))))
; this is an infinite loop, will continously try to evaluate thunk resulting in infinite loop

; the natural numbers
(define (f x)
  (cons x (λ () (f (+ x 1)))))

(define nats (λ() (f 1)))
; power of two's
(define power-of-twos
  (letrec ([f (λ(x) (cons x (λ() (f (* x 2)))))])
    (λ() (f 1))))
; helper function
(define (stream-maker fn arg)
  (letrec ([f (λ(x) (cons x (λ() (f (fn x arg)))))])
    (λ() (f 1))))

(define nats2 (stream-maker + 1))
(define power-of-two2 (stream-maker * 2))