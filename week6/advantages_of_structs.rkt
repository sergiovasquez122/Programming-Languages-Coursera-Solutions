#lang racket
(provide (all-defined-out))
; Struct approach is even better combined with other Racket features not discussed here:
; The module system lets us hide the constructor function to
; enforce invariants
; - List-approach cannot hide cons from clients
; - Dynamically-typed languages can have abstract types by
; letting modues define new types!
; The contract system lets us check invariants even if constructor is exposed
; - For example, fields of "an add" must also be "expressions"
; Struct is special
; - A function cannot introduce multiple bindings
; - Neither functions nor macros can create a new kind of data
; - Results of constructor functions returns false for every other functions: number?, pairs?, other struct tester functions. etc