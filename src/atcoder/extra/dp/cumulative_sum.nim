when not declared ATCODER_CUMULATIVE_SUM_HPP:
  const ATCODER_CUMULATIVE_SUM_HPP* = 1
  import std/sequtils
  import atcoder/rangeutils

  type CumulativeSum*[T; reverse:static[bool]] = object
    len: int
    pos: int
    data: seq[T]
  proc initCumulativeSum*[T](n:int):CumulativeSum[T, false] =
    result = CumulativeSum[T, false](data: newSeqWith(n + 1, T.default), pos:0, len:n)
  proc initCumulativeSumReverse*[T](n:int):CumulativeSum[T, true] =
    result = CumulativeSum[T, true](data: newSeqWith(n + 1, T.default), pos:0, len:n)

  proc initCumulativeSum*(n:int, T:typedesc, reverse:static[bool] = false):CumulativeSum[T, reverse] =
    result = CumulativeSum[T, reverse](data: newSeqWith(n + 1, T.default), pos:0, len:n)

  proc `[]=`*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse], k:IndexType, x:T) =
    var k = self^^k
    when reverse: k = self.len - k
    if k < self.pos: doAssert(false)
    if self.data.len < k + 2: self.data.setLen(k + 2)
    self.data[k + 1] = x
  proc add*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse], k:IndexType, x:T) =
    var k = self^^k
    when reverse: k = self.len - k
    if k < self.pos: doAssert(false)
    if self.data.len < k + 2: self.data.setLen(k + 2)
    self.data[k + 1] += x

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
  proc `[]`*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse], s:RangeType):T =
    var s = s.a .. self^^s.b
    when reverse: s = self.len - s.b .. self.len - s.a
    if s.a > s.b: return T(0)
    return self.sum(s.b + 1) - self.sum(s.a)
