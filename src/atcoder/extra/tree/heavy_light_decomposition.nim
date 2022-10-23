when not declared ATCODER_HEAVY_LIGHT_DECOMPOSITION_HPP:
  import std/sugar
  import atcoder/extra/graph/graph_template
  type HeavyLightDecomposition[T] = object
    sz*, in_a*, out_a*, head*, rev*, par*, dep, heavy_child*:seq[int]
    heavy_path*, light_child*: seq[seq[int]]
  proc initHeavyLightDecomposition*[G:Graph](g:G, s = 0):HeavyLightDecomposition[G.T] =
    type T = G.T
    var
      sz, in_a, out_a, head, rev, par, dep, heavy_child = newSeq[int](g.len)
      heavy_path, light_child = newSeq[seq[int]](g.len)

    head[s] = s
    proc dfsSz(g:G, idx, p, d:int) =
      dep[idx] = d
      par[idx] = p
      sz[idx] = 1
      heavy_child[idx] = -1
      for e in g[idx]:
        if e.dst == p: continue
        g.dfsSz(e.dst, idx, d + 1)
        sz[idx] += sz[e.dst];
        if heavy_child[idx] == -1 or sz[heavy_child[idx]] < sz[e.dst]:
          heavy_child[idx] = e.dst

    proc dfsHld(g:G, idx, par:int, times:var int) =
      in_a[idx] = times
      times += 1
      rev[in_a[idx]] = idx
      heavy_path[head[idx]].add idx
      # heavy_index[idx]を先に回る
      var child:seq[int]
      if heavy_child[idx] != -1:
        child.add heavy_child[idx]
      for e in g[idx]:
        if e.dst == par or e.dst == heavy_child[idx]: continue
        light_child[idx].add e.dst
        child.add e.dst
      for c in child:
        head[c] = if heavy_child[idx] == c: head[idx] else: c
        g.dfsHld(c, idx, times)
      out_a[idx] = times

    g.dfsSz(s, -1, 0)
    var t = 0
    g.dfs_hld(s, -1, t)
    result = HeavyLightDecomposition[T](sz:sz.move, in_a:in_a.move, out_a:out_a.move, head:head.move, rev:rev.move, par:par.move, dep:dep.move,
      heavy_child:heavy_child.move, heavy_path:heavy_path.move, light_child:light_child.move)
  
  proc la*[T](self:HeavyLightDecomposition[T]; v, k:int):int =
    var (v, k) = (v, k)
    while true:
      let u = self.head[v]
      if self.in_a[v] - k >= self.in_a[u]: return self.rev[self.in_a[v] - k]
      k -= self.in_a[v] - self.in_a[u] + 1
      v = self.par[u]

  proc lca*[T](self:HeavyLightDecomposition[T]; u, v:int):int =
    var (u,v) = (u,v)
    while true:
      if self.in_a[u] > self.in_a[v]: swap(u, v)
      if self.head[u] == self.head[v]: return u
      v = self.par[self.head[v]]
  proc dist*[T](self: HeavyLightDecomposition[T], u, v:int):int =
    return self.dep[u] + self.dep[v] - 2 * self.dep[self.lca(u, v)]

  proc query*[T,U](self: HeavyLightDecomposition[T]; u, v:int, ti:U, q:(int, int)->U, f, s:(U,U)->U, edge = false):U =
    var
      (l,r) = (ti,ti)
      (u,v) = (u,v)
    while true:
      if self.in_a[u] > self.in_a[v]: swap(u, v); swap(l, r)
      if self.head[u] == self.head[v]: break
      l = f(q(self.in_a[self.head[v]], self.in_a[v] + 1), l)
      v = self.par[self.head[v]]
    return s(f(q(self.in_a[u] + edge.int, self.in_a[v] + 1), l), r)
  proc query*[T,U](self: HeavyLightDecomposition[T]; u, v:int, ti:U, q:(int, int)->U, f:(U,U)->U, edge = false):U = self.query(u, v, ti, q, f, f, edge)

  proc add*[T](self: HeavyLightDecomposition[T]; u, v:int, q:(int,int)->void, edge = false) =
    var (u,v) = (u,v)
    while true:
      if self.in_a[u] > self.in_a[v]: swap(u, v)
      if self.head[u] == self.head[v]: break
      q(self.in_a[self.head[v]], self.in_a[v] + 1)
      v = self.par[self.head[v]]
    q(self.in_a[u] + edge.int, self.in_a[v] + 1)

  proc get_heavy_path*[T](self:HeavyLightDecomposition[T], g:Graph, u:int):tuple[heavy:seq[int], light:seq[seq[int]]] =
    doAssert self.head[u] == u
    let h = self.head[u]
    var
      heavy = newSeq[int]()
      light = newSeq[seq[int]]()
    var u = u
    while true:
      heavy.add u
      var light_dst = newSeq[int]()
      for ei,e in g[u]:
        if e.dst == self.par[u] or ei == self.heavy_index[u]: continue
        light_dst.add e.dst
      light.add(light_dst)
      if self.heavy_index[u] == -1: break
      u = g[u][self.heavy_index[u]].dst
    return (heavy, light)

