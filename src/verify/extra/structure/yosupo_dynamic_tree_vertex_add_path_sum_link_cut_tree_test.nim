# verify-helper: PROBLEM https://judge.yosupo.jp/problem/dynamic_tree_vertex_add_path_sum

include atcoder/header

import atcoder/extra/structure/link_cut_tree

block:
  let N, Q = nextInt()

  proc add0(a, b:int):int = a + b
  var lct = initLinkCutTree(add0, 0)
  type Node = lct.splay_tree.Node

  var A = newSeqWith(N, nextInt())

  var vs = newSeq[Node](N)
  for i in 0..<N:
    vs[i] = lct.alloc(A[i])

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
        let P, X = nextInt()
        lct.expose(vs[P])
        vs[P].key += X
      else:
        let U, V = nextInt()
        lct.evert(vs[U])
        lct.expose(vs[V])
        echo vs[V].sum
