when not declared ATCODER_DUAL_CUMULATIVE_SUM_HPP:
  const ATCODER_DUAL_CUMULATIVE_SUM_HPP* = 1
  import std/sequtils

  type DualCumulativeSum*[T] = object
    pos: int
    data: seq[T]

  proc initDualCumulativeSum*[T](sz:int = 100):DualCumulativeSum[T] =
    DualCumulativeSum[T](data: newSeqWith(sz, T(0)), pos: -1)
  proc initDualCumulativeSum*[T](a:seq[T]):DualCumulativeSum[T] =
    var data = a
    data.add(T(0))
    for i in 0..<a.len:
      data[i + 1] -= a[i]
    return DualCumulativeSum[T](data: data, pos: -1)
  proc add*[T](self: var DualCumulativeSum[T], s:Slice[int], x:T) =
    doAssert self.pos < s.a
    if s.a > s.b: return
    if self.data.len <= s.b + 1:
      self.data.setlen(s.b + 1 + 1)
    self.data[s.a] += x
    self.data[s.b + 1] -= x

  proc `[]`*[T](self: var DualCumulativeSum[T], k:int):T =
    if k < 0: return T(0)
    if self.data.len <= k:
      self.data.setlen(k + 1)
    while self.pos < k:
      self.pos += 1
      if self.pos > 0: self.data[self.pos] += self.data[self.pos - 1]
    return self.data[k]
