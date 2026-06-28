# verify-helper: PROBLEM https://judge.yosupo.jp/problem/directedmst

import atcoder/header
import atcoder/extra/graph/graph_template
import atcoder/extra/graph/chu_liu_edmonds
import std/options, std/sequtils, std/strutils

proc main() =
  var
    N, M, S = nextInt()
    edges = newSeq[Edge[int, int]]()
  for i in 0..<M:
    let a, b, c = nextInt()
    edges.add(initEdge(a,b,c))
  let (s, parent) = minimumSpanningTreeArborescence[int](edges, N, S).get
  echo s
  echo parent.mapIt($it).join(" ")

main()
