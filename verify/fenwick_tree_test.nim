# verify-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum

import atcoder/header
import atcoder/fenwicktree

import std/sequtils

let N, Q = nextInt()
let a = newSeqWith(N, nextInt())

var st = initFenwickTree[int](N)

for i in 0..<N: st.add(i, a[i])
for _ in 0 ..< Q:
  let t = nextInt()
  if t == 0:
    let p, x = nextInt()
    st.add(p, x)
  else:
    let l, r = nextInt()
    echo st.sum(l..<r)
