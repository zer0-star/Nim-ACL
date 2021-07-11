when not declared ATCODER_CUMULATIVE_SUM_HPP:
  const ATCODER_CUMULATIVE_SUM_HPP* = 1
  import std/sequtils

  type CumulativeSum*[T; reverse:static[bool]] = object
    n: int
    pos: int
    data: seq[T]

  proc initCumulativeSum*(n:int, T:typedesc, reverse:static[bool] = false):CumulativeSum[T, reverse] =
    result = CumulativeSum[T, reverse](data: newSeqWith(n + 1, T.default), pos:0, n:n)

  proc `[]=`*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse], k:int, x:T) =
    when reverse: (let k = self.n - k)
    if k < self.pos: doAssert(false)
    if self.data.len < k + 2: self.data.setLen(k + 2)
    self.data[k + 1] = x

  proc propagate*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse]) =
    if self.data.len < self.pos + 2: self.data.setLen(self.pos + 2)
    self.data[self.pos + 1] += self.data[self.pos]
    self.pos.inc
  proc initCumulativeSum*[T](data:seq[T], reverse:static[bool] = false):CumulativeSum =
    result = initCumulativeSum[T, reverse]()
    for i,d in data: result[i] = d
  proc sum*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse], k:int):T =
    if k < 0: return T(0)
    while self.pos < k: self.propagate()
    return self.data[k]
  proc `[]`*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse], s:Slice[int]):T =
    when reverse: (let s = self.n - s.b .. self.n - s.a)
    if s.a > s.b: return T(0)
    return self.sum(s.b + 1) - self.sum(s.a)

