# verify-helper: PROBLEM https://judge.yosupo.jp/problem/binomial_coefficient

import atcoder/header
import atcoder/extra/math/arbitrary_mod_combination

let T, m = nextInt()

let Bin = initArbitraryModBinomial(m)

for _ in 0 ..< T:
  let n, k = nextInt()
  echo Bin.C(n, k)
