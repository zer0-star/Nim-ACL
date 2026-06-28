when not declared ATCODER_SUBPRODUCT_TREE_HPP:
  import std/sequtils
  import atcoder/extra/math/formal_power_series
  const ATCODER_SUBPRODUCT_TREE_HPP* = 1
  proc subproduct_tree*[T](xs: FormalPowerSeries[T]): seq[FormalPowerSeries[T]] =
    let n = xs.len
    var k = 1
    while k < n: k = k shl 1
    var g = newSeqWith(2 * k, initFormalPowerSeries[T](@[1]))
    for i in 0 ..< n: g[k + i] = @[-xs[i], T(1)]
    var i = k
    while true:
      if not (i > 1): break
      i.dec
      g[i] = g[i shl 1] * g[(i shl 1) or 1]
    #for (int i = k; i-- > 1;) g[i] = g[i << 1] * g[i << 1 | 1];
    return g
  
