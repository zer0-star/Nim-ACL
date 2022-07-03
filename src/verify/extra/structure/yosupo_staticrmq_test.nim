# verify-helper: PROBLEM https://judge.yosupo.jp/problem/staticrmq

include atcoder/header
import atcoder/extra/other/internal_sugar
import atcoder/extra/structure/sparse_table

f(p, q:int) => min(p, q)
e() => int.inf

let N, Q = nextInt()
let a = newSeqWith(N, nextInt())

var st = initSparseTable(a, f, e)

for _ in 0..<Q:
  let l, r = nextInt()
  echo st[l..<r]
