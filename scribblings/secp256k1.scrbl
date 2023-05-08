#lang scribble/manual
@require[@for-label[secp256k1
                    racket/base]]

@title{secp256k1}
@author[(author+email "Mohamed Amine LEGHERABA" "mohamed.amine.legheraba@gmail.com")]

@defmodule[secp256k1]

@defstruct*[elliptic-curve ([a field-element?] [b field-element?] [field integer?])]{
  An elliptic curve, with each element respecting y^2 = x^3 + ax + b.
  The elliptic curve is defined over a finite @racketfont{field} 
}

@defthing[P integer? #:value #xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F]{
  Prime of the field. @racketfont{value} = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"
}

@defthing[N integer? #:value #xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141]{
  Max val on the curve. @racketfont{value} = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141"
}

@defthing[A field-element #:value (field-element 0 P)]{
    The parameter A of the curve secp256k1. @racketfont{A} = 0 mod P.
}

@defthing[B field-element #:value (field-element 7 P)]{
    The parameter B of the curve secp256k1. @racketfont{A} = 7 mod P.
}

@defthing[secp256k1 elliptic-curve #:value (elliptic-curve A B P)]{
    The curve secp256k1.
}

@defstruct*[point ([x field-element?] [y field-element?] [curve elliptic-curve?])]{
  A point (@racketfont{x},@racketfont{y}) on the @racketfont{curve}
}

@defproc[(point-to-string [point point?]) string?]{
  Display a point element (concatenation of the x and y values, in hexadecimal)
}

@defproc[(on-curve? [point-val point?]) boolean?]{
  Return true if y^2 = x^3 + ax + b
}

@defthing[G point #:value (point (field-element
          #x79BE667EF9DCBBAC55A06295CE870B07029BFCDB2DCE28D959F2815B16F81798
          P)
         (field-element
          #x483ADA7726A3C4655DA4FBFC0E1108A8FD17B448A68554199C47D08FFB10D4B8
          P)
         secp256k1)]{
    The generator of the curve.
}

@defthing[I point #:value (point null null secp256k1)]{
    The "0" point of the curve, or point at infinity.
}

@defproc[(add-point [point1 point?] [point2 point?]) point?]{
  Return point1 + point2, according to the addition rules for the elliptic curve secp256k1.
}

@defproc[(add-point [value point?] [scalar integer?]) point?]{
  Return value * scalar. Implemented as cumulative addition of the point with itself.
}