#lang racket
(provide (all-defined-out))
; Assuming some expensive computation has no side effects, ideally
; we would:
; - Not compute it until needed
; - Remember the answer so future uses complete immediately
; Called lazy evaluation
(define (my-delay th)
  (mcons false th))

(define (my-force p)
  (if (mcar p)
      (mcdr p)
      (begin (set-mcar! p true)
             (set-mcdr! p ((mcdr p)))
             (mcdr p))))
; An ADT represented by a mutable pair
; false in car means cdr is unevalutated thunk
; - Really a one-of-type: thunk or result-of-thunk
; Ideally hide representation in a module
