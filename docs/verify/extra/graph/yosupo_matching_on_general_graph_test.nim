# verify-helper: PROBLEM https://judge.yosupo.jp/problem/general_matching

include atcoder/header
import atcoder/extra/graph/gabow_edmonds

proc main() =
  let N, M = nextInt()
  var g = initGabowEdmonds(N)
  for i in 0..<M:
    let u, v = nextInt()
    g.addEdge(u, v)
  
  let p = g.maxMatching()
  echo p.len
  for p in p:
    echo p[0], " ", p[1]

main()
