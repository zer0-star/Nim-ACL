# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=GRL_3_C

include atcoder/header
import atcoder/scc

proc main() =
  let V, E = nextInt()
  var g = initSCCGraph(V)
  for i in 0..<E:
    let a,b = nextInt()
    g.addEdge(a,b)
  let scc = g.scc()
  var belongs = newSeq[int](V)
  for i in 0..<scc.len:
    for v in scc[i]:
      belongs[v] = i
  let Q = nextInt()
  for i in 0..<Q:
    let a,b = nextInt()
    echo if belongs[a] == belongs[b]: 1 else: 0

main()
