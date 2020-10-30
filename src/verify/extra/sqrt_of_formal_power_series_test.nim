# verify-helper: PROBLEM https://judge.yosupo.jp/problem/sqrt_of_formal_power_series

import atcoder/header, atcoder/modint
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series
import atcoder/extra/math/formal_power_series_sqrt
import std/strutils, std/options

proc main():void =
  type mint = modint998244353
  let N = nextInt()
  var p = initFormalPowerSeries[mint](N)
  for i in 0..<N:
    p[i] = mint(nextInt())
  let q = p.sqrt()
  echo if q.isSome: q.get.join(" ") else: "-1"

main()
