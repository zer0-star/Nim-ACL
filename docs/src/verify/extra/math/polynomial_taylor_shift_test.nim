# verify-helper: PROBLEM https://judge.yosupo.jp/problem/polynomial_taylor_shift

import atcoder/header
import atcoder/modint
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series
import atcoder/extra/math/polynomial_taylor_shift
import std/strutils, std/sequtils

proc main():void =
  type mint = modint998244353
  let N, c = nextInt()
  var a = initFormalPowerSeries[mint](newSeqWith(N, mint.init(nextInt())))
  let b = a.taylor_shift(c)
  echo b.join(" ")

main()
