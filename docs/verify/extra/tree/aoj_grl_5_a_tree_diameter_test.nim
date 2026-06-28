# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_5_A

include atcoder/header
import atcoder/extra/graph/graph_template
import atcoder/extra/tree/tree_diameter

proc main() =
  let N = nextInt()
  var g = initGraph(N)
  for i in 1..<N:
    let x, y, z = nextInt()
    g.addBiEdge(x,y,z)
  echo g.treeDiameter()[0]

main()
