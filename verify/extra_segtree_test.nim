# verify-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_range_sum

import atcoder/header
import atcoder/extra/structure/universal_segtree

import std/sequtils, std/sugar

let N, Q = nextInt()
let a = newSeqWith(N, nextInt())

var st = initSegTree[int](a, (x: int, y: int)=>x+y, ()=>0)

for _ in 0 ..< Q:
  let t = nextInt()
  if t == 0:
    let p, x = nextInt()
    let a = st.get(p)
    st.set(p, a + x)
  else:
    let l, r = nextInt()
    echo st.prod(l..<r)
