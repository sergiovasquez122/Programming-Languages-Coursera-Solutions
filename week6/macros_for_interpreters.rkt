#lang racket
; Implementing language B in language A
; Skipping parsing by writing language B programs directly in terms of langauge A constructors
; An interpreter written in A recursively evaluates

; What we know about macros:
; Extend the syntax of a language
; Use of a macro expands into language syntax before teh program is run i.e, before calling the main interpreter function

; With our set-up we can use language A functions that produce language B abstract syntax as language B "macros"
; - Language B programs can use the "macros" as though they are part of langauge B
; - No change to the interpreter or struct definitions
; - Just a programming idiom enabled by our set-up\
; -- Helps teach what macros are
(struct const (int) #:transparent)
(struct negate (e) #:transparent)
(struct add (e1 e2) #:transparent)
(struct multiply (e1 e2) #:transparent)
(struct bool (e) #:transparent)
(struct eq-num (e1 e2) #:transparent)
(struct if-then-else (e1 e2 e3) #:transparent)

(define (eval-exp e)
  (cond [(const? e) e]
        [(negate? e) (let ([v (eval-exp (negate-e))])
                       (cond [(const? v) (const (- (const-int v)))]
                             [true (error "negate applied to non-constant")]))]
        [(add? e) (let ([v1 (eval-exp (add-e1 e))]
                        [v2 (eval-exp (add-e2 e))])
                    (cond [(and (const? v1) (const? v2)) (const (+ (const-int v1) (const-int v2)))]
                          [true (error "add applied to non-constant")]))]
        [(multiply? e) (let ([v1 (eval-exp (multiply-e1 e))]
                             [v2 (eval-exp (multiply-e2 e))])
                         (const [(and (const? v1) (const? v2)) (const (* (const-int v1) (const-int v2)))]
                                [true (error "multiply applied to non-constant")]))]
        [(bool? e) e]
        [(eq-num? e) (let ([v1 (eval-exp (eq-num-e1 e))]
                        [v2 (eval-exp (eq-num-e2 e))])
                       (cond[(and (const? v1) (const? v2)) (bool (= (const-int v1) (const-int v2)))]
                            [true (error "eq-num applied to non-constant")]))]
        [(if-then-else? e) (let ([v1 (eval-exp (if-then-else-e1 e))]
                                 [v2 (eval-exp (if-then-else-e2 e))]
                                 [v3 (eval-exp (if-then-else-e3 e))])
                             (if (bool? v1)
                                 (if v1
                                     v2
                                     v3)
                                 (error "eq-num applied to non-bool")))]
        [true (error "eval-exp applied to non-exp")]))

(define (andalso e1 e2)
  (if-then-else e1 e2 (bool false)))

(define (double e)
  (multiply e (const 2)))

(define (list-product es)
  (if (null? es)
      (const 1)
      (multiply (car es) (list-product (cdr es)))))
; A macro should produce an expression in the language being implemented, not evaluate such an expression
