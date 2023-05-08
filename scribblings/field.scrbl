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

@defproc[(field-to-string [value integer? [field integer?]]) boolean?]{
  Return true if  0 <= @racketfont{value} < @racketfont{field} 
}
