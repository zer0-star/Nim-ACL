import atcoder/header
import atcoder/dsu

let n, q = nextInt()
var d = initDSU(n)
for i in 0..<q:
  let t, u, v = nextInt()
  if t == 0:
    d.merge(u, v)
  else:
    if d.same(u, v):
      echo 1
    else:
      echo 0

