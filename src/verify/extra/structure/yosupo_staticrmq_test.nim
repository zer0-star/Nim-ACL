# verify-helper: PROBLEM https://judge.yosupo.jp/problem/staticrmq

include atcoder/header
import atcoder/extra/structure/sparse_table

proc f(p, q:int):int = min(p, q)
proc e():int = int.inf

let N, Q = nextInt()
let a = newSeqWith(N, nextInt())

var st = initSparseTable(a, f, e)

for _ in 0..<Q:
  let l, r = nextInt()
  echo st[l..<r]
