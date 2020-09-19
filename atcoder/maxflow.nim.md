---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  - icon: ':warning:'
    path: atcoder/internal_queue.nim
    title: atcoder/internal_queue.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_MAXFLOW_HPP:\n  const ATCODER_MAXFLOW_HPP* = 1\n\
    \  \n  import atcoder/internal_queue\n  import std/algorithm\n\n  type edge[Cap]\
    \ = object\n    dst, rev:int\n    cap:Cap\n  \n  type mf_graph[Cap] = object\n\
    \    n:int\n    pos:seq[(int,int)]\n    g:seq[seq[edge[Cap]]]\n  \n  proc init_mf_graph*[Cap](n:int):auto\
    \ = mf_graph[Cap](n:n, g:newSeq[seq[edge[Cap]]](n))\n  \n  proc add_edge*[Cap](self:\
    \ var mf_graph[Cap], src, dst:int, cap:Cap):int {.discardable.}=\n    assert src\
    \ in 0..<self.n\n    assert dst in 0..<self.n\n    assert 0 <= cap\n    let m\
    \ = self.pos.len\n    self.pos.add((src, self.g[src].len))\n    self.g[src].add(edge[Cap](dst:dst,\
    \ rev:self.g[dst].len, cap:cap))\n    self.g[dst].add(edge[Cap](dst:src, rev:self.g[src].len\
    \ - 1, cap:0))\n    return m\n  \n  type edge_info[Cap] = object\n    src*, dst*:int\n\
    \    cap*, flow*:Cap\n  \n  proc get_edge*[Cap](self: mf_graph[Cap], i:int):edge_info[Cap]\
    \ =\n    let m = self.pos.len\n    assert i in 0..<m\n    let e = self.g[self.pos[i][0]][self.pos[i][1]]\n\
    \    let re = self.g[e.dst][e.rev]\n    return edge_info[Cap](src:self.pos[i][0],\
    \ dst:e.dst, cap:e.cap + re.cap, flow:re.cap)\n\n  proc edges*[Cap](self: mf_graph[Cap]):seq[edge_info[Cap]]\
    \ =\n    let m = self.pos.len\n    result = newSeqOfCap[edge_info[Cap]](m)\n \
    \   for i in 0..<m:\n      result.add(self.get_edge(i))\n\n  proc change_edge*[Cap](self:\
    \ var mf_graph[Cap], i:int, new_cap, new_flow:Cap) =\n    let m = self.pos.len\n\
    \    assert i in 0..<m\n    assert new_flow in 0..new_cap\n    var e = self.g[self.pos[i][0]][self.pos[i][1]].addr\n\
    \    var re = self.g[e[].dst][e[].rev].addr\n    e[].cap = new_cap - new_flow\n\
    \    re[].cap = new_flow\n\n\n  proc flow*[Cap](self: var mf_graph[Cap], s, t:int,\
    \ flow_limit:Cap):Cap =\n    assert s in 0..<self.n\n    assert t in 0..<self.n\n\
    \  \n    var level, iter = newSeq[int](self.n)\n    var que = init_simple_queue[int]()\n\
    #    internal::simple_queue<int> que;\n  \n    proc bfs(self: mf_graph[Cap]) =\n\
    \      level.fill(-1)\n      level[s] = 0\n      que.clear()\n      que.push(s)\n\
    \      while not que.empty():\n        let v = que.front()\n        que.pop()\n\
    \        for e in self.g[v]:\n          if e.cap == 0 or level[e.dst] >= 0: continue\n\
    \          level[e.dst] = level[v] + 1\n          if e.dst == t: return\n    \
    \      que.push(e.dst)\n    proc dfs(self: var mf_graph[Cap], v:int, up:Cap):Cap\
    \ =\n      if v == s: return up\n      result = Cap(0)\n      let level_v = level[v]\n\
    \      var i = iter[v].addr\n      while i[] < self.g[v].len:\n        let e =\
    \ self.g[v][i[]].addr\n        if level_v <= level[e[].dst] or self.g[e[].dst][e[].rev].cap\
    \ == 0:\n          i[].inc\n          continue\n        let d = self.dfs(e.dst,\
    \ min(up - result, self.g[e[].dst][e[].rev].cap))\n        if d <= 0:\n      \
    \    i[].inc\n          continue\n        self.g[v][i[]].cap += d\n        self.g[e[].dst][e[].rev].cap\
    \ -= d\n        result += d\n        if result == up: break\n        i[].inc\n\
    \n    var flow = Cap(0)\n    while flow < flow_limit:\n      self.bfs()\n    \
    \  if level[t] == -1: break\n      iter.fill(0)\n      while flow < flow_limit:\n\
    \        let f = self.dfs(t, flow_limit - flow)\n        if f == Cap(0): break\n\
    \        flow += f\n    return flow\n\n  proc flow*[Cap](self: var mf_graph[Cap],\
    \ s,t:int):auto = self.flow(s, t, Cap.high)\n\n  proc min_cut*[Cap](self:mf_graph[Cap],\
    \ s:int):seq[bool] =\n    var visited = newSeq[bool](self.n)\n    var que = init_simple_queue[int]()\n\
    \    que.push(s)\n    while not que.empty():\n      let p = que.front()\n    \
    \  que.pop()\n      visited[p] = true\n      for e in self.g[p]:\n        if e.cap\
    \ != Cap(0) and not visited[e.dst]:\n          visited[e.dst] = true\n       \
    \   que.push(e.dst)\n    return visited\n"
  dependsOn:
  - atcoder/internal_queue.nim
  - atcoder/internal_queue.nim
  isVerificationFile: false
  path: atcoder/maxflow.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/maxflow.nim
layout: document
redirect_from:
- /library/atcoder/maxflow.nim
- /library/atcoder/maxflow.nim.html
title: atcoder/maxflow.nim
---
