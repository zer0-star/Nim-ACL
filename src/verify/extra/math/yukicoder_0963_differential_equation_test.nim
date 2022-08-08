# verify-helper: PROBLEM https://yukicoder.me/problems/no/963

include atcoder/header

import atcoder/modint
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series
import atcoder/extra/math/formal_power_series_differential_equation

useStaticModInt(mint, 1012924417)

type fps = FormalPowerSeries[mint]

block solve:
  var N = nextInt()
  proc g(f:fps, deg:int):fps =
    return ((f * f + 1) * mint(2).inv()).pre(deg)
  proc gp(f:fps, deg:int):fps = f.pre(deg)
  var f = DifferentialEquation(g, gp, mint(1), N + 1)
  for i in 1 .. N: f[N] *= mint(i)
  echo f[N] * 2
