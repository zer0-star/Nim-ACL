when not declared ATCODER_FORMAL_POWER_SERIES_SPARSE_HPP:
  const ATCODER_FORMAL_POWER_SERIES_SPARSE_HPP* = 1
  import std/sequtils, std/tables, std/algorithm, std/strformat, std/macros
  import atcoder/element_concepts
  import atcoder/extra/math/formal_power_series
  type SparseFormalPowerSeries*[T:FieldElem] = seq[tuple[d:int, c:T]] # sorted ascending order

#  converter toSparseFormalPowerSeries*[XI, T](a:array[XI, (int, T)]):SparseFormalPowerSeries[T] = a.toSeq()

  # SparseMonomial {{{
  type SparseMonomial*[T] = object
    c:T
    d:int
  
  proc initSparseVar*[T](c = 1, d = 1):SparseMonomial[T] = SparseMonomial[T](c:T(c), d:d)
  
  proc `^`*[T](f:SparseMonomial[T], n:int):SparseMonomial[T] =
    result = f
    result.d *= n
    if f.c != T(1): result.c = result.c ^ n
  
  converter toSFPS*[T](f:SparseMonomial[T]):SparseFormalPowerSeries[T] = @[(f.d,f.c)]

  proc `+`*[T](f, g: SparseMonomial[T]):SparseFormalPowerSeries[T] =
    return toSFPS(f) + toSFPS(g)

  proc `*`*[T](f, g:Monomial[T]):Monomial[T] =
    result.c = f.c * g.c
    result.d = f.d + g.d
  # }}}

  converter toSFPS*[T](f:Table[int, T]):SparseFormalPowerSeries[T] = toSeq(f).sortedByIt(it.d)
#  converter toSFPS*[T](a:T):SparseFormalPowerSeries[T] = @[(0, a)]
  proc deg*[T](a:SparseFormalPowerSeries[T]):int = a[^1].d
  proc `+=`*[T](a:var SparseFormalPowerSeries[T], b:SparseFormalPowerSeries[T]) =
    var r:SparseFormalPowerSeries[T]
    var i, j = 0
    while i < a.len or j < b.len:
      if i < a.len and j < b.len and a[i].d == b[j].d:
        r.add((a[i].d, a[i].c + b[j].c))
        i.inc;j.inc
      else:
        if j == b.len or (i < a.len and a[i].d < b[j].d):
          r.add(a[i]);i.inc
        else:
          r.add(b[j]);j.inc
    swap(r, a)
  proc `+=`*[T](a:var SparseFormalPowerSeries[T], b:T) = a += @[(0, b)]
  proc `-=`*[T](a:var SparseFormalPowerSeries[T], b:SparseFormalPowerSeries[T]) =
    var r:SparseFormalPowerSeries[T]
    var i, j = 0
    while i < a.len or j < b.len:
      if i < a.len and j < b.len and a[i].d == b[j].d:
        r.add((a[i].d, a[i].c - b[j].c))
        i.inc;j.inc
      else:
        if j == b.len or (i < a.len and a[i].d < b[j].d):
          r.add(a[i]);i.inc
        else:
          r.add((b[j].d, -b[j].c));j.inc
    swap(r, a)
  proc `-=`*[T](a:var SparseFormalPowerSeries[T], b:T) = a -= @[(0, b)]

  proc `*`*[T](a:FormalPowerSeries[T], b:SparseFormalPowerSeries[T], deg = -1):FormalPowerSeries[T] =
    var deg = deg
    if deg == -1:
      let bdeg = b[^1][0]
      deg = a.len + bdeg
    result = initFormalPowerSeries[T](deg)
    for i in 0..<a.len:
      for (j, c) in b:
        let k = i + j
        if k < deg: result[k] += a[i] * c
  proc `*=`*[T](a:var SparseFormalPowerSeries[T], b:SparseFormalPowerSeries[T], deg = -1) =
    var r = initTable[int,T]()
    for (i, c0) in a:
      for (j, c1) in b:
        let k = i + j
        if deg != -1 and k >= deg: continue
        if k notin r: r[k] = T(0)
        r[k] += c0 * c1
    var rs = SparseFormalPowerSeries[T](r)
    swap(rs, a)
  proc `*=`*[T](a:var SparseFormalPowerSeries[T], b:T) =
    for (i, c) in a.mitems:
      c *= b

  macro declareSparseFormalPowerSeriesOperators(op) =
    fmt"""proc `{op}`*[T](self:SparseFormalPowerSeries[T];r:SparseFormalPowerSeries[T] or T):SparseFormalPowerSeries[T] = result = self;result {op}= r
proc `{op}`*[T](self: not SparseFormalPowerSeries and not SparseMonomial, r:SparseFormalPowerSeries[T]):SparseFormalPowerSeries[T] = result = @[(0, T(self))];result {op}= r""".parsestmt

  declareSparseFormalPowerSeriesOperators(`+`)
  declareSparseFormalPowerSeriesOperators(`-`)
  declareSparseFormalPowerSeriesOperators(`*`)

  proc divMod*[T](a: FormalPowerSeries[T], b:SparseFormalPowerSeries[T]):(FormalPowerSeries[T], FormalPowerSeries[T]) =
    var a = a
    let
      max_deg = b[^1][0]
      inv_max_coef = b[^1][1].inv
    var q = initFormalPowerSeries[T](a.len - max_deg)
    for i in countdown(q.len - 1, 0):
      q[i] = a[i + max_deg] * inv_max_coef
      for (d, v) in b:
        a[i + d] -= q[i] * v
    return (q, a[0..<max_deg])
  proc `div`*[T:FieldElem](a: FormalPowerSeries[T], b:SparseFormalPowerSeries[T]):auto = a.divMod(b)[0]
  proc `mod`*[T:FieldElem](a: FormalPowerSeries[T], b:SparseFormalPowerSeries[T]):auto = a.divMod(b)[1]
