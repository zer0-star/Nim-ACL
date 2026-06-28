when not declared ATCODER_FENWICKTREE_HPP:
  const ATCODER_FENWICKTREE_HPP* = 1

  import std/sequtils
  import atcoder/internal_type_traits
  import atcoder/rangeutils

  # Reference: https://en.wikipedia.org/wiki/Fenwick_tree
  type FenwickTree*[T, U] = object
    len*:int
    data*:seq[U]

  proc init*(self:typedesc[FenwickTree], n:int):auto =
    return self(len:n, data:newSeqWith(n, self.U(0)))
  proc init*(self:var FenwickTree, n:int) =
    if self.data.len < n: self.data.setLen(n)
    self.data.fill(0, n - 1, self.U(0))
    self.len = n

  template FenwickTreeType*(T:typedesc):typedesc[FenwickTree] =
    type U = to_unsigned(T)
    typedesc[FenwickTree[T, U]]
  template getType*(FT:typedesc[FenwickTree], T:typedesc):typedesc[FenwickTree] =
    FenwickTreeType(T)
  proc initFenwickTree*[T](n:int):auto = FenwickTreeType(T).init(n)

  proc add*[FT:FenwickTree](self: var FT, p:IndexType, x:FT.T) =
    var p = self^^p
    assert p in 0..<self.len
    p.inc
    while p <= self.len:
      self.data[p - 1] += FT.U(x)
      p += p and -p
  proc sum[FT:FenwickTree](self: FT, r:int):auto =
    result = FT.U(0)
    var r = r
    while r > 0:
      result += self.data[r - 1]
      r -= r and -r
  proc sum*[FT:FenwickTree](self: FT, p:RangeType):FT.T =
    let (l, r) = self.halfOpenEndpoints(p)
    assert 0 <= l and l <= r and r <= self.len
    return cast[FT.T](self.sum(r) - self.sum(l))
  proc `[]`*[FT:FenwickTree](self: FT, p:RangeType):FT.T = self.sum(p)
