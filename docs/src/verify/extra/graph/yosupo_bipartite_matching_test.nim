# verify-helper: PROBLEM https://judge.yosupo.jp/problem/bipartitematching

include atcoder/header
import atcoder/extra/graph/hopcroft_karp

proc main() =
  let L, R, M = nextInt()
  var g = initHopcroftKarp(L, R)
  for i in 0..<M:
    let u, v = nextInt()
    g.addEdge(u, v)
  
  let p = g.maximum_matching()
  echo p.len
  for p in p:
    echo p[0], " ", p[1]

main()
