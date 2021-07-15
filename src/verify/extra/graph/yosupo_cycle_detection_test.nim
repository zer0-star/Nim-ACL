# verify-helper: PROBLEM https://judge.yosupo.jp/problem/cycle_detection

include atcoder/header

import atcoder/extra/other/internal_sugar
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/cycle_detection
import std/options, std/sequtils

proc main() =
  let N, M = nextInt()
  var g = initGraph(N)

  for i in 0..<M:
    var
      u = nextInt()
      v = nextInt()
    g.addEdge(u, v, i)
  
  let c = g.cycle_detection()
  if c.isSome:
    let c = c.get
    echo c.len
    let v = collect(newSeq):
      for e in c:
        e.weight
    echo v.join("\n")
  else:
    echo -1

main()
