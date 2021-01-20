#lang racket
; - Define syntax of language B with Racket structs
; - Write B programs directly in Racket via constructors
; - Implement interpreters for B as a Racket function
; Now, a subtle-but-important distinction:
; - Interpreter can assume input is a "legal AST for B"
; -- Okay to give wrong answer or inscrutable error otherwise
; - Intepreter must check that recursive result are the right kind of value
; -- Give a good error message otherwise
; "Trees the interpreter must handle" are a subset of all the trees Racket allows as a dynamically typed language
(struct const (int) #:transparent)
(struct negate (e) #:transparent)
(struct add (e1 e2) #:transparent)
(struct multiply (e1 e2) #:transparent)
; Can assume "right types" for struct fields
; - const holds a number
; - negate holds a legal AST
; - add and multiply hold 2 legal ASTs
; Illegal ASTs can "crash the interpreter"-this is fine
; - Our interpreters return expressions, but not any expressions
; - Results should always be a value, a kind of expressions that evaluate to itself
; - If not, the interpreter must has a bug
; So far, only values are from const
; But a larger language has more values than just numbers
; - Booleans, strings, etc.
; - Pairs of values
; - Closures
(struct bool (b) #:transparent)
(struct eq-num (e1 e2) #:transparent)
(struct if-then-else (e1 e2 e3) #:transparent)
; What if the program is a legal AST, but the evaluation of it tries to use the wrong kind of value?
; - For example, "add a boolean"
; - You should detect this and give an erro message not in terms of the interpreter implementation
; - Means checking a recursive result whenever a particular kind of value is needed
; -- No need to check if any kind of value is okay
(define test1 (multiply (negate (add (const 2) (const 2))) (const 7)))

(define test2 (multiply (negate (add (const 2) (const 2))) (if-then-else (bool false) (const 7) (bool true))))
; Don't have to deal with illegal AST's
(define (eval-exp e)
  (cond [(const? e) e]
        [(negate? e) 
        (let ([v (eval-exp (negate-e e))])
          (if (const? v)
              (const (- (const-int v)))
              (error "negate applied to non-number")))]
        [(add? e)
         (let ([v1 (eval-exp (add-e1 e))]
               [v2 (eval-exp (add-e2 e))])
           (if (and (const? v1) (const? v2))
               (const (+ (const-int v1) (const-int v2)))
               (error "add applied to non-number")))]
        [(multiply? e)
         (let ([v1 (eval-exp (multiply-e1 e))]
               [v2 (eval-exp (multiply-e2 e))])
           (if (and (const? v1) (const? v2))
               (const (* (const-int v1) (const-int v2)))
               (error "multiply applied to non-number")))]
        [(bool? e) e]
        [(eq-num? e)
         (let ([v1 (eval-exp (eq-num-e1 e))]
               [v2 (eval-exp (eq-num-e2 e))])
           (if (and (const? v1) (const? v2))
               (bool (= (const-int v1) (const-int v2)))
               (error "eq-num applied to non-number")))]
        [(if-then-else? e)
         (let ([v-test (eval-exp (if-then-else-e1 e))])
           (if (bool? v-test)
               (if (bool-b v-test)
                   (eval-exp (if-then-else-e2 e))
                   (eval-exp (if-then-else-e3 e)))
               (error "if-then-else applied to non-boolean")))]
        [true (error "eval-exp expected an exp")]))