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


(define (stream-for-n-steps s n)
  (cond [(= n 0) null]
        [true (let* ([pr (s)])
                (cons (car pr) (stream-for-n-steps (cdr pr) (- n 1))))]))

(define funny-number-stream
  (letrec ([f (λ(x) (cons (if (= (remainder x 5) 0) (- 0 x) x) (λ() (f (+ x 1)))))])
    (λ() (f 1))))

(define dan-then-dog
  (letrec ([f (λ(x) (cons x (λ() (f (if (equal? "dan.jpg" x) "dog.jpg" "dan.jpg")))))])
    (λ() (f "dan.jpg"))))

(define (stream-add-zero s)
  (letrec ([f (λ(x) (let* ([pr (x)])
                      (cons (cons (car pr) 0) (λ() (f (cdr pr))))))])
    (λ() (f s))))

(define (cycle-lists xs ys)
  (letrec ([f (λ(n) (let* ([x (list-nth-mod xs n)]
                        [y (list-nth-mod ys n)])
                   (cons (cons x y) (λ() (f (+ n 1))))))])
    (λ() (f 0))))

(define (vector-assoc v vec)
  (let* ([size (vector-length vec)])
    (letrec ([f (λ(n) (cond [(= n size) false]
                            [(pair? (vector-ref vec n))
                             (if (equal? (car (vector-ref vec n)) v)
                                 (vector-ref vec n)
                                 (f (+ n 1)))]
                            [true (f (+ n 1))]))])
      (f 0))))

(define (cached-assoc xs n)
  (letrec ([vec (make-vector n)]
           [idx 0]
           [f (λ(x)
                (let ([ans (vector-assoc x vec)])
                  (if ans
                      (cdr ans)
                      (let ([new-ans (assoc x xs)])
                        (if (not new-ans)
                            false
                            (begin
                              (vector-set! vec idx new-ans)
                              (set! idx (remainder (+ idx 1) n))
                              new-ans))))))])
    f))