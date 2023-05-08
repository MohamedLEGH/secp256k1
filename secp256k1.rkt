#lang racket/base
(require "field.rkt")

(module+ test
  (require rackunit
           rackunit/text-ui))

(struct elliptic-curve (a b field) #:prefab)

;; parameters of the secp256k1 curve

; prime of the field
(define P #xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F)

; max val on the curve : G*N = I
(define N #xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141)

; parameter A = 0
(define A (field-element 0 P))

; parameter B = 7
(define B (field-element 7 P))

(define secp256k1 (elliptic-curve A B P))

(struct point (x y curve) #:prefab)

(define (point-to-string point-val)
  (string-append (field-to-string (point-x point-val))
                 (field-to-string (point-y point-val))))

(define (string-to-point point-hex #:curve [curve secp256k1])
  ; TODO : check that the point is on the curve
  (define x (substring point-hex 0 64))
  (define y (substring point-hex 64))
  (point (string-to-field x P) (string-to-field y P) curve))

(define (on-curve? point-val)
  (define x (point-x point-val))
  (define y (point-y point-val))
  (define ec (point-curve point-val))
  (define a (elliptic-curve-a ec))
  (define b (elliptic-curve-b ec))
  (define ysquare (pow-element y 2))
  (define xcube (pow-element x 3))
  (define ax (mul-element a x))
  ; y^2 = x^3 + ax + b
  (equal? ysquare (add-element (add-element xcube ax) b)))

; Generator of the curve
(define G
  (point (field-element
          #x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798
          P)
         (field-element
          #x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8
          P)
         secp256k1))

; Identity for the addition
(define I (point null null secp256k1))

(define (add-point point1 point2)
  ; TODO: check if points are on the curve
  ; TODO: check if points have the same curve

  (cond
    [(equal? point1 I) point2]
    [(equal? point2 I) point1]
    [(and (equal? (point-x point1) (point-x point2))
          (equal? (point-y point1) (rmul-element (point-y point2) -1)))
     I]
    [(not (equal? (point-x point1) (point-x point2)))
     (define x1 (point-x point1))
     (define x2 (point-x point2))
     (define y1 (point-y point1))
     (define y2 (point-y point2))
     ; s = (y2 - y1) / (x2 - x1)
     (define s (truediv-element (sub-element y2 y1) (sub-element x2 x1)))
     ; x3 = s ** 2 - x1 - x2
     (define x3 (sub-element (sub-element (pow-element s 2) x1) x2))
     ; y3 = s * (x1 - x3) - y1
     (define y3 (sub-element (mul-element s (sub-element x1 x3)) y1))
     (point x3 y3 secp256k1)]
    [(and (equal? point1 point2) (equal? (point-y point1) +inf.0)) I]
    [(equal? point1 point2)
     (define x1 (point-x point1))
     (define y1 (point-y point1))
     (define a (elliptic-curve-a (point-curve point1)))
     ; s = (3 * x1 ** 2 + a) / (2 * y1)
     (define s
       (truediv-element (add-element (rmul-element (pow-element x1 2) 3) a)
                        (rmul-element y1 2)))
     ; x3 = s ** 2 - 2 * x1
     (define x3 (sub-element (pow-element s 2) (rmul-element x1 2)))
     ; y3 = s * (x1 - x3) - y1
     (define y3 (sub-element (mul-element s (sub-element x1 x3)) y1))
     (point x3 y3 secp256k1)]
    [else (error "cannot add the 2 points on the curve")]))

(define (rmul-point value scalar)
  ; TODO: check if point are on the curve
  (define (binary-expansion p s)
    (cond
      [(equal? s 0) I]
      [(equal? s 1) p]
      [(equal? (modulo s 2) 1) (add-point p (binary-expansion p (- s 1)))]
      [else (binary-expansion (add-point p p) (/ s 2))]))
  (binary-expansion value scalar))

(module+ test
  (define test-curve
    (test-suite "Tests for curve.rkt"
      (let ()
        (define p2
          (point
           (field-element
            #x9577FF57C8234558F293DF502CA4F09CBC65A6572C842B39B366F21717945116
            P)
           (field-element
            #x10B49C67FA9365AD7B90DAB070BE339A1DAF9052373EC30FFAE4F72D5E66D053
            P)
           secp256k1))
        (define e (+ (expt 2 240) (expt 2 31)))
        (test-case "Test with assert G*e = p2"
          (check-equal? (rmul-point G e) p2)))))
  (run-tests test-curve))

(provide (all-from-out "field.rkt")
         (struct-out elliptic-curve)
         (struct-out point)
         on-curve?
         point-to-string
         string-to-point
         add-point
         rmul-point
         G
         P
         N
         I
         secp256k1)
