when not declared ATCODER_DIFFERENTIAL_EQUATION_HPP:
  const ATCODER_DIFFERENTIAL_EQUATION_HPP* = 1
  import atcoder/extra/math/formal_power_series

  # find f, saitsfying equation f' = g(f) mod x ^ deg
  proc DifferentialEquation*[T](g, gprime:proc(f: FormalPowerSeries[T], n:int):FormalPowerSeries[T], f0:T, deg:int):FormalPowerSeries[T] =
    var
      f = initFormalPowerSeries[T](@[f0])
      i = 1
    while i < deg:
      var 
        r = (-gprime(f, i shl 1)).integral().exp(i shl 1)
        h = ((g(f, i shl 1) - gprime(f, i shl 1) * f) * r).pre(i shl 1).integral()
      f = ((h + f0) * r.inv(i shl 1)).pre(i shl 1)
      i = i shl 1
    return f.pre(deg)
