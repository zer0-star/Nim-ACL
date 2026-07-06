
when not declared ATCODER_LI_CHAO_TREE_HPP:
  const ATCODER_LI_CHAO_TREE_HPP* = 1
  import std/algorithm
  import std/sequtils

  type
    Line*[T] = object
      a*, b*: T

    LiChaoTree*[T] = object
      len*: int
      xs*: seq[T]
      seg*: seq[Line[T]]

  proc initLine*[T](a, b: T): Line[T] =
    Line[T](a: a, b: b)

  proc get*[T](self: Line[T], x: T): T =
    self.a * x + self.b

  proc over*[T](self, b: Line[T], x: T): bool =
    self.get(x) < b.get(x)

  proc initLiChaoTree*[T](x: seq[T], inf_val: T): LiChaoTree[T] =
    var xs = x
    xs.sort
    xs = xs.deduplicate(true)

    var len = 1
    while len < xs.len:
      len = len shl 1

    while xs.len < len:
      xs.add(xs[^1] + T(1))

    return LiChaoTree[T](
      len: len,
      xs: xs,
      seg: newSeqWith(2 * len - 1, initLine(T(0), inf_val))
    )

  proc updateLine[T](self: var LiChaoTree[T], line: Line[T], k, l, r: int) =
    var x = line
    let m = (l + r) shr 1

    let
      latte = x.over(self.seg[k], self.xs[l])
      malta = x.over(self.seg[k], self.xs[m])

    if malta:
      swap(self.seg[k], x)

    if r - l == 1:
      return

    if latte != malta:
      self.updateLine(x, 2 * k + 1, l, m)
    else:
      self.updateLine(x, 2 * k + 2, m, r)

  proc updateSegment[T](self: var LiChaoTree[T], line: Line[T], ql, qr, k, l, r: int) =
    if qr <= l or r <= ql:
      return

    if ql <= l and r <= qr:
      self.updateLine(line, k, l, r)
      return

    let m = (l + r) shr 1
    self.updateSegment(line, ql, qr, 2 * k + 1, l, m)
    self.updateSegment(line, ql, qr, 2 * k + 2, m, r)

  proc update*[T](self: var LiChaoTree[T], a, b: T, s: Slice[int]) =
    let
      ql = max(0, s.a)
      qr = min(self.len, s.b + 1)

    assert ql <= qr

    if ql < qr:
      self.updateSegment(initLine(a, b), ql, qr, 0, 0, self.len)

  proc update*[T](self: var LiChaoTree[T], a, b: T) =
    self.updateLine(initLine(a, b), 0, 0, self.len)

  proc query*[T](self: LiChaoTree[T], k: int): T =
    assert 0 <= k and k < self.len

    let x = self.xs[k]
    var k = k + self.len - 1

    result = self.seg[k].get(x)

    while k > 0:
      k = (k - 1) shr 1
      result = min(result, self.seg[k].get(x))
