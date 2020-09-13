when not defined ATCODER_ELEMENT_CONCEPTS_HPP:
  const ATCODER_ELEMENT_CONCEPTS_HPP = 1
  type GroupElem* = concept x, type T
    x + x
    x - x
    T(0)
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
