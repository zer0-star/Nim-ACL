when not declared ATCODER_MULTIPOINT_EVALUATION_FAST_HPP:
  const ATCODER_MULTIPOINT_EVALUATION_FAST_HPP* = 1
  import atcoder/extra/math/formal_power_series
  import atcoder/extra/math/subproduct_tree
  proc multipointEvaluation*[T](f: FormalPowerSeries[T], xs: seq[T]): seq[T] =
    var
      g = subproduct_tree(xs)
      m = xs.len
      k = g.len div 2
    g[1] = f mod g[1]
    for i in 2 ..< k + m: g[i] = g[i shr 1] mod g[i]
    var ys = initFormalPowerSeries[T](m)
    for i in 0 ..< m:
      ys[i] = if g[k + i].len == 0: T(0) else: g[k + i][0]
    return ys

