when not declared ATCODER_EXTRA_NEWTON_METHOD_HPP:
  const ATCODER_EXTRA_NEWTON_METHOD_HPP* = 1
  import atcoder/extra/math/formal_power_series
  proc newtonMethod*[mint](calc_g: proc(F:FormalPowerSeries[mint], d:int):tuple[g, dgdf: FormalPowerSeries[mint]], f0:mint, deg:int):FormalPowerSeries[mint] =
    type fps = FormalPowerSeries[mint]
    proc newtonMethodImpl(f0:fps, deg:int):fps =
      assert f0.len > 0
      if deg <= f0.len: return f0.pre(deg)
      var f = newtonMethodImpl(f0, (deg + 1) div 2)
      let extra = 10
      var
        offset = 0
        (g, dgdf) = calc_g(f, deg + extra)
      while offset < dgdf.len and dgdf[offset] == 0: offset.inc
      assert offset <= extra
      dgdf = dgdf shr offset
      g = g shr offset
      return (f - g * dgdf.inv()).pre(deg)
    # G(f) = 0 mod x^{deg} を満たす f を返す
    # f0 : 初期解, 非空な fps か mint を入れる
    # g : (g(f), g'(f)) を返す
    var f0 = initFormalPowerSeries[mint](@[f0])
    return newtonMethodImpl(f0, deg)
