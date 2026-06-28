# verify-helper: PROBLEM https://judge.yosupo.jp/problem/queue_operate_all_composite

import atcoder/header
import atcoder/extra/forward_compatibility/internal_sugar
import atcoder/extra/structure/sliding_window_aggregation

import atcoder/modint
type mint = modint998244353

f(p, q:(mint,mint)) => (q[0] + q[1] * p[0], q[1] * p[1])
e() => (mint(0), mint(1))

var swa = initSlidingWindowAggregation(f, e)

let Q = nextInt()
for _ in 0..<Q:
  let q = nextInt()
  if q == 0:
    let a, b = nextInt().mint
    swa.push((b, a))
  elif q == 1:
    swa.pop()
  else:
    let x = nextInt().mint
    let (b, a) = swa.fold_all()
    echo a * x + b

