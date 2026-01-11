# verify-helper: PROBLEM https://judge.yosupo.jp/problem/frequency_table_of_tree_distance

import atcoder/header
include atcoder/convolution
import atcoder/extra/graph/graph_template
import std/sequtils, std/strutils
import atcoder/extra/tree/centroid_decomposition
import std/deques

when isMainModule:
  let N = nextInt()
  var g = initGraph(N)

  for _ in 0..<N-1:
    let a, b = nextInt()
    g.addBiEdge(a, b)

  let (root, tree) = g.centroidDecomposition()

  var
    used = newSeqWith(N, false)
    dist = newSeq[int](N)

  proc MFP(centroid:int) =
    used[centroid] = true
    var cnt = @[1]
    for e in g[centroid]:
      let ch = e.dst
      if used[ch]: continue
      var
        num = newSeq[int]()
        que = initDeque[tuple[idx, par, dep: int]]()
      que.addLast((ch, centroid, 1))
      while que.len > 0:
        let (idx, par, dep) = que.popFirst()
        #if cnt.len <= dep: cnt.setLen(dep + 1)
        #if num.len <= dep: num.setLen(dep + 1)
        while cnt.len <= dep: cnt.add 0
        while num.len <= dep: num.add 0
        cnt[dep].inc
        num[dep].inc
        for e in g[idx]:
          let to = e.dst
          if to == par or used[to]: continue
          que.addLast((to, idx, dep + 1))
      var ret = convolution_ll(num, num)
      if ret.len > N: ret.setLen(N)
      for i in 0 ..< ret.len: dist[i] -= ret[i]
    var ret = convolution_ll(cnt, cnt)
    if ret.len > N: ret.setLen(N)
    for i in 0 ..< ret.len: dist[i] += ret[i]
    for e in tree[centroid]: MFP(e.dst)
  MFP(root)
  dist = dist[1 .. ^1]
  for p in dist.mitems:
    p = p div 2
  echo dist.join(" ")

#
#
#
## verify-helper: PROBLEM https://judge.yosupo.jp/problem/frequency_table_of_tree_distance
#
#import atcoder/header
##import atcoder/modint
#include atcoder/convolution
#import atcoder/extra/graph/graph_template
#import std/sequtils, std/strutils
#import atcoder/extra/tree/centroid_decomposition
#
#proc main():void =
#  let N = nextInt()
#  var g = initGraph(N)
#  
#  for _ in 0..<N-1:
#    let a, b = nextInt()
#    g.addBiEdge(a, b)
#  
#  let (c, tree) = g.centroidDecomposition()
#  
#  var
#    used = newSeqWith(N, false)
#    ans = newSeq[int](N)
#  
#  proc dfs(c:int) =
#    used[c] = true
#    for e in tree[c]: dfs(e.dst)
#    used[c] = false
#    proc dfs2(u:int, p = -1, h = 0, d:var seq[int]) =
#      if h >= d.len:
#        d.setLen(h + 1)
#      d[h].inc
#      for e in g[u]:
#        if e.dst == p or used[e.dst]: continue
#        dfs2(e.dst, u, h + 1, d)
#    var base = newSeq[int]()
#    for e in g[c]:
#      if used[e.dst]: continue
#      var d = newSeq[int]()
#      dfs2(e.dst, c, 1, d)
#      let t = convolution(base, d)
#      for i, d in t: ans[i] += d
#      if base.len < d.len: base.setLen(d.len)
#      for i,d in d:ans[i] += d;base[i] += d
#
#  dfs(c)
#  echo ans[1..^1].join(" ")
#
#main()
