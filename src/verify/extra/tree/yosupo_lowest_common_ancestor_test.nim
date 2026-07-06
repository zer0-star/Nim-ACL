# verify-helper: PROBLEM https://judge.yosupo.jp/problem/lca

include atcoder/header
import atcoder/extra/graph/graph_template

import atcoder/extra/tree/doubling_lowest_common_ancestor

proc main() =
  let N, Q = nextInt()
  var g = initGraph(N)
  for i in 1..<N:
    let p = nextInt()
    g.addBiEdge(i, p)
  let lca = initDoublingLowestCommonAncestor(g, 0)
  for i in 0..<Q:
    let x, y = nextInt()
    echo lca.lca(x, y)

main()
