# verify-helper: PROBLEM https://judge.yosupo.jp/problem/frequency_table_of_tree_distance

import atcoder/header
#import atcoder/modint
include atcoder/convolution
import atcoder/extra/graph/graph_template
import std/sequtils, std/strutils
import atcoder/extra/tree/centroid_decomposition

proc main():void =
  let N = nextInt()
  var g = initGraph(N)
  
  for _ in 0..<N-1:
    let a, b = nextInt()
    g.addBiEdge(a, b)
  
  let (c, tree) = g.centroidDecomposition()
  
  var
    used = newSeqWith(N, false)
    ans = newSeq[int](N)
  
  proc dfs(c:int) =
    used[c] = true
    for e in tree[c]: dfs(e.dst)
    used[c] = false
    proc dfs2(u:int, p = -1, h = 0, d:var seq[int]) =
      if h >= d.len:
        d.setLen(h + 1)
      d[h].inc
      for e in g[u]:
        if e.dst == p or used[e.dst]: continue
        dfs2(e.dst, u, h + 1, d)
    var base = newSeq[int]()
    for e in g[c]:
      if used[e.dst]: continue
      var d = newSeq[int]()
      dfs2(e.dst, c, 1, d)
      let t = convolution(base, d)
      for i, d in t: ans[i] += d
      if base.len < d.len: base.setLen(d.len)
      for i,d in d:ans[i] += d;base[i] += d

  dfs(c)
  echo ans[1..^1].join(" ")

main()
