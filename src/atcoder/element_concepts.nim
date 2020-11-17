when not declared ATCODER_ELEMENT_CONCEPTS_HPP:
  const ATCODER_ELEMENT_CONCEPTS_HPP* = 1
  proc inv*[T:SomeFloat](a:T):auto = T(1) / a
  proc init*(self:typedesc[SomeFloat], a:SomeNumber):auto = self(a)
  type AdditiveGroupElem* = concept x, type T
    x + x
    x - x
    -x
    T(0)
  type MultiplicativeGroupElem* = concept x, type T
    x * x
    x / x
#    x.inv()
    T(1)
  type RingElem* = concept x, type T
    x + x
    x - x
    -x
    x * x
    T(0)
    T(1)
  type FieldElem* = concept x, y, type T
    x + y
    x - y
    x * y
    x / y
    -x
    x.inv()
    T(0)
    T(1)
  type FiniteFieldElem* = concept x, type T
    T is FieldElem
    T.mod
    T.mod() is int
    x.pow(1000000)
  type hasInf* = concept x, type T
    T(Inf)
