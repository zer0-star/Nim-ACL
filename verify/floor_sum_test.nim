# verify-helper: PROBLEM https://judge.yosupo.jp/problem/sum_of_floor_of_linear

import src/nim_acl/header, src/nim_acl/math

let T = nextInt()

for _ in 0..<T:
  let N, M, A, B = nextInt()
  echo floor_sum(N, M, A, B)
