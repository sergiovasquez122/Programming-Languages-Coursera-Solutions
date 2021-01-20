#lang racket
(provide (all-defined-out))
; Racket has nothing like a datatype binding for one-of types
; No need in a dynamically typed language:
; - Can just mix values of different types and use primitives
; - Can use cons cells to build any kind of data

; In ML, cannot have a list of "ints or strings", so use a datatype:
; datatype int_or_string = I of int | S of string
; fun funny_sum xs =
;     case xs of
;          [] => 0
;          | (I i)::xs' => i + funny_sum xs'
;          | (S s)::xs' => String.size s + funny_sum xs'
; In Racket, dynamic typing makes this natural without explicit tags
; - Instead, every value has a tag with primitives to check it
; - So just check car of list with number? or string?

