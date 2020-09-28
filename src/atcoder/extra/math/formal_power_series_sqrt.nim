when not declared ATCODER_FORMAL_POWER_SERIES_SQRT:
  const ATCODER_FORMAL_POWER_SERIES_SQRT* = 1
  import atcoder/extra/math/formal_power_series
  import atcoder/extra/math/mod_sqrt
  import std/options

  proc sqrt*[T](self: FormalPowerSeries[T], deg = -1):Option[FormalPowerSeries[T]] =
    let n = self.len
    deg.revise(n)
    if self[0] == 0:
      for i in 1..<n:
        if self[i] != 0:
          if (i and 1) > 0: return FormalPowerSeries[T].none
          if deg - i div 2 <= 0: break
          var opt = (self shr i).sqrt(deg - i div 2)
          if not opt.isSome: return FormalPowerSeries[T].none
          var ret = opt.get shl (i div 2)
          if ret.len < deg: ret.setlen(deg)
          return ret.some
      return initFormalPowerSeries[T](deg).some
  
    var ret:FormalPowerSeries[T]
#    if self.isSetSqrt:
    let opt = modSqrt(self[0])
    if not opt.isSome: return FormalPowerSeries[T].none
    ret = initFormalPowerSeries[T](@[T(opt.get)])
#    else:
#      assert(self[0] == 1)
#      ret = initFormalPowerSeries[T](@[T(1)])
  
    let inv2 = T(1) / T(2)
    var i = 1
    while i < deg:
      ret = (ret + self.pre(i shl 1) * ret.inv(i shl 1)) * inv2
      i = i shl 1
    return ret.pre(deg).some


