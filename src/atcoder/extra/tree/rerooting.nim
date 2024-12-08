when not declared ATCODER_REROOTING_HPP:
  const ATCODER_REROOTING_HPP* = 1
  #import atcoder/extra/other/debug

  type ReRooting*[T, Weight] = object
    V:int
    f: proc(a:T, v:int, w:Weight):T
    g: proc(a:T, v:int):T
    merge: proc(a, b:T):T
    G:seq[seq[tuple[dst:int, weight:Weight]]]
    dp:seq[seq[T]]
  # dp_v = g(merge(f(dp_c1,c1), f(dp_c2,c2), ..., f(dp_ck,ck)), v)
    mi:T # identity of merge

  proc initReRootingImpl*[T, Weight](V:int, f:proc(a:T, v:int, w:Weight):T, merge:proc(a, b:T):T, mi:T, g:proc(a:T, v:int):T):ReRooting[T, Weight] =
    ReRooting[T, Weight](V:V, f:f, merge:merge, mi:mi, g:g, G:newSeq[seq[tuple[dst:int, weight:Weight]]](V), dp:newSeq[seq[T]](V))
  proc initReRooting*[T, Weight](V:int, f:proc(a:T, v:int, w:Weight):T, merge:proc(a, b:T):T, mi:T, g:proc(a:T, v:int):T):ReRooting[T, Weight] =
    initReRootingImpl[T, Weight](V, f, merge, mi, g)
  proc initReRooting*[T](V:int, f:proc(a:T, v:int):T, merge:proc(a, b:T):T, mi:T, g:proc(a:T, v:int):T):ReRooting[T, int] =
    proc f0(a:T, v:int, w:int):T = f(a, v)
    initReRootingImpl[T, int](V, f0, merge, mi, g)
  proc initReRooting*[T, Weight](V:int, f:proc(a:T, v:int, w:Weight):T, merge:proc(a, b:T):T, mi:T):ReRooting[T, Weight] =
    proc g(a:T, v:int):T = a
    initReRooting[T, Weight](V, f, merge, mi, g)
  proc initReRooting*[T](V:int, f:proc(a:T, v:int):T, merge:proc(a, b:T):T, mi:T):ReRooting[T, int] =
    proc f0(a:T, v:int, w:int):T = f(a, v)
    proc g0(a:T, v:int):T = a
    initReRootingImpl[T, int](V, f0, merge, mi, g0)

  #void read(int idx = 1) {
  #  int a, b;
  #  for (int i = 0; i < V - 1; ++i) {
  #    cin >> a >> b;
  #    a -= idx, b -= idx;
  #    G[a].emplace_back(b);
  #    G[b].emplace_back(a);
  #  }
  #}

  proc add_edge*[T, Weight](self: var ReRooting[T, Weight], a, b:int) =
    self.G[a].add((b, Weight.default))
    self.G[b].add((a, Weight.default))
  proc add_bi_edge*[T, Weight](self: var ReRooting[T, Weight], a, b:int, w:Weight) =
    self.G[a].add((b, w))
    self.G[b].add((a, w))
  proc add_bi_edge*[T, Weight](self: var ReRooting[T, Weight], a, b:int, w1, w2:Weight) =
    self.G[a].add((b, w1))
    self.G[b].add((a, w2))

  proc dfs1*[T, Weight](self:var ReRooting[T, Weight], p, v:int):T =
    var res = self.mi
    for i in 0 ..< self.G[v].len:
      let e = self.G[v][i]
      if e.dst == p: continue
      self.dp[v][i] = self.dfs1(v, e.dst)
      res = self.merge(res, self.f(self.dp[v][i], e.dst, e.weight))
    return self.g(res, v)

  proc dfs2*[T, Weight](self:var ReRooting[T, Weight], p, v:int, from_par:T) =
    for i in 0 ..< self.G[v].len:
      if self.G[v][i].dst == p:
        self.dp[v][i] = from_par
        break
    var pR = newSeq[T](self.G[v].len + 1)
    pR[self.G[v].len] = self.mi
    for i in countdown(self.G[v].len, 1):
      let e = self.G[v][i - 1]
      pR[i - 1] = self.merge(pR[i], self.f(self.dp[v][i - 1], e.dst, e.weight))
    var pL = self.mi
    for i in 0 ..< self.G[v].len:
      let e = self.G[v][i]
      if e.dst != p:
        let val = self.merge(pL, pR[i + 1])
        self.dfs2(v, e.dst, self.g(val, v))
      pL = self.merge(pL, self.f(self.dp[v][i], e.dst, e.weight))

  proc solve*[T, Weight](self: var ReRooting[T, Weight], root = 0) =
    for i in 0 ..< self.V:
      self.dp[i].setLen(self.G[i].len)
    discard self.dfs1(-1, root)
    self.dfs2(-1, root, self.mi)

  proc `[]`*[T, Weight](self: ReRooting[T, Weight], v:int):T =
    var ans = self.mi
    for i in 0 ..< self.G[v].len:
      let e = self.G[v][i]
      ans = self.merge(ans, self.f(self.dp[v][i], e.dst, e.weight))
    return self.g(ans, v)
