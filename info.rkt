#lang info
(define collection "secp256k1")
(define deps '("base" "math-lib"))
(define build-deps '("scribble-lib" "racket-doc" "rackunit-lib"))
(define scribblings
  '(("scribblings/secp256k1.scrbl" ()) ("scribblings/field.scrbl" ())))
(define pkg-desc "Utilities for the secp256k1 curve, as used in Bitcoin")
(define version "0.0.1")
(define pkg-authors '(Mohamed Amine LEGHERABA))
(define license 'MIT)
