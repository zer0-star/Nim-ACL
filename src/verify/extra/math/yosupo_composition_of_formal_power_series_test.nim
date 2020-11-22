# verify-helper: PROBLEM https://judge.yosupo.jp/problem/composition_of_formal_power_series

const Mod = 998244353

include atcoder/header
import atcoder/modint
import atcoder/extra/math/ntt
import atcoder/extra/math/formal_power_series
import atcoder/extra/math/composition

type mint = modint998244353

proc main():void =
  let
    N = nextInt()
    a = newSeqWith(N, mint(nextInt()))
    b = newSeqWith(N, mint(nextInt()))
  echo composition(b, a).join(" ")

main()
