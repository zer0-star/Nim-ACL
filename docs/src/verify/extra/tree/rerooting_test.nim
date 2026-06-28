# verify-helper: PROBLEM https://yukicoder.me/problems/no/1333

import atcoder/header
import atcoder/modint
import atcoder/extra/tree/rerooting

let N = nextInt()

type mint = modint1000000007
type Data = tuple[n, s, t:mint]
type Weight = mint

proc f_up(d:Data, u:int, w:Weight):Data =
  var (n, s, t) = d
  return (n + 1, s + w * n + w, t + 2 * s * w + w * w * n + w * w)
proc f_merge(d0, d1:Data):Data = (d0.n + d1.n, d0.s + d1.s, d0.t + d1.t)

var g = initRerooting[Data, Weight](N, f_up, f_merge, (mint(0), mint(0), mint(0)))

for _ in 0 ..< N - 1:
  var u, v, w = nextInt()
  u.dec;v.dec
  g.addBiEdge(u, v, w.mint)

g.solve()
var ans = mint(0)
for i in 0 ..< N:
  ans += g[i].t
#for i, (n, s, t) in d:
#  ans += t

echo ans / 2
