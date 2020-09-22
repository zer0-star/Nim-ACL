import atcoder/header
import atcoder/segtree
import sequtils, sugar

let n, q = nextInt()
let a = newSeqWith(n, nextInt())
var target:int
proc f(v:int):bool = v < target
var seg = initSegTree[int](a, (a:int,b:int)=>max(a, b), () => -1)

for i in 0..<q:
  let t = nextInt()
  if t == 1:
    var x, v = nextInt()
    x.dec
    seg.set(x, v);
  elif t == 2:
    var l, r = nextInt()
    l.dec
    echo seg.prod(l..<r)
  elif t == 3:
    let p = nextInt() - 1
    target = nextInt()
    echo seg.max_right(p, f) + 1
