# verify-helper: PROBLEM https://judge.yosupo.jp/problem/tree_diameter

include atcoder/header
import atcoder/extra/graph/graph_template
import atcoder/extra/tree/tree_diameter

proc main() =
  let N = nextInt()
  var g = initGraph[int](N)
  for i in 1..<N:
    let x, y, z = nextInt()
    g.addBiEdge(x,y,z)
  let (d, a) = g.treeDiameter()
  echo d, " ", a.len
  echo a.mapIt($it).join(" ")

main()
