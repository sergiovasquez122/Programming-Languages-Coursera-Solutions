#lang racket
(provide (all-defined-out))

(define (palindromic xs)
  (letrec ([ys (reverse xs)]
         [f (λ(xs ys)
              (cond [(null? xs) null]
                    [(cons (+ (car xs) (car ys))
                           (f (cdr xs) (cdr ys)))]))])
    (f xs ys)))

(define fibonacci
  (letrec ([f (λ(x y) (cons x (λ() (f y (+ x y)))))])
    (λ() (f 0 1))))

(define (stream-map f s)
  (letrec ([g (λ(x)
                (let* ([pr (x)]
                 [hd (car pr)]
                 [tl (cdr pr)])
            (cons (f hd) (λ() (g tl)))))])
    (λ()(g s))))

(define (stream-zip s1 s2)
  (letrec ([g (λ(x y)
                (let* ([pr1 (x)]
                       [pr2 (y)]
                       [hd1 (car pr1)]
                       [hd2 (car pr2)]
                       [tl1 (cdr pr1)]
                       [tl2 (cdr pr2)])
                  (cons (cons hd1 hd2) (λ()(g tl1 tl2)))))])
    (λ()(g s1 s2))))