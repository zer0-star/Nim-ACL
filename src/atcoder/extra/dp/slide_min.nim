when not declared ATCODER_SLIDEMIN_HPP:
  const ATCODER_SLIDEMIN_HPP* = 1
  import std/deques

  proc slideMin*[T](v:seq[T], k:int):seq[T] =
    var deq = initDeque[T]()
    result = newSeq[T]()
    for i in 0..<v.len:
      while deq.len > 0 and v[deq[^1]] >= v[i]:
        discard deq.popLast()
      deq.addLast(i)
      if i - k + 1 >= 0:
        result.add(v[deq[0]])
        if deq[0] == i - k + 1: deq.popFirst()
  proc slideMax*[T](v:seq[T], k:int):seq[T] =
    var v = v
    for i in 0..<v.len: v[i] = -v[i]
    result = slideMin(v, k)
    for i in 0..<result.len: result[i] = -result[i]
