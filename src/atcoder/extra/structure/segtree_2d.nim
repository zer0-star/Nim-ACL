when not declared ATCODER_SEGTREE_2D_HPP:
  const ATCODER_SEGTREE_2D_HPP* = 1
  import atcoder/segtree
  type SegTree2D*[S; SegTree] = object
    N2: int
    xs: seq[S]
    ys: seq[seq[S]]
    segt: seq[SegTree]

  proc initSegTree2D*[S](v: seq[tuple[x, y:int]], op: static[proc(a, b:S):S], e: static[proc():S]):auto =
    type st = SegTreeType[S](op, e)
    result = SegTree2D[S, st]()
    for i in 0 ..< v.len: result.xs.add v[i].x
    result.xs.sort
    result.xs = result.xs.deduplicate(true)
    var N2 = 1
    while N2 < result.xs.len: N2 *= 2

    result.ys.setLen(N2 * 2)
    result.segt.setLen(N2 * 2)
    result.N2 = N2

    for (x, y) in v:
      let xi = result.xs.lowerBound(x)
      var i = xi + result.N2
      while i > 0:
        result.ys[i].add y
        i = i shr 1

    for i in 1 ..< result.ys.len:
      result.ys[i].sort
      result.ys[i] = result.ys[i].deduplicate(true)
      result.segt[i].init(result.ys[i].len)

  proc add*[ST:SegTree2D](self: var ST, x, y:int, v:ST.S) =
    let xi = self.xs.lowerBound(x)
    doAssert self.xs[xi] == x
    var i = xi + self.N2
    while i > 0:
      let yi = self.ys[i].lowerBound(y)
      doAssert self.ys[i][yi] == y
      self.segt[i][yi] = self.SegTree.calc_op(self.segt[i][yi], v)
      i = i shr 1

  proc get*[ST:SegTree2D](self: var ST, x, y:int):ST.S =
    let xi = self.xs.lowerBound(x)
    doAssert self.xs[xi] == x
    result = self.SegTree.calc_e()
    var i = xi + self.N2
    while i > 0:
      let yi = self.ys[i].lowerBound(y)
      doAssert self.ys[i][yi] == y
      result = self.SegTree.calc_op(self.segt[i][yi], result)
      i = i shr 1
  proc `[]`*[ST:SegTree2D](self: var ST, x, y:int):ST.S = self.get(x, y)

  proc prod*[ST:SegTree2D](self: var ST, xp, yp: Slice[int] or int):ST.S =
    when xp is int:
      let xp = xp .. xp
    when yp is int:
      let yp = yp .. yp
    var
      sml, smr = self.SegTree.calc_e()
    let
      xl = xp.a
      xr = xp.b + 1
      yl = yp.a
      yr = yp.b + 1
      xil = self.xs.lowerBound(xl)
      xir = self.xs.lowerBound(xr)
    var
      l = xil + self.N2
      r = xir + self.N2
    while l < r:
      if (l and 1) != 0:
        let
          yli = self.ys[l].lowerBound(yl)
          yri = self.ys[l].lowerBound(yr)
        sml = self.SegTree.calc_op(self.segt[l][yli ..< yri], sml)
        l.inc
      if (r and 1) != 0:
        r.dec
        let
          yli = self.ys[r].lowerBound(yl)
          yri = self.ys[r].lowerBound(yr)
        smr = self.SegTree.calc_op(self.segt[r][yli ..< yri], smr)
      l = l shr 1
      r = r shr 1
    return self.SegTree.calc_op(sml, smr)
  proc `[]`*[ST:SegTree2D](self: var ST, xp, yp: Slice[int] or int):ST.S = self.prod(xp, yp)
