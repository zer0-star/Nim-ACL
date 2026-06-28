when not declared ATCODER_EXTRA_HOPCROFT_KARP:
  const ATCODER_EXTRA_HOPCROFT_KARP* = 1
  import std/sequtils, std/deques
  import std/options

  type HopcroftKarp* = object
    n, m:int
    graph: seq[seq[int]]
    dist, match: seq[int]
    used, vv:seq[bool]
    maximum_matching_result, minimum_edge_cover_result: Option[seq[(int, int)]]
    minimum_vertex_cover_result, maximum_stable_set_result: Option[(seq[int], seq[int])]

  proc initHopcroftKarp*(n, m:int): HopcroftKarp =
    HopcroftKarp(n:n, m:m, graph:newSeq[seq[int]](n), match:newSeqWith(m, -1), used: newSeq[bool](n))

  proc add_edge*(self: var HopcroftKarp, u, v:int) = self.graph[u].add(v)

  proc maximum_matching*(self: var HopcroftKarp):seq[(int,int)] =
    if self.maximum_matching_result.isSome: return self.maximum_matching_result.get
    proc bfs(self: var HopcroftKarp) =
      self.dist = newSeqWith(self.n, -1)
      var que = initDeque[int]()
      for i in 0..<self.n:
        if not self.used[i]:
          que.addLast(i)
          self.dist[i] = 0

      while que.len != 0:
        let a = que.popFirst()
        for b in self.graph[a]:
          let c = self.match[b]
          if c >= 0 and self.dist[c] == -1:
            self.dist[c] = self.dist[a] + 1
            que.addLast(c)

    proc dfs(self: var HopcroftKarp, a:int):bool =
      self.vv[a] = true
      for b in self.graph[a]:
        let c = self.match[b]
        if c < 0 or (not self.vv[c] and self.dist[c] == self.dist[a] + 1 and self.dfs(c)):
          self.match[b] = a
          self.used[a] = true
          return true
      return false

    while true:
      self.bfs()
      self.vv = newSeqWith(self.n, false)
      var flow = 0
      for i in 0..<self.n:
        if not self.used[i] and self.dfs(i): flow.inc
      if flow == 0: break

    for i in 0..<self.match.len:
      if self.match[i] != -1:
        result.add((self.match[i], i))
    self.maximum_matching_result = result.some

  proc minimum_vertex_cover*(self: var HopcroftKarp):(seq[int], seq[int]) =
    if self.minimum_vertex_cover_result.isSome(): return self.minimum_vertex_cover_result.get
    if not self.maximum_matching_result.isSome(): discard self.maximum_matching()
    var colorL = newSeqWith(self.n, 0)
    var colorR = newSeqWith(self.m, 0)
    var matched = newSeqWith(self.n, false)
    proc dfs(self: HopcroftKarp, u:int) =
      if colorL[u] == 1: return
      colorL[u] = 1
      for v in self.graph[u]:
        if self.match[v] != -1 and self.match[v] == u: continue
        colorR[v] = 1
        if self.match[v] != -1:
          self.dfs(self.match[v])
    for (l,r) in self.maximum_matching_result.get():
      matched[l] = true
    for u in 0..<self.n:
      if not matched[u]:
        self.dfs(u)
    for u in 0..<self.n:
      if colorL[u] == 0: result[0].add u
    for u in 0..<self.m:
      if colorR[u] == 1: result[1].add u
    self.minimum_vertex_cover_result = result.some

  proc maximum_stable_set*(self: var HopcroftKarp):(seq[int], seq[int]) =
    if self.maximum_stable_set_result.isSome: return self.maximum_stable_set_result.get
    if not self.minimum_vertex_cover_result.isSome(): discard self.minimum_vertex_cover()
    block:
      var s = self.minimum_vertex_cover_result.get[0]
      for u in 0..<self.n:
        if u notin s: result[0].add u
    block:
      var s = self.minimum_vertex_cover_result.get[1]
      for u in 0..<self.m:
        if u notin s: result[1].add u
  # 未テスト
  proc minimum_edge_cover*(self: var HopcroftKarp):seq[(int, int)] =
    if self.minimum_edge_cover_result.isSome(): return self.minimum_edge_cover_result.get
    if not self.maximum_matching_result.isSome(): discard self.maximum_matching()
    var
      matchedL = newSeqWith(self.n, false)
      addedL = newSeqWith(self.n, false)
      matchedR = newSeqWith(self.m, false)
      addedR = newSeqWith(self.m, false)
    for (l, r) in self.maximum_matching_result.get():
      matchedL[l] = true
      matchedR[r] = true
    result = self.maximum_matching_result.get()
    for u in 0 ..< self.n:
      for v in self.graph[u]:
        if not matchedL[u] and not addedL[u]:
          doAssert matchedR[v]
          result.add (u, v)
          addedL[u] = true
        if not matchedR[v] and not addedR[v]:
          doAssert matchedL[u]
          result.add (u, v)
          addedR[v] = true
