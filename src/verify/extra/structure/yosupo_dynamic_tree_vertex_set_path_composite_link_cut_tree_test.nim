# verify-helper: PROBLEM https://judge.yosupo.jp/problem/dynamic_tree_vertex_set_path_composite

include atcoder/header

import atcoder/extra/structure/splay_tree
import atcoder/extra/structure/link_cut_tree

import atcoder/modint

type mint = modint998244353

block:
  let N, Q = nextInt()

  type pii = ((mint,mint),(mint,mint))
  proc f(x,y:(mint, mint)):auto = return (x[0] * y[0], x[1] * y[0] + y[1])
  proc ff(a, b:pii):auto = (f(a[0], b[0]), f(b[1], a[1]))
  proc flip(a:((mint,mint), (mint,mint))):auto = (a[1], a[0])
  var lct = initLinkCutTree(ff, flip, ((mint(0), mint(0)), (mint(0), (mint(0)))))

  type ST = lct.splay_tree.type
  type Node = ST.Node
  var vs = newSeq[Node](N)
  for i in 0..<N:
    let x, y = nextInt().mint
    vs[i] = lct.alloc(((x, y), (x, y)))
  for i in 1..<N:
    let a, b = nextInt()
    lct.evert(vs[a])
    lct.link(vs[a], vs[b])

  for _ in 0..<Q:
    let T = nextInt()
    case T:
      of 0:
        let U, V, W, X = nextInt()
        lct.evert(vs[U])
        lct.cut(vs[V])
        lct.evert(vs[W])
        lct.link(vs[W], vs[X])
      of 1:
        let P = nextInt()
        let a, b = nextInt().mint
        lct.expose(vs[P])
        vs[P].key = ((a, b), (a, b))
#        lct.update(vs[P]);
      else:
        let U, V = nextInt()
        let X = nextInt().mint
        lct.evert(vs[U])
        lct.expose(vs[V])
        let ret = vs[V].sum[0]
        echo ret[0] * X + ret[1]
