# verify-helper: PROBLEM https://judge.yosupo.jp/problem/kth_term_of_linearly_recurrent_sequence

import atcoder/header
import atcoder/modint
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series
import atcoder/extra/math/coef_of_generating_function
import std/sequtils

proc main():void =
  type mint = modint998244353
  let d, k = nextInt()
  var a0 = newSeqWith(d, nextInt())
  var c = newSeqWith(d, nextInt())
  var a = initFormalPowerSeries[mint](a0)
  var Q = initFormalPowerSeries[mint](d + 1)
  Q[0] = 1
  for i in 0..<d: Q[i + 1] -= c[i]
  var P = (a * Q)[0..<d]
  echo (P // Q)[k]

main()
