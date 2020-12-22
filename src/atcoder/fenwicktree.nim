when not declared ATCODER_FENWICKTREE_HPP:
  const ATCODER_FENWICKTREE_HPP* = 1
  import std/sequtils
  import atcoder/internal_type_traits

  # Reference: https://en.wikipedia.org/wiki/Fenwick_tree
  type FenwickTree*[T, U] = object
    n*:int
    data*:seq[U]

  proc init*(self:typedesc[FenwickTree], n:int):auto =
    return self(n:n, data:newSeqWith(n, self.U(0)))
  proc init*(self:var FenwickTree, n:int) =
    if self.data.len < n: self.data.setLen(n)
    self.data.fill(0, n - 1, self.U(0))
    self.n = n

  template FenwickTreeType*(T:typedesc):typedesc[FenwickTree] =
    type U = to_unsigned(T)
    typedesc[FenwickTree[T, U]]
  template getType*(FT:typedesc[FenwickTree], T:typedesc):typedesc[FenwickTree] =
    FenwickTreeType(T)
  proc initFenwickTree*[T](n:int):auto = FenwickTreeType(T).init(n)

  proc add*[FT:FenwickTree](self: var FT, p:int, x:FT.T) =
    assert p in 0..<self.n
    var p = p + 1
    while p <= self.n:
      self.data[p - 1] += FT.U(x)
      p += p and -p
  proc sum[FT:FenwickTree](self: FT, r:int):auto =
    result = FT.U(0)
    var r = r
    while r > 0:
      result += self.data[r - 1]
      r -= r and -r
  proc sum*[FT:FenwickTree](self: FT, p:Slice[int]):FT.T =
    let (l, r) = (p.a, p.b + 1)
    assert 0 <= l and l <= r and r <= self.n
    return cast[FT.T](self.sum(r) - self.sum(l))
