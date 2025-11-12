# verify-helper: PROBLEM https://judge.yosupo.jp/problem/rational_approximation
import atcoder/header
import atcoder/extra/math/rational_approximation

let T = nextInt()

for _ in 0 ..< T:
  let
    N, x, y = nextInt()
    p = rational_approximation[int](N, x, y)
    (lnum, lden) = p[0]
    (rnum, rden) = p[1]
  echo lnum, " ", lden, " ", rnum, " ", rden
