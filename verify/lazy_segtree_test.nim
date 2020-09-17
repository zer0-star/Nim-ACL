# verify-helper: PROBLEM https://judge.yosupo.jp/problem/range_affine_range_sum

include atcoder/modint
import atcoder/header, atcoder/lazysegtree

import std/sequtils

const Mod = 998244353
type mint = StaticModInt[Mod]
let n, q = nextInt()
let a = newSeqWith(n, (mint(nextInt()), 1))

type S = tuple[a:mint, size:int]
type F = tuple[a:mint, b:mint]

proc op(l, r:S):S = (l.a + r.a, l.size + r.size)
proc e():S = (mint(0), 0)
proc mapping(l:F, r:S):S = (r.a * l.a + r.size * l.b, r.size)
proc composition(l, r:F):F = (r.a * l.a, r.b * l.a + l.b)
proc id():F = (mint(1), mint(0))

var seg = init_lazy_segtree(a, op, e, mapping, composition, id)

for i in 0..<q:
  let t = nextInt()
  if t == 0:
    let l, r, c, d = nextInt()
    seg.apply(l..<r, (mint(c), mint(d)))
  else:
    let l, r = nextInt()
    echo seg.prod(l..<r)[0]
