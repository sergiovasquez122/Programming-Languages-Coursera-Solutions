#lang racket
; cons cells are immutable
; In racket you cnnot mutate the content of a cons cell
; - list aliasing irrelevant
; - implement can make list? fast since listness if determined when cons cell is created
(define x (cons 14 null))

(define y x)

(set! x (cons 42 null)) ; alter what x points to not the list itself

(define mpr (mcons 1 (mcons true "hi")))

(mcar mpr)
(mcdr mpr)

(set-mcdr! mpr 47)

(mcdr mpr)
(set-mcdr! mpr (mcons true "hi"))
(set-mcar! mpr 14)
; (length mpr) cannot use lenght on mcons list
; new material
; - mcons
; - mcar
; - mcdr
; - mpair?
; - set-mcar!
; - set-mcdr!
; Run-time error to use mcar on a cons cell or car on an mcons cell