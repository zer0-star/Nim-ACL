import atcoder/header
import atcoder/fenwicktree

let n, q = nextInt()
var fw = init_fenwick_tree[int](n)

for i in 0..<n:
  let a = nextInt()
  fw.add(i, a)

for i in 0..<q:
  let t = nextInt()
  if t == 0:
    let p, x = nextInt()
    fw.add(p, x)
  else:
    let l, r = nextInt()
    echo fw.sum(l..<r)
