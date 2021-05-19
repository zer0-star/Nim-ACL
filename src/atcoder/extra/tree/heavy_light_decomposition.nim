when not declared ATCODER_HEAVY_LIGHT_DECOMPOSITION_HPP:
  import std/sugar
  import atcoder/extra/graph/graph_template
  type HeavyLightDecomposition[T] = object
    sz*, in_a, out_a, head, rev, par, dep*:seq[int]
  proc initHeavyLightDecomposition*[G:Graph](g:G, s = 0):HeavyLightDecomposition[G.T] =
    type T = G.T
    var
      g = g
      sz, in_a, out_a, head, rev, par, dep = newSeq[int](g.len)
    head[s] = s
    proc dfsSz(idx, p, d:int) =
      dep[idx] = d
      par[idx] = p
      sz[idx] = 1
      if g[idx].len > 0 and g[idx][0].dst == p: swap(g[idx][0].dst, g[idx][^1].dst)
      for e in g[idx].mitems:
        if e.dst == p: continue
        dfsSz(e.dst, idx, d + 1)
        sz[idx] += sz[e.dst];
        if sz[g[idx][0].dst] < sz[e.dst]:
          swap(g[idx][0].dst, e.dst)

    proc dfsHld(idx, par:int, times:var int) =
      in_a[idx] = times
      times += 1
      rev[in_a[idx]] = idx;
      for e in g[idx]:
        if e.dst == par: continue
        head[e.dst] = if g[idx][0].dst == e.dst: head[idx] else: e.dst
        dfsHld(e.dst, idx, times)
      out_a[idx] = times

    dfsSz(s, -1, 0)
    var t = 0
    dfs_hld(s, -1, t)
    result = HeavyLightDecomposition[T](sz:sz, in_a:in_a, out_a:out_a, head:head, rev:rev, par:par, dep:dep)
  
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
