# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_2_B

include atcoder/header
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/chu_liu_edmonds
import std/options

proc main() =
  var
    V, E, R = nextInt()
    edges = newSeq[Edge[int]]()
  for i in 0..<E:
    let a, b, c = nextInt()
    edges.add(initEdge(a,b,c))
  var t = minimumSpanningTreeArborescence[int](edges, V, R)
  echo t.get[0]

main()
