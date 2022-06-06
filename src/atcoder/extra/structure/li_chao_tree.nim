when not declared ATCODER_LI_CHAO_TREE_HPP:
  const ATCODER_LI_CHAO_TREE_HPP* = 1
  import std/sequtils
  type
    Line*[T] = object
      a, b:T
    LiChaoTree*[T] = object
      len*: int
      xs: seq[T]
      seg: seq[Line[T]]
  
  proc initLine*[T](a, b:T):Line[T] = Line[T](a:a, b:b)
  proc get*[T](self: Line[T], x:T):T =
    result = self.a * x + self.b
  proc over*[T](self, b: Line[T], x: T):bool = self.get(x) < b.get(x)
  
  proc initLiChaoTree*[T](x: seq[T], inf_val:T):LiChaoTree[T] =
    var xs = x
    var len = 1
    while len < xs.len: len = len shl 1
    while xs.len < len: xs.add(xs[^1] + 1)
    #block:
    #  var seg = newSeq[Line[T]](2 * len - 1)
    #  for i in 0 ..< seg.len:
    #    seg[i] = initLine(T(0), inf_val)
    return LiChaoTree[T](len:len, xs:xs, seg:newSeqWith(2 * len - 1, initLine(T(0), inf_val)))
  
  proc disjoint*(x, y:Slice[int]):bool = x.b < y.a or y.b < x.a
  proc subset*(x, y:Slice[int]):bool = y.a <= x.a and x.b <= y.b

  proc update*[T](self: var LiChaoTree[T], x:ptr[Line], k:int, ks:Slice[int]) =
    let (l, r) = (ks.a, ks.b + 1)
    let mid = (l + r) shr 1
    let
      latte = x[].over(self.seg[k], self.xs[l])
      malta = x[].over(self.seg[k], self.xs[mid])
    if malta: swap(self.seg[k], x[])
    if l + 1 >= r: return
    elif latte != malta: self.update(x, 2 * k + 1, l ..< mid)
    else: self.update(x, 2 * k + 2, mid ..< r)

  
  #proc update*[T](self: var LiChaoTree[T], x:Line[T], s:Slice[int], k:int, ks:Slice[int]) =
  #  if disjoint(s, ks): return
  #  let (l, r) = (ks.a, ks.b + 1)
  #  var m = (l + r) shr 1
  #  if m == r: m -= 1
  #  if not subset(ks, s):
  #    self.update(x, s, 2 * k + 1, l..<m)
  #    self.update(x, s, 2 * k + 2, m..<r)
  #  else:
  #    let
  #      latte = x.over(self.seg[k], self.xs[l])
  #      malta = x.over(self.seg[k], self.xs[m])
  #    var x = x
  #    if malta: swap(self.seg[k], x)
  #    if l + 1 >= r: return
  #    elif latte != malta: self.update(x, s, 2 * k + 1, l..<m)
  #    else: self.update(x, s, 2 * k + 2, m..<r)
  
  proc update*[T](self: var LiChaoTree[T], a, b:T, s:Slice[int]) =
    let l = initLine(a, b)
    self.update(l, s, 0, 0..<self.len)
  proc update*[T](self: var LiChaoTree[T], a, b:T) =
    var l = initLine(a, b)
    #echo "update: ", a, " ", b
    #self.update(l, 0..<self.len, 0, 0..<self.len)
    self.update(l.addr, 0, 0..<self.len)

  proc query*[T](self: var LiChaoTree[T], k:int):T =
    let x = self.xs[k]
    #echo "query: ", x
    var k = k + self.len - 1;
    result = self.seg[k].get(x)
    while k > 0:
      k = (k - 1) shr 1
      result = min(result, self.seg[k].get(x))
