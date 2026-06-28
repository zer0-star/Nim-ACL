when not declared ATCODER_MO_HPP:
  const ATCODER_MO_HPP* = 1
  import std/math, std/sequtils
  type Mo* = object
    width:int
    left, right, order: seq[int]
  
  proc initMo*(N, Q:int):Mo =
    let width = max(1, int(1.0 * float(N) / max(1.0, sqrt(float(Q) * 2.0 / 3.0))))
    result.width = width
    result.order = (0 ..< Q).toSeq
  
  proc insert*(self:var Mo, l, r:int) =
    self.left.add(l)
    self.right.add(r)
  
  proc initMo*(N:int, l, r:seq[int]):Mo =
    doAssert l.len == r.len
    let Q = l.len
    result = initMo(N, Q)
    for i in 0 ..< Q:
      result.insert(l[i], r[i])
  
  proc run*[AL, AR, DL, DR, REM](self:Mo, add_left:AL, add_right:AR, delete_left: DL,delete_right:DR, rem:REM) =
    assert self.left.len == self.order.len
    var order = self.order
    order.sort do (a, b:int) -> int:
      let
        ablock = self.left[a] div self.width
        bblock = self.left[b] div self.width
      if ablock != bblock: cmp(ablock, bblock)
      elif (ablock and 1) != 0: cmp(self.right[a], self.right[b])
      else: -cmp(self.right[a], self.right[b])
    var
      nl = 0
      nr = 0
    for idx in order:
      while nl > self.left[idx]: nl.dec;add_left(nl)
      while nr < self.right[idx]: add_right(nr);nr.inc
      while nl < self.left[idx]: delete_left(nl);nl.inc
      while nr > self.right[idx]: nr.dec;delete_right(nr)
      rem(idx)

