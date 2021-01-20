#lang racket
; Implementing Programming Languages
; Typical workflow
; taking in some string -> parsing -> AST
; (concrete syntax)                   (abstract syntax tree)
; Interpreter or compiler
; So "rest of implementation" takes the abstract syntax tree (AST) and "runs the program" to produce a result
; Fundamentally, two approaches to implement a PL B:
; Write an interpreter in another language A
; - Better names: evaluator, executor
; - Take a program in B and produce an answer (in B)
; Write a compiler in another language A to a third language C
; - Better name: translator
; - Translation must preserve meaning (equivalence)
; We call A the metalanguage
; - Crucial to keep A and B straight

; Evaluation (interpreter) and translation (compiler) are your options
; - But in modern practice have both and multiple layers
; A plausible example:
; - Java compiler to bytecode intermediate language
; - Have an interpreter for bytecode (itself in binary). but compile frequent function to binary at run-time
; - The chip is itself an interpreter for binary
; Interpreter versus compiler versus combinations is about a particular langauge implementation, not the language definition
; so there is no such thing as a "compiled language" or an "interpreted language"
; - Programs cannot "see" how the implementation works
; Unfornutately, you often hear such phrases
; - "C is faster because it's compiled and LISP is interpreted"
; - Wrong and don't make much sense
; If implementing PL B in PL A, we can skip parsin
; - Have B programming write ASTs directly in PL A
; - Not so bad with ML constructs or Racket structrs
; - Embeds B programs as trees in A

; - Let the metalanguage A = Racket
; - Let the langauge-implemented B = "Arithmetic Language"
; - Arithmetic programs written with calls to Racket constructors
; - The interpreter is eval-exp