#lang brag 

sentence: ATOMIC | complex
complex: LPAR sentence RPAR | sentence connective sentence
connective: AND | OR | NOT | IF | IFF | LPAR | RPAR
