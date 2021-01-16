#lang racket
; cons just makes a pair
; - Often called a cons cell
; - By convention and standard library, lists are nested pairs that eventually end with null
; all lists are pairs but pair not necessarily a list
; (define do-not-do-this (length pr)) expects a list
; car is like ML #1 for tuples
; cdr is like ML #2 for tuples
(define pr (cons 1 (cons true "hi")))
(define lst (cons 1 (cons true (cons "hi" null))))
(define hi (cdr (cdr pr)))
(define hi-again (car (cdr (cdr lst))))
(define hi-another (caddr lst))
(define no (list? pr))
(define yes (pair? pr))
(define of-course (and (list? lst) (pair? lst)))
; Proper list is a series of nested cons cells where the second element of the innermost cons cell is null
; So why improper lists?
; - Pairs are useful, they were useful in SML
; - without static types, why distinguish (e1, e2) and e1::e2

; Style:
; - Use proper lists for collections of unknown size
; - But feel free to use cons to build a pair
;  - though structures may be better

; Built-in primitives
; - list? return true for proper lists, including the empty list
; - pair? return true for thing made by cons
;         - all imporer and proper lists except the empty list
(list? null)
(list? (cons 1 (cons 2 null)))
(pair? null)
(pair? (cons 1 (cons 2 null)))