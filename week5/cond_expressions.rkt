#lang racket
(provide (all-defined-out))

; Avoid nested if-expressions when you can use cond-expressions instead
; - Can think of one as sugar for the other

; General syntax: (cond [e1a e1b]
;                       [e2a e2b]
;                       ...
;                       [eNa eNb])
; good style: eNa should be true, default case
(define (sum3 xs)
  (cond [(null? xs) 0]
        [(number? (car xs)) (+ (car xs) (sum3 (cdr xs)))]
        [(list? (car xs)) (+ (sum3 (car xs)) (sum3 (cdr xs)))]
        [true false]))

(define (sum4 xs)
  (cond [(null? xs) 0]
        [(number? (car xs) (+ (car xs) (sum4 (cdr xs))))]
        [(list? (car xs)) (+ (sum4 (car xs)) (sum4 (cdr xs)))]
        [true 0]))

; For both if and cond, test expression can evalute to anything
; - It is not an error if the result is not #t or #f
; Semantics of if and cond
; - "Treat anything other than #f as true
; This feature makes no sense in a statically typed language
; Some consider using this feature poor style, but it can be convenient
(define (count-falses xs)
  (cond [(not (list? xs)) 0]
        [(null? xs) 0]
        [(car xs) (count-falses (cdr xs))]
        [true (+ 1 (count-falses (cdr xs)))]))