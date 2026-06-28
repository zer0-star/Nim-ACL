---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import macros\nmacro Please(x): untyped = nnkStmtList.newTree()\n\nPlease\
    \ use Nim-ACL\nPlease use Nim-ACL\nPlease use Nim-ACL\n\n\nwhen not declared ATCODER_MAXFLOW_LOWERBOUND_HPP:\n\
    \  const ATCODER_MAXFLOW_LOWERBOUND_HPP* = 1\n  #[ import atcoder/maxflow ]#\n\
    \  when not declared ATCODER_MAXFLOW_HPP:\n    const ATCODER_MAXFLOW_HPP* = 1\n\
    \    \n    #[ import atcoder/internal_queue ]#\n    when not declared ATCODER_INTERNAL_QUEUE_HPP:\n\
    \      const ATCODER_INTERNAL_QUEUE_HPP* = 1\n    \n      type simple_queue[T]\
    \ = object\n        payload:seq[T]\n        pos:int\n      proc init_simple_queue*[T]():auto\
    \ = simple_queue[T](payload:newSeq[T](), pos:0)\n    # TODO\n    #      void reserve(int\
    \ n) { payload.reserve(n); }\n      proc len*[T](self:simple_queue[T]):int = self.payload.len\
    \ - self.pos\n      proc empty*[T](self:simple_queue[T]):bool = self.pos == self.payload.len\n\
    \      proc push*[T](self:var simple_queue[T], t:T) = self.payload.add(t)\n  \
    \    proc front*[T](self:simple_queue[T]):T = self.payload[self.pos]\n      proc\
    \ clear*[T](self:var simple_queue[T]) =\n        self.payload.setLen(0)\n    \
    \    self.pos = 0;\n      proc pop*[T](self:var simple_queue[T]) = self.pos.inc\n\
    \      discard\n    import std/algorithm\n  \n    type MFInternalEdge[Cap] = object\n\
    \      dst, rev:int\n      cap:Cap\n    \n    type MFGraph*[Cap] = object\n  \
    \    len*:int\n      pos:seq[(int,int)]\n      g:seq[seq[MFInternalEdge[Cap]]]\n\
    \    \n    proc init_mf_graph*[Cap](n:int):auto = MFGraph[Cap](len:n, g:newSeq[seq[MFInternalEdge[Cap]]](n))\n\
    \    proc initMaxFlow*[Cap](n:int):auto = MFGraph[Cap](len:n, g:newSeq[seq[MFInternalEdge[Cap]]](n))\n\
    \    \n    proc add_edge*[Cap](self: var MFGraph[Cap], src, dst:int, cap:Cap):int\
    \ {.discardable.}=\n      assert src in 0..<self.len\n      assert dst in 0..<self.len\n\
    \      assert 0.Cap <= cap\n      let m = self.pos.len\n      self.pos.add((src,\
    \ self.g[src].len))\n      var src_id = self.g[src].len\n      var dst_id = self.g[dst].len\n\
    \      if src == dst: dst_id.inc\n      self.g[src].add(MFInternalEdge[Cap](dst:dst,\
    \ rev:dst_id, cap:cap))\n      self.g[dst].add(MFInternalEdge[Cap](dst:src, rev:src_id,\
    \ cap:0))\n      return m\n    \n    type MFEdge*[Cap] = object\n      src*, dst*:int\n\
    \      cap*, flow*:Cap\n    \n    proc get_edge*[Cap](self: MFGraph[Cap], i:int):MFEdge[Cap]\
    \ =\n      let m = self.pos.len\n      assert i in 0..<m\n      let e = self.g[self.pos[i][0]][self.pos[i][1]]\n\
    \      let re = self.g[e.dst][e.rev]\n      return MFEdge[Cap](src:self.pos[i][0],\
    \ dst:e.dst, cap:e.cap + re.cap, flow:re.cap)\n  \n    proc edges*[Cap](self:\
    \ MFGraph[Cap]):seq[MFEdge[Cap]] =\n      let m = self.pos.len\n      result =\
    \ newSeqOfCap[MFEdge[Cap]](m)\n      for i in 0..<m:\n        result.add(self.get_edge(i))\n\
    \  \n    proc change_edge*[Cap](self: var MFGraph[Cap], i:int, new_cap, new_flow:Cap)\
    \ =\n      let m = self.pos.len\n      assert i in 0..<m\n      assert new_flow\
    \ in 0..new_cap\n      var e = self.g[self.pos[i][0]][self.pos[i][1]].addr\n \
    \     var re = self.g[e[].dst][e[].rev].addr\n      e[].cap = new_cap - new_flow\n\
    \      re[].cap = new_flow\n  \n    proc flow*[Cap](self: var MFGraph[Cap], s,\
    \ t:int, flow_limit:Cap):Cap =\n      assert s in 0..<self.len\n      assert t\
    \ in 0..<self.len\n      assert s != t\n    \n      var level, iter = newSeq[int](self.len)\n\
    \      var que = init_simple_queue[int]()\n  #    internal::simple_queue<int>\
    \ que;\n    \n      proc bfs(self: MFGraph[Cap]) =\n        level.fill(-1)\n \
    \       level[s] = 0\n        que.clear()\n        que.push(s)\n        while\
    \ not que.empty():\n          let v = que.front()\n          que.pop()\n     \
    \     for e in self.g[v]:\n            if e.cap == 0 or level[e.dst] >= 0: continue\n\
    \            level[e.dst] = level[v] + 1\n            if e.dst == t: return\n\
    \            que.push(e.dst)\n      proc dfs(self: var MFGraph[Cap], v:int, up:Cap):Cap\
    \ =\n        if v == s: return up\n        result = Cap(0)\n        let level_v\
    \ = level[v]\n        var i = iter[v].addr\n        while i[] < self.g[v].len:\n\
    \          let e = self.g[v][i[]].addr\n          if level_v <= level[e[].dst]\
    \ or self.g[e[].dst][e[].rev].cap == 0:\n            i[].inc\n            continue\n\
    \          let d = self.dfs(e.dst, min(up - result, self.g[e[].dst][e[].rev].cap))\n\
    \          if d <= 0:\n            i[].inc\n            continue\n          self.g[v][i[]].cap\
    \ += d\n          self.g[e[].dst][e[].rev].cap -= d\n          result += d\n \
    \         if result == up: return\n          i[].inc\n        level[v] = self.len\n\
    \  \n      var flow = Cap(0)\n      while flow < flow_limit:\n        self.bfs()\n\
    \        if level[t] == -1: break\n        iter.fill(0)\n        let f = self.dfs(t,\
    \ flow_limit - flow)\n        if f == Cap(0): break\n        flow += f\n     \
    \ return flow\n  \n    proc flow*[Cap](self: var MFGraph[Cap], s,t:int):auto =\
    \ self.flow(s, t, Cap.high)\n  \n    proc min_cut*[Cap](self:MFGraph[Cap], s:int):seq[bool]\
    \ =\n      var visited = newSeq[bool](self.len)\n      var que = init_simple_queue[int]()\n\
    \      que.push(s)\n      while not que.empty():\n        let p = que.front()\n\
    \        que.pop()\n        visited[p] = true\n        for e in self.g[p]:\n \
    \         if e.cap != Cap(0) and not visited[e.dst]:\n            visited[e.dst]\
    \ = true\n            que.push(e.dst)\n      return visited\n    discard\n  import\
    \ std/options\n  \n  type MaxFlowLowerBound*[Cap] = object\n    flow: MFGraph[Cap]\n\
    \    in_cap, up_cap: seq[Cap]\n    #typename F< flow_t >::edge *latte, *malta;\n\
    \    #latte, malta:int\n    X, Y, V:int\n    sum:Cap\n  \n  proc initMaxFlowLowerBound*[Cap](V:int):MaxFlowLowerBound[Cap]\
    \ =\n    MaxFlowLowerBound[Cap](V:V, flow:initMFGraph[Cap](V + 2), X:V, Y:V +\
    \ 1, sum:Cap(0), in_cap:newSeq[Cap](V))\n  \n  proc add_edge*[Cap](self: var MaxFlowLowerBound[Cap],\
    \ src, dst:int, low, high: Cap) =\n    doAssert src != dst\n    self.flow.add_edge(src,\
    \ dst, high - low)\n    self.in_cap[src] -= low\n    self.in_cap[dst] += low\n\
    \    self.up_cap.add(high)\n  \n  proc build*[Cap](self: var MaxFlowLowerBound[Cap])\
    \ =\n    for i in 0..<self.V:\n      if self.in_cap[i] > 0:\n        self.flow.add_edge(self.X,\
    \ i, self.in_cap[i]) # TODO: cost\u76F4\u3059\n        self.sum += self.in_cap[i]\n\
    \      elif self.in_cap[i] < 0:\n        self.flow.add_edge(i, self.Y, -self.in_cap[i])\n\
    \  \n  proc can_flow*[Cap](self: var MaxFlowLowerBound[Cap]):bool =\n    self.build()\n\
    \    var ret = self.flow.flow(self.X, self.Y)\n    echo \"base: \", ret\n    return\
    \ ret.cap >= self.sum\n  \n  proc can_flow*[Cap](self: var MaxFlowLowerBound[Cap],\
    \ s, t:int):bool =\n    assert s != t\n    self.flow.add_edge(t, s, Cap.high div\
    \ 10, 0)\n    #self.latte = &flow.graph[t].back()\n    #self.malta = &flow.graph[s].back()\n\
    \    return self.can_flow()\n  \n  proc max_flow*[Cap](self: var MaxFlowLowerBound[Cap],\
    \ s, t:int):Option[Cap] =\n    if self.can_flow(s, t):\n#      self.flow.reset\n\
    \      return self.flow.flow(s, t).some\n    else:\n      return result.T.none\n\
    \  \n  proc slope*[Cap](self: var MaxFlowLowerBound[Cap], s, t:int):Option[seq[Cap]]\
    \ =\n    if self.can_flow(s, t):\n#      self.flow.reset\n  #    return self.flow.slope(s,\
    \ t).some\n      return self.flow.slope(s, t).some\n    else:\n      return result.T.none\n\
    \  \n  \n  #flow_t min_flow(int s, int t) {\n  #  if(can_flow(s, t)) {\n  #  \
    \  auto ret = flow.INF - latte->cap;\n  #    latte->cap = malta->cap = 0;\n  #\
    \    return ret - flow.max_flow(t, s);\n  #  } else {\n  #    return -1;\n  #\
    \  }\n  #}\n  #\n  #void output(int M) {\n  #  vector< flow_t > ans(M);\n  # \
    \ for(int i = 0; i < flow.graph.size(); i++) {\n  #    for(auto &e : flow.graph[i])\
    \ {\n  #      if(!e.isrev && ~e.idx) ans[e.idx] = up[e.idx] - e.cap;\n  #    }\n\
    \  #  }\n  #  for(auto &p : ans) cout << p << endl;\n  #}\n  \nvar g = initMaxFlowLowerBound[int](3)\n\
    g.addEdge(0, 1, 1, 2)\ng.addEdge(1, 2, 2, 3)\necho g.slope(0, 2)\n\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/graph/combined.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/combined.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/combined.nim
- /library/atcoder/extra/graph/combined.nim.html
title: atcoder/extra/graph/combined.nim
---
