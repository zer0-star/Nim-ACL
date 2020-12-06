when not declared ATCODER_HEAVY_LIGHT_DECOMPOSITION_HPP:
  import std/sugar
  import atcoder/extra/graph/graph_template
  type HeavyLightDecomposition[T] = object
    sz, in_a, out_a, head, rev, par:seq[int]
  
  proc initHeavyLightDecomposition*[T](g:Graph[T]):HeavyLightDecomposition[T] =
    var
      g = g
      sz, in_a, out_a, head, rev, par = newSeq[int](g.len)
    proc dfsSz(idx, p:int) =
      par[idx] = p
      sz[idx] = 1
      if g[idx].len > 0 and g[idx][0].dst == p: swap(g[idx][0].dst, g[idx][^1].dst)
      for e in g[idx].mitems:
        if e.dst == p: continue
        dfsSz(e.dst, idx)
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

    dfs_sz(0, -1)
    var t = 0
    dfs_hld(0, -1, t)
    return HeavyLightDecomposition[T](sz:sz, in_a:in_a, out_a:out_a, head:head, rev:rev, par:par)
  
  proc la*[T](self:HeavyLightDecomposition[T]; v, k:int):int =
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
  
  proc query*[T,U](self: HeavyLightDecomposition[T]; u, v:int, ti:U, q:(int, int)->U, f:(U,U)->U, edge:int = 0):U =
    var
      (l,r) = (ti,ti)
      (u,v) = (u,v)
    while true:
      if self.in_a[u] > self.in_a[v]: swap(u, v); swap(l, r)
      if self.head[u] == self.head[v]: break
      l = f(q(self.in_a[self.head[v]], self.in_a[v] + 1), l)
      v = self.par[self.head[v]]
    return f(f(q(self.in_a[u] + edge, self.in_a[v] + 1), l), r)

  proc add*[T,U](self: HeavyLightDecomposition[T]; u, v:int, q:(int,int)->U, edge:int = 0) =
    var (u,v) = (u,v)
    while true:
      if self.in_a[u] > self.in_a[v]: swap(u, v)
      if self.head[u] == self.head[v]: break
      q(self.in_a[self.head[v]], self.in_a[v] + 1)
      v = self.par[self.head[v]]
    q(self.in_a[u] + edge, self.in_a[v] + 1)
