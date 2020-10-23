#lang racket

(require brag/support)
(require br-parser-tools/lex)

(require "grammar.rkt")

(define (tokenize ip)
  (define lexer 
    (lexer-src-pos
      ; define token rules here!
     [(char-range #\P #\Z) (token 'ATOMIC lexeme)] ; matches characters between P and Z
     ["^" (token 'AND lexeme)] ; matches "^" as logical AND token
     ["v" (token 'OR lexeme)] ; matches "v" as logical OR token
     ["~" (token 'NOT lexeme)] ;matches "~" as NOT token
     ["->" (token 'IF lexeme)] ; matches "->" as IF token
     ["<->" (token 'IFF lexeme)] ;matches "<->" as IFF token
     ["(" (token 'LPAR lexeme)] ; matches "(" as left parentheses
     [")" (token 'RPAR lexeme)] ; matches ")" as right parentheses
     [whitespace (token 'WHITESPACE lexeme #:skip? #t)]; skips whitespace 
     [(eof)(void)]
    )
    ) ; return void at end of file, this stops the parser
  (define (next-token)
    (lexer ip)); moves lexer to find the next token
  next-token
  )

(define stx
(parse (tokenize (open-input-string "P^Q")))) ;; produces syntax struct
(syntax->datum stx); converts syntax to the datum it contains
(define str-2
  (parse (tokenize (open-input-string "(P->Q) <-> ~R"))))
(syntax->datum str-2)
