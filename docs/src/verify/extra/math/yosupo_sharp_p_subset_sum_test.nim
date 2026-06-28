# verify-helper: PROBLEM https://judge.yosupo.jp/problem/sharp_p_subset_sum

include atcoder/header
import atcoder/modint
type mint = modint998244353
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series

proc main():void =
  let N, T = nextInt()
  var ct = newSeq[int](T + 1)
  for i in 0..<N: ct[nextInt()].inc
  var p = initFormalPowerSeries[mint](T + 1)
  for A in 1..T:
    var sgn = 1
    for j in 1..T:
      let jA = j * A
      if jA > T: break
      p[jA] += mint(ct[A]) / j * sgn
      sgn = -sgn
  let q = p.exp()[1..T]
  echo q.join(" ")

main()
