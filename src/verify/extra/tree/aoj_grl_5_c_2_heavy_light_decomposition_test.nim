# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_5_C

include atcoder/header
import atcoder/extra/graph/graph_template
import atcoder/extra/tree/heavy_light_decomposition

proc main() =
  let N = nextInt()
  var g = initGraph[int](N)
  for i in 0..<N:
    let k = nextInt()
    for j in 0..<k:
      let c = nextInt()
      g.addBiEdge(i, c)
  let tree = initHeavyLightDecomposition(g)
  let Q = nextInt()
  for i in 0..<Q:
    let u, v = nextInt()
    echo tree.lca(u, v)

main()
