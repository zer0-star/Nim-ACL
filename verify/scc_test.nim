# verify-helper: PROBLEM https://judge.yosupo.jp/problem/scc

include src/nim_acl/header
include src/nim_acl/scc
include src/nim_acl/extra/graph/topological_sort

import sequtils, strutils, sugar

block:
  let N, M = nextInt()
  var
    es = newSeq[Edge[int]]()
    scc = initSccGraph(N)
  for i in 0..<M:
    let a, b = nextInt()
    scc.add_edge(a, b)
    es.add(initEdge(a, b))
  var a = scc.scc()
  var id = newSeq[int](N)
  for i,v in a:
    for u in v:
      id[u] = i
  var h = initGraph[int](a.len)
  for e in es:
    let (x, y) = (id[e.src], id[e.dst])
    if x == y: continue
    h.addEdge(x, y)
  let t = h.topologicalSort()
  echo t.len
  for t in t:
    echo a[t].len, " ", a[t].join(" ")
