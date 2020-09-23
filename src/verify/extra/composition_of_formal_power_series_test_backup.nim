# verify-helper: PROBLEM https://judge.yosupo.jp/problem/composition_of_formal_power_series

import atcoder/header, atcoder/modint
import atcoder/extra/math/formal_power_series
import std/sequtils, std/strutils

proc main():void =
  type mint = modint998244353
  type FPS = FormalPowerSeries[mint]
  let
    N = nextInt()
    a = FPS.init(newSeqWith(N, mint(nextInt())))
    b = FPS.init(newSeqWith(N, mint(nextInt())))
  echo composition(b, a).join(" ")

main()
