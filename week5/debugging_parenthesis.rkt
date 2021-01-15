#lang racket
(provide (all-defined-out))
; Parentheses matter
; You must break your of one habit for Racket:
; - Do not add/remove parens because you feel like it
;   - Parens are never optional or meaningless!!!

; - In most places (e) means call e with zero arguments

; so ((e)) means call e with zero arguments and call the result with zero arguments

; Without static typing, often get hard-to-diagnose run-times errors
(define (fact n) (if (= n 0)
                     1
                     (* n (fact (- n 1)))))

(define square
  (λ(n)
    (* n n )))

(define pow
  (λ(x y)
    (if (= y 0)
        1
        (* x (pow x (- y 1))))))

(define pow-with-currying
  (λ(x)
    (λ(y)
      (if (= y 0)
          1
          (* x (pow x (- y 1)))))))

(define raise-two-by (pow-with-currying 2))
(define eight (raise-two-by 3))

(define (append xs ys)
  (if (null? xs)
      ys
      (cons (car xs) (append (cdr xs) ys))))

(define (my-map f xs)
  (if (null? xs)
      null
      (cons (f (car xs)) (my-map f (cdr xs)))))

(define (my-filter f xs)
  (if (null? xs)
      null
      (if (f (car xs))
          (cons (car xs) (my-filter f (cdr xs)))
          (my-filter f (cdr xs)))))

(define (my-exists f xs)
  (if (null? xs)
      false
      (or (f (car xs)) (my-exists f (cdr xs)))))