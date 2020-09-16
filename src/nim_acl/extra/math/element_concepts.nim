when not declared ATCODER_ELEMENT_CONCEPTS_HPP:
  const ATCODER_ELEMENT_CONCEPTS_HPP* = 1
  type AdditiveGroupElem* = concept x, type T
    x + x
    x - x
    T(0)
  type MultiplicativeGroupElem* = concept x, type T
    x * x
    x / x
    T(1)
  type RingElem* = concept x, type T
    x + x
    x - x
    x * x
    T(0)
    T(1)
  type FieldElem* = concept x, type T
    x + x
    x - x
    x * x
    x / x
    T(0)
    T(1)
