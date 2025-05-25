when not declared ATCODER_ELEMENT_CONCEPTS_HPP:
  const ATCODER_ELEMENT_CONCEPTS_HPP* = 1
  proc inv*[T:SomeFloat](a:T):auto = T(1) / a
  proc init*(self:typedesc[SomeFloat], a:SomeNumber):auto = self(a)
  type HasInitInt* = concept x, type T
    T.init(0)
  type HasIntConverter* = concept x, type T
    T(0)
  type AdditiveGroupElem* = concept x, y, type T
    x + y is T
    x - y is T
    -x is T
    T is HasInitInt or T is HasIntConverter
  type MultiplicativeGroupElem* = concept x, y, type T
    x * y is T
    x / y is T
    T is HasInitInt or T is HasIntConverter
  type RingElem* = concept x, y, type T
    x + y is T
    x += y
    x - y is T
    x -= y
    x * y is T
    x *= y
    -x is T
    T is HasInitInt or T is HasIntConverter
  type FieldElem* = concept x, y, type T
    T is RingElem
    x.inv() is T
    x / y is T
    x /= y
  type FiniteFieldElem* = concept x, type T
    T is FieldElem
    #T.mod
    #T.mod() is int
    #x.pow(1000000)
  type hasInf* = concept x, type T
    T(Inf)
