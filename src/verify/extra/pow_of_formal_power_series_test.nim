# verify-helper: PROBLEM https://judge.yosupo.jp/problem/pow_of_formal_power_series

import atcoder/header, atcoder/modint
import atcoder/extra/math/internal_fft
import atcoder/extra/math/formal_power_series
import std/strutils

proc main():void =
  type mint = modint998244353
  let N, M = nextInt()
  var p = initFormalPowerSeries[mint](N)
  for i in 0..<N: p[i] = mint.init(nextInt())
  echo p.pow(M).join(" ")

main()
