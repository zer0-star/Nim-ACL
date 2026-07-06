# verify-helper: PROBLEM https://judge.yosupo.jp/problem/point_add_rectangle_sum

include atcoder/header
import atcoder/extra/structure/segtree_2d

let N, Q = nextInt()

var x, y, w = newSeq[int](N)
var v0: seq[(int, int)]

for i in 0 ..< N:
  x[i] = nextInt()
  y[i] = nextInt()
  w[i] = nextInt()
  v0.add (x[i], y[i])

var qv:seq[seq[int]]

for _ in 0 ..< Q:
  let t = nextInt()
  if t == 0:
    let x, y, w = nextInt()
    v0.add (x, y)
    qv.add @[t, x, y, w]
  else:
    let l, d, r, u = nextInt()
    qv.add @[t, l, d, r, u]

var st = initSegTree2D(v0, proc(a, b:int):int = a + b, proc():int = 0)

for i in 0 ..< N:
  st.add(x[i], y[i], w[i])

for v in qv:
  let t = v[0]
  if t == 0:
    let
      x = v[1]
      y = v[2]
      w = v[3]
    st.add(x, y, w)
  else:
    let
      l = v[1]
      d = v[2]
      r = v[3]
      u = v[4]
    echo st[l ..< r, d ..< u]


