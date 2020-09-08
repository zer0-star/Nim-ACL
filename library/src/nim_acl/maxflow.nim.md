---
layout: default
---

<!-- mathjax config similar to math.stackexchange -->
<script type="text/javascript" async
  src="https://cdnjs.cloudflare.com/ajax/libs/mathjax/2.7.5/MathJax.js?config=TeX-MML-AM_CHTML">
</script>
<script type="text/x-mathjax-config">
  MathJax.Hub.Config({
    TeX: { equationNumbers: { autoNumber: "AMS" }},
    tex2jax: {
      inlineMath: [ ['$','$'] ],
      processEscapes: true
    },
    "HTML-CSS": { matchFontHeight: false },
    displayAlign: "left",
    displayIndent: "2em"
  });
</script>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/jquery-balloon-js@1.1.2/jquery.balloon.min.js" integrity="sha256-ZEYs9VrgAeNuPvs15E39OsyOJaIkXEEt10fzxJ20+2I=" crossorigin="anonymous"></script>
<script type="text/javascript" src="../../../assets/js/copy-button.js"></script>
<link rel="stylesheet" href="../../../assets/css/copy-button.css" />


# :warning: src/nim_acl/maxflow.nim

<a href="../../../index.html">Back to top page</a>

* category: <a href="../../../index.html#9445bba494c2e7790206eaaedbe1a4db">src/nim_acl</a>
* <a href="{{ site.github.repository_url }}/blob/master/src/nim_acl/maxflow.nim">View this file on GitHub</a>
    - Last commit date: 2020-09-09 01:13:51+09:00




## Code

<a id="unbundled"></a>
{% raw %}
```cpp
when not defined ATCODER_MAXFLOW_HPP:
  const ATCODER_MAXFLOW_HPP = 1
  
  import internal_queue
  import algorithm, sequtils
  #include <algorithm>
  # TODO?
  #include <atcoder/internal_queue>
  
  #include <cassert>
  #include <limits>
  #include <queue>
  #include <vector>
  type edge[Cap] = object
    dst, rev:int
    cap:Cap
  
  type mf_graph[Cap] = object
    n:int
    pos:seq[(int,int)]
    g:seq[seq[edge[Cap]]]
  
  proc init_mf_graph[Cap](n:int):auto = mf_graph[Cap](n:n, g:newSeq[seq[edge[Cap]]](n))
  
  proc add_edge[Cap](self: var mf_graph[Cap], src, dst:int, cap:Cap):int {.discardable.}=
    assert src in 0..<self.n
    assert dst in 0..<self.n
    assert 0 <= cap
    let m = self.pos.len
    self.pos.add((src, self.g[src].len))
    self.g[src].add(edge[Cap](dst:dst, rev:self.g[dst].len, cap:cap))
    self.g[dst].add(edge[Cap](dst:src, rev:self.g[src].len - 1, cap:0))
    return m
  
  type edge_info[Cap] = object
    src, dst:int
    cap, flow:Cap
  
  proc get_edge[Cap](self: mf_graph[Cap], i:int):edge_info[Cap] =
    let m = self.pos.len
    assert i in 0..<m
    let e = self.g[self.pos[i][0]][self.pos[i][1]]
    let re = self.g[e.dst][e.rev]
    return edge_info[Cap](src:pos[i][0], dst:e.to, cap:e.cap + re.cap, flow:re.cap)

  proc edges[Cap](self: mf_graph[Cap]):seq[edge_info] =
    let m = self.pos.len
    result = newSeqOfCap[edge_info](m)
    for i in 0..<m:
      result.add(get_edge(i))

  proc change_edge[Cap](self: var mf_graph[Cap], i:int, new_cap, new_flow:Cap) =
    let m = self.pos.len
    assert i in 0..<m
    assert new_flow in 0..new_cap
    var e = self.g[self.pos[i][0]][self.pos[i][1]].addr
    var re = self.g[e[].dst][e[].rev].addr
    e[].cap = new_cap - new_flow
    re[].cap = new_flow


  proc flow[Cap](self: var mf_graph[Cap], s, t:int, flow_limit:Cap):Cap =
    assert s in 0..<self.n
    assert t in 0..<self.n
  
    var level, iter = newSeq[int](self.n)
    var que = init_simple_queue[int]()
#    internal::simple_queue<int> que;
  
    proc bfs(self: mf_graph[Cap]) =
      level.fill(-1)
      level[s] = 0
      que.clear()
      que.push(s)
      while not que.empty():
        let v = que.front()
        que.pop()
        for e in self.g[v]:
          if e.cap == 0 or level[e.dst] >= 0: continue
          level[e.dst] = level[v] + 1
          if e.dst == t: return
          que.push(e.dst)
    proc dfs(self: var mf_graph[Cap], v:int, up:Cap):Cap =
      if v == s: return up
      result = Cap(0)
      let level_v = level[v]
      var i = iter[v].addr
      while i[] < self.g[v].len:
        let e = self.g[v][i[]]
        if level_v <= level[e.dst] or self.g[e.dst][e.rev].cap == 0: continue
        let d = self.dfs(e.dst, min(up - result, self.g[e.dst][e.rev].cap))
        if d <= 0: continue
        self.g[v][i[]].cap += d
        self.g[e.dst][e.rev].cap -= d
        result += d
        if result == up: break
        i[].inc

    var flow = Cap(0)
    while flow < flow_limit:
      self.bfs()
      if level[t] == -1: break
      iter.fill(0)
      while flow < flow_limit:
        let f = self.dfs(t, flow_limit - flow)
        if f == Cap(0): break
        flow += f
    return flow

  proc flow[Cap](self: var mf_graph[Cap], s,t:int):auto = self.flow(s, t, Cap.high)

  proc min_cut[Cap](self:mf_graph[Cap], s:int):seq[bool] =
    var visited = newSeq[bool](self.n)
    var que = init_simple_queue[int]()
    que.push(s)
    while not que.empty():
      let p = que.front()
      que.pop()
      visited[p] = true
      for e in self.g[p]:
        if e.cap != Cap(0) and not visited[e.dst]:
          visited[e.dst] = true
          que.push(e.dst)
    return visited

var graph = init_mf_graph[int](10)
graph.flow(0, 3)

```
{% endraw %}

<a id="bundled"></a>
{% raw %}
```cpp
Traceback (most recent call last):
  File "/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/docs.py", line 349, in write_contents
    bundled_code = language.bundle(self.file_class.file_path, basedir=pathlib.Path.cwd())
  File "/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py", line 86, in bundle
    raise NotImplementedError
NotImplementedError

```
{% endraw %}

<a href="../../../index.html">Back to top page</a>

