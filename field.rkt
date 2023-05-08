#lang racket/base
(require  racket/format
          math/number-theory)

(struct field-element (value field) #:prefab)

(define (field-to-string field-val)
  (~r (field-element-value field-val)
      #:base 16
      #:min-width 64
      #:pad-string "0"))

(define (in-field? value field)
  (and (<= 0 value) (< value field)))

(define (add-element fe1 fe2)
  ; should assert same field for fe1 and fe2
  (field-element (with-modulus (field-element-field fe1)
                               (mod+ (field-element-value fe1)
                                     (field-element-value fe2)))
                 (field-element-field fe1)))

(define (sub-element fe1 fe2)
  ; should assert same field for fe1 and fe2
  (field-element (with-modulus (field-element-field fe1)
                               (mod- (field-element-value fe1)
                                     (field-element-value fe2)))
                 (field-element-field fe1)))

(define (rmul-element fe1 scalar)
  (field-element (with-modulus (field-element-field fe1)
                               (mod* (field-element-value fe1) scalar))
                 (field-element-field fe1)))

(define (mul-element fe1 fe2)
  ; should assert same field for fe1 and fe2
  (field-element (with-modulus (field-element-field fe1)
                               (mod* (field-element-value fe1)
                                     (field-element-value fe2)))
                 (field-element-field fe1)))

(define (pow-element fe1 exponent)
  (field-element (with-modulus (field-element-field fe1)
                               (modexpt (field-element-value fe1) exponent))
                 (field-element-field fe1)))

(define (truediv-element fe1 fe2)
  ; should assert same field for fe1 and fe2
  (field-element
   (with-modulus (field-element-field fe1)
                 (mod/ (field-element-value fe1) (field-element-value fe2)))
   (field-element-field fe1)))

(provide (struct-out field-element)
         in-field?
         field-to-string
         add-element
         sub-element
         rmul-element
         mul-element
         pow-element
         truediv-element)
