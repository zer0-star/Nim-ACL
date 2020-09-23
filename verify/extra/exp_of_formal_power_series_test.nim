# verify-helper: PROBLEM https://judge.yosupo.jp/problem/exp_of_formal_power_series

import atcoder/header
import atcoder/modint
import atcoder/extra/math/formal_power_series
import std/strutils

proc main():void =
  type mint = modint998244353
  let N = nextInt()
  var p = initFormalPowerSeries[mint](N)
  for i in 0..<N:
    p[i] = mint.init(nextInt())
  let q = p.exp()
  echo q.join(" ")

main()
