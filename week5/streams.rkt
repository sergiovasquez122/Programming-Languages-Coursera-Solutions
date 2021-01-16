#lang racket
(provide (all-defined-out))

; A stream is an infinite sequence of values
; - So cannot make a stream by making all the values
; - Key idea: Use a thunk to delay creating most of the sequence
; - Just a programming idiom

; A powerful concept for division of labor:
; - Stream producer knows how to create any number of values
; - Steam consumer decides how many values to ask for

; Some examples of steams you might be familiar with:
; - Use actions
; - Unix pipes
; - Output values from a sequential feedback circuit

; Stream will be represented as a thunk which gives back a pair
; (next-answer . next-thunk
