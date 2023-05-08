#lang scribble/manual
@require[@for-label[secp256k1
                    racket/base]]

@title{secp256k1}
@author[(author+email "Mohamed Amine LEGHERABA" "mohamed.amine.legheraba@gmail.com")]

@section[#:tag "field"]{Field}

@defmodule[secp256k1/field]

@defstruct*[field-element ([value integer?] [field integer?])]{
  An integer over a finite field.
}

@defproc[(field-to-string [field-val field-element?]) string?]{
  Display a field element (only the value, not the field number)
}

@defproc[(string-to-field [value-hex string?] [field integer?]) field-element?]{
  Return a field-element from a hexadecimal string and a field number
}

@defproc[(in-field? [value integer?] [field integer?]) boolean?]{
  Return true if  0 <= @racketfont{value} < @racketfont{field} 
}

@defproc[(add-element [fe1 field-element?] [fe2 field-element?]) field-element?]{
  Return fe1 + fe2
}

@defproc[(sub-element [fe1 field-element?] [fe2 field-element?]) field-element?]{
  Return fe1 - fe2
}

@defproc[(rmul-element [fe1 field-element?] [scalar integer?]) field-element?]{
  Return fe1 * scalar
}

@defproc[(mul-element [fe1 field-element?] [fe2 field-element?]) field-element?]{
  Return fe1 * fe2
}

@defproc[(pow-element [fe1 field-element?] [exponent integer?]) field-element?]{
  Return fe1 ^ scalar
}

@defproc[(truediv-element [fe1 field-element?] [fe2 field-element?]) field-element?]{
  Return fe1 / fe2
}