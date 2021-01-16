#lang racket
(provide (all-defined-out))

(define (sequence low high stride)
  (cond [(> low high) null]
        [true (cons low (sequence (+ low stride) high stride))]))

(define (string-append-map xs suffix)
  (map (λ(s) (string-append s suffix)) xs))

(define (list-nth-mod xs n)
  (cond [(> 0 n) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [true (car (list-tail xs (remainder n (length xs))))]))