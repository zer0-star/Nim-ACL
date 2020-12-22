when not declared ATCODER_CUMULATIVE_SUM_HPP:
  const ATCODER_CUMULATIVE_SUM_HPP* = 1
  import std/sequtils
  
  type CumulativeSum*[T] = object
    pos:int
    data: seq[T]
  
  proc initCumulativeSum*[T](n = 1):CumulativeSum[T] =
    CumulativeSum[T](data: newSeqWith(n, T(0)), pos:0)

  proc `[]=`*[T](self: var CumulativeSum[T], k:int, x:T) =
    if k < self.pos: doAssert(false)
    if self.data.len < k + 2: self.data.setLen(k + 2)
    self.data[k + 1] = x
  
  proc propagate*[T](self: var CumulativeSum[T]) =
    while self.data.len < self.pos + 2: self.data.setLen(self.pos + 2)
    self.data[self.pos + 1] += self.data[self.pos]
    self.pos.inc
  
  proc initCumulativeSum*[T](data:seq[T]):CumulativeSum[T] =
    result = initCumulativeSum[T]()
    for i,d in data: result[i] = d
  
  proc sum*[T](self: var CumulativeSum[T], k:int):T =
    if k < 0: return T(0)
    while self.pos <= k: self.propagate()
    return self.data[k]
  proc `[]`*[T](self: var CumulativeSum[T], s:Slice[int]):T =
    if s.a > s.b: return T(0)
    return self.sum(s.b + 1) - self.sum(s.a)
