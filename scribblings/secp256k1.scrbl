#lang scribble/manual
@require[@for-label[secp256k1
                    racket/base]]

@title{secp256k1}
@author[(author+email "Mohamed Amine LEGHERABA" "mohamed.amine.legheraba@gmail.com")]

@defmodule[secp256k1]

@defthing[P integer? #:value #xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F]{
  Prime of the field. value = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F"
}

@defthing[N integer? #:value #xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141]{
  Max val on the curve. value = "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141"
}
