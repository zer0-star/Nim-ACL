# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_B

include atcoder/header
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/lowlink

proc main() =
  let V, E = nextInt()
  var g = initGraph(V)
  for i in 0..<E:
    let x,y = nextInt()
    g.addBiEdge(x,y)
  var lowlink = LowLink(g)
  lowlink.bridge.sort()
  for p in lowlink.bridge: echo p[0], " ", p[1]

main()
