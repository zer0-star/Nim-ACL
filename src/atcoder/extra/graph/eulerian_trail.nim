when not declared ATCODER_EULERIAN_TRAIL_HPP:
  const ATCODER_EULERIAN_TRAIL_HPP* = 1
  import std/sequtils, std/algorithm
  import atcoder/dsu
  type EulerianTrail*[directed:static[bool]] = object
    g:seq[seq[(int,int)]]
    es:seq[(int,int)]
    M:int
    used_vertex, used_edge:seq[bool]
    deg:seq[int]

  proc initEulerianTrail*(V:int, directed:static[bool]):auto =
    result = EulerianTrail[directed](
      g:newSeq[seq[(int,int)]](V), 
      M:0, deg:newSeq[int](V), 
      used_vertex:newSeqWith(V, false)
    )

  proc add_edge*(self:var EulerianTrail, a, b:int) =
    self.es.add((a, b))
    self.g[a].add((b, self.M))
    when self.directed:
      self.deg[a].inc
      self.deg[b].dec
    else:
      self.g[b].add((a, self.M))
      self.deg[a].inc
      self.deg[b].inc
    self.M.inc

  proc get_edge*(self:var EulerianTrail, idx:int):(int,int) = self.es[idx]

  proc go(self:var EulerianTrail, s:int):seq[int] =
    var
      st:seq[(int,int)]
      ord:seq[int]
    st.add((s, -1))
    while st.len > 0:
      let idx = st[^1][0]
      self.used_vertex[idx] = true
      if self.g[idx].len == 0:
        ord.add(st[^1][1])
        discard st.pop()
      else:
        let e = self.g[idx][^1]
        discard self.g[idx].pop()
        if self.used_edge[e[1]]: continue
        self.used_edge[e[1]] = true
        st.add(e)
    discard ord.pop()
    ord.reverse
    return ord

  proc enumerate_eulerian_trail*(self:var EulerianTrail):seq[seq[int]] =
    when self.directed:
      for p in self.deg:
        if p != 0: return @[]
    else:
      for p in self.deg:
        if p mod 2 != 0: return @[]
    self.used_edge = newSeqWith(self.M, false)
    result = newSeq[seq[int]]()
    for i in 0..<self.g.len:
      if self.g[i].len == 0 or self.used_vertex[i]: continue
      result.add(self.go(i))

  proc enumerate_semi_eulerian_trail*(self:var EulerianTrail):seq[seq[int]] =
    var uf = initDSU(self.g.len)
    for p in self.es: uf.merge(p[0], p[1])
    self.used_edge = newSeqWith(self.M, false)
    for vs in uf.groups():
      var
        latte = -1
        malta = -1
      when self.directed:
        for p in vs:
          if abs(self.deg[p]) > 1:
            return @[]
          elif self.deg[p] == 1:
            if latte >= 0: return @[]
            latte = p
      else:
        for p in vs:
          if self.deg[p] mod 2 != 0:
            if latte == -1: latte = p
            elif malta == -1: malta = p
            else: return @[]
      result.add(self.go(if latte == -1: vs[0] else: latte))
      if result[^1].len == 0: discard result.pop()
