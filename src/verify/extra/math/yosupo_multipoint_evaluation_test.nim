# verify-helper: PROBLEM https://judge.yosupo.jp/problem/multipoint_evaluation

include atcoder/header
import atcoder/modint
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series
import atcoder/extra/math/multipoint_evaluation
import sequtils, strutils

proc main():void =
  type mint = modint998244353
  let N, M = nextInt()
  var
    c = initFormalPowerSeries[mint](newSeqWith(N, nextInt()))
    p = newSeqWith(M, mint.init(nextInt()))
  echo multipointEvaluation(c, p).join(" ")

main()
