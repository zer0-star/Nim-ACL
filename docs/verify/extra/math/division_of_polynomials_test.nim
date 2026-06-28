# verify-helper: PROBLEM https://judge.yosupo.jp/problem/division_of_polynomials

include atcoder/header
import atcoder/modint
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series

block main:
  type mint = modint998244353
  let N, M = nextInt()
  var a = newSeqWith(N, nextInt())
  var b = newSeqWith(M, nextInt())
  var f = initFormalPowerSeries[mint](a)
  var g = initFormalPowerSeries[mint](b)
  var q = f div g
  var r = f mod g
  while q.len > 0 and q[^1] == 0: discard q.pop
  while r.len > 0 and r[^1] == 0: discard r.pop
  echo q.len, " ", r.len
  echo q.join(" ")
  echo r.join(" ")
