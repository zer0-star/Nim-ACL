# verify-helper: PROBLEM https://judge.yosupo.jp/problem/range_affine_range_sum
import atcoder/header, atcoder/modint
import std/sequtils

import atcoder/extra/structure/splay_tree

type mint = modint998244353
let n, q = nextInt()
let a = newSeqWith(n, (mint(nextInt()), 1))

type S = tuple[a:mint, size:int]
type F = tuple[a:mint, b:mint]

proc op(l, r:S):S = (l.a + r.a, l.size + r.size)
proc e():S = (mint(0), 0)
proc mapping(l:F, r:S):S = (r.a * l.a + r.size * l.b, r.size)
proc composition(l, r:F):F = (r.a * l.a, r.b * l.a + l.b)
proc id():F = (mint(1), mint(0))

var seg = init_lazy_splay_tree(op, mapping, composition, e(), id())
seg.build(a)

for i in 0..<q:
  let t = nextInt()
  if t == 0:
    let l, r, c, d = nextInt()
    seg.apply(l..<r, (mint(c), mint(d)))
  else:
    let l, r = nextInt()
    echo seg.prod(l..<r)[0]
