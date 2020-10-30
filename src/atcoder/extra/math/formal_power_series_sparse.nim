when not declared ATCODER_FORMAL_POWER_SERIES_SPARSE_HPP:
  const ATCODER_FORMAL_POWER_SERIES_SPARSE_HPP* = 1
  import std/sequtils, std/tables
  import atcoder/element_concepts
  import atcoder/extra/math/formal_power_series
  type SparseFormalPowerSeries*[T:FieldElem] = seq[(int, T)] # sorted ascending order

  proc multRaw*[T:FieldElem](a:FormalPowerSeries[T], b:openArray[(int, T)], deg = -1):FormalPowerSeries[T] =
    var deg = deg
    if deg == -1:
      let bdeg = b[^1][0]
      deg = a.len + bdeg
    result = initFormalPowerSeries[T](deg)
    for i in 0..<a.len:
      for (j, c) in b:
        let k = i + j
        if k < deg: result[k] += a[i] * c
  proc multRaw*[T:FieldElem](a, b:openArray[(int, T)], deg = -1):SparseFormalPowerSeries[T] =
    var r = initTable[int,T]()
    for (i, c0) in a:
      for (j, c1) in b:
        let k = i + j
        if deg != -1 and k >= deg: continue
        if k notin r: r[k] = T(0)
        r[k] += c0 * c1
    return toSeq(r.pairs)
  proc divModRaw*[T:FieldElem](a: FormalPowerSeries[T], b:openArray[(int, T)]):(FormalPowerSeries[T], FormalPowerSeries[T]) =
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
  proc divRaw*[T:FieldElem](a: FormalPowerSeries[T], b:openArray[(int, T)]):auto = a.divModRaw(b)[0]
  proc modRaw*[T:FieldElem](a: FormalPowerSeries[T], b:openArray[(int, T)]):auto = a.divModRaw(b)[1]
