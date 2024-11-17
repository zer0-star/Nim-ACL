when not declared ATCODER_SEGTREE_2D_HPP:
  const ATCODER_SEGTREE_2D_HPP* = 1
  import atcoder/lazysegtree
  type LazySegTree2D*[S, F; LazySegTree] = object
    N2, size*, len* : int
    xs: seq[int]
    ys: seq[seq[int]]
    lz: seq[F]
    segt: seq[LazySegTree]
  
  proc initLazySegTree2D*[S, F](v: seq[tuple[x, y:int]], op: static[proc(a, b:S):S], e: static[proc():S], mapping: static[proc(f:F, s:S):S], composition: static[proc(f1, f2:F):F], id: static[proc():F]):auto =
    type st = LazySegTreeType[S, F](op, e, mapping, composition, id)
    result = LazySegTree2D[S, F, st]()
    for i in 0 ..< v.len: result.xs.add v[i].x
    result.xs.sort
    result.xs = result.xs.deduplicate(true)
    result.len = result.xs.len
    var N2 = 1
    while N2 < result.xs.len: N2 *= 2

    result.ys.setLen(N2 * 2)
    result.segt.setLen(N2 * 2)
    result.N2 = N2
    result.size = N2

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
  # updateなくて大丈夫か？
  #proc update[ST:LazySegTree2D](self:var ST, k:int) =
  #  self.d[k] = ST.calc_op(self.d[2 * k], self.d[2 * k + 1])
  proc all_apply*[ST:LazySegTree2D](self:var ST, k:int, f:ST.F) =
    #self.d[k] = ST.calc_mapping(f, self.d[k])
    self.segt[k].all_apply(f)
    if k < self.size:
      self.lz[k] = ST.calc_composition(f, self.lz[k])
  proc all_apply*[ST:LazySegTree2D](self:var ST, f:ST.F) =
    self.all_apply(1, f)
  proc push*[ST:LazySegTree2D](self: var ST, k:int) =
    self.all_apply(2 * k, self.lz[k])
    self.all_apply(2 * k + 1, self.lz[k])
    self.lz[k] = ST.calc_id()


  proc add*[ST:LazySegTree2D](self: var ST, x, y:int, v:ST.S) =
    let xi = self.xs.lowerBound(x)
    assert self.xs[xi] == x
    var i = xi + self.N2
    while i > 0:
      let yi = self.ys[i].lowerBound(y)
      assert self.ys[i][yi] == y
      self.segt[i][yi] = self.SegTree.calc_op(self.segt[i][yi], v)
      i = i shr 1

  proc get*[ST:LazySegTree2D](self: var ST, x, y:int):ST.S =
    let xi = self.xs.lowerBound(x)
    assert self.xs[xi] == x
    result = self.SegTree.calc_e()
    var i = xi + self.N2
    while i > 0:
      let yi = self.ys[i].lowerBound(y)
      assert self.ys[i][yi] == y
      result = self.SegTree.calc_op(self.segt[i][yi], result)
      i = i shr 1
  proc `[]`*[ST:LazySegTree2D](self: var ST, x, y:int):ST.S = self.get(x, y)

  proc apply*[ST:LazySegTree2D](self: var ST, xp, yp: Slice[int] or int, f:ST.F) =
    when xp is int:
      let xp = xp .. xp
    when yp is int:
      let yp = yp .. yp
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
        self.segt[l].apply(yli ..< yri, f)
        l.inc
      if (r and 1) != 0:
        r.dec
        let
          yli = self.ys[r].lowerBound(yl)
          yri = self.ys[r].lowerBound(yr)
        self.segt[r].apply(yli ..< yri, f)
      l = l shr 1
      r = r shr 1

  proc prod*[ST:LazySegTree2D](self: var ST, xp, yp: Slice[int] or int):ST.S =
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
  proc `[]`*[ST:LazySegTree2D](self: var ST, xp, yp: Slice[int] or int):ST.S = self.prod(xp, yp)
