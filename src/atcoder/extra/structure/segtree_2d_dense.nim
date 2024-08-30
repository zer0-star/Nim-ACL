when not declared ATCODER_SEGTREE_2D_HPP:
  const ATCODER_SEGTREE_2D_HPP* = 1
  import std/sequtils
  type SegmentTree2D*[T; p:static[tuple]] = object
    H, W: int
    seg: seq[T]

  proc id[ST:SegmentTree2D](self: ST, h, w:int):int = h * 2 * self.W + w

  proc init[ST:SegmentTree2D](self:var ST, h, w:int) =
    self.H = 1
    self.W = 1
    while self.H < h: self.H = self.H shl 1
    while self.W < w: self.W = self.W shl 1
    self.seg = newSeqWith(4 * self.H * self.W, self.p.e())

  template initSegmentTree2D*[T](h, w:int, op1: static[auto], e1:static[auto]):auto =
    var a = SegmentTree2D[T, (op:op1, e:e1)]()
    a.init(h, w)
    a

  ## buildより前にのみ呼ぶ
  proc set*[ST:SegmentTree2D](self:var ST, h, w:int, x:ST.T) =
    self.seg[self.id(h + self.H, w + self.W)] = x

  proc build*[ST:SegmentTree2D](self: var ST) =
    # w in [W, 2W)
    for w in self.W ..< 2 * self.W:
      for h in countdown(self.H - 1, 1):
        self.seg[self.id(h, w)] = self.p.op(self.seg[self.id(2 * h + 0, w)], self.seg[self.id(2 * h + 1, w)])
    # h in [0, 2H)
    for h in 0 ..< 2 * self.H:
      for w in countdown(self.W - 1, 1):
        self.seg[self.id(h, w)] = self.p.op(self.seg[self.id(h, 2 * w + 0)], self.seg[self.id(h, 2 * w + 1)])

  proc get*[ST:SegmentTree2D](self: ST, h, w:int):ST.T = self.seg[self.id(h + self.H, w + self.W)]
  proc `[]`*[ST:SegmentTree2D](self: ST, h, w:int):ST.T = self.seg[self.id(h + self.H, w + self.W)]

  proc update*[ST:SegmentTree2D](self: var ST, h, w:int, x:ST.T) =
    var (h, w) = (h, w)
    h += self.H; w += self.W
    self.seg[self.id(h, w)] = x
    block:
      var i = h shr 1
      while i > 0:
        self.seg[self.id(i, w)] = self.p.op(self.seg[self.id(2 * i + 0, w)], self.seg[self.id(2 * i + 1, w)])
        i = i shr 1
    while h > 0:
      var j = w shr 1
      while j > 0:
        self.seg[self.id(h, j)] = self.p.op(self.seg[self.id(h, 2 * j + 0)], self.seg[self.id(h, 2 * j + 1)])
        j = j shr 1
      h = h shr 1
  proc `[]=`*[ST:SegmentTree2D](self: var ST, h, w:int, x:ST.T) = self.update(h, w, x)

  # [ (h1,w1), (h2,w2) ) 半開
  proc prod*[ST:SegmentTree2D](self: ST, h, w:Slice[int]):ST.T =
    proc inner_query[ST:SegmentTree2D](self: ST, h, w1, w2:int):ST.T =
      result = self.p.e()
      var (w1, w2) = (w1, w2)
      while w1 < w2:
        if (w1 and 1) != 0: result = self.p.op(result, self.seg[self.id(h, w1)]); w1.inc
        if (w2 and 1) != 0: w2.dec; result = self.p.op(result, self.seg[self.id(h, w2)])
        w1 = w1 shr 1
        w2 = w2 shr 1
    var (h1, w1, h2, w2) = (h.a, w.a, h.b + 1, w.b + 1)
    if h1 >= h2 or w1 >= w2: return self.p.e()
    result = self.p.e()
    h1 += self.H;h2 += self.H;w1 += self.W; w2 += self.W
    while h1 < h2:
      if (h1 and 1) != 0: result = self.p.op(result, self.inner_query(h1, w1, w2)); h1.inc
      if (h2 and 1) != 0: h2.dec; result = self.p.op(result, self.inner_query(h2, w1, w2))
      h1 = h1 shr 1
      h2 = h2 shr 1
  proc `[]`*[ST:SegmentTree2D](self: ST, h, w:Slice[int]):ST.T = self.prod(h, w)
