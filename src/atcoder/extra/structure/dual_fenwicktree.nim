when not declared ATCODER_FENWICKTREE_HPP:
  const ATCODER_FENWICKTREE_HPP* = 1
  import std/sequtils
  import atcoder/internal_type_traits
  import atcoder/rangeutils

  # Reference: https://en.wikipedia.org/wiki/Fenwick_tree
  type DualFenwickTree*[T, U] = object
    len*:int
    data*:seq[U]

  proc init*(self:typedesc[DualFenwickTree], n:int):auto =
    return self(len:n, data:newSeqWith(n, self.U(0)))
  proc init*(self:var DualFenwickTree, n:int) =
    if self.data.len < n: self.data.setLen(n)
    self.data.fill(0, n - 1, self.U(0))
    self.len = n

  template DualFenwickTreeType*(T:typedesc):typedesc[DualFenwickTree] =
    type U = to_unsigned(T)
    typedesc[DualFenwickTree[T, U]]
  template getType*(FT:typedesc[DualFenwickTree], T:typedesc):typedesc[DualFenwickTree] =
    DualFenwickTreeType(T)
  proc initDualFenwickTree*[T](n:int):auto = DualFenwickTreeType(T).init(n)

  proc `[]`*[FT:DualFenwickTree](self: FT, p:IndexType):auto =
    var p = self^^p
    assert p in 0..<self.len
    p.inc
    result = FT.U(0)
    while p <= self.len:
      result += self.data[p - 1]
      p += p and -p
  proc add*[FT:DualFenwickTree](self: var FT, r:int, x:FT.T) =
    var r = r
    while r > 0:
      self.data[r - 1] += FT.U(x)
      r -= r and -r
  proc add*[FT:DualFenwickTree](self: var FT, p:RangeType, x:FT.T) =
    let (l, r) = self.halfOpenEndpoints(p)
    assert 0 <= l and l <= r and r <= self.len
    self.add(r, x)
    self.add(l, -x)
