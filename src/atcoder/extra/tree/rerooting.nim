when not declared ATCODER_REROOTING_HPP:
  const ATCODER_REROOTING_HPP* = 1
  import sequtils
  type
    Edge*[Weight, Data] = object
      to: int
      weight: Weight
      dp, ndp: Data
    ReRooting*[Weight, Data] = object
      g:seq[seq[Edge[Weight, Data]]]
      subdp*, dp*: seq[Data]
      ident: Data
      f_up: proc(d:Data,w:Weight):Data
      f_merge: proc(d0, d1: Data):Data
  
  proc initEdge*[Weight, Data](to:int, d: Weight, dp, ndp: Data):Edge[Weight, Data] = Edge[Weight, Data](to: to, weight: d, dp: dp, ndp: ndp)
  proc initReRooting*[Weight, Data](n:int, f_up:proc(d:Data,w:Weight):Data, f_merge:proc(d0, d1:Data):Data, ident:Data):ReRooting[Weight,Data] =
    return ReRooting[Weight,Data](
      g:newSeqWith(n, newSeq[Edge[Weight, Data]]()),
      subdp: newSeqWith(n, ident),
      dp: newSeqWith(n, ident),
      f_up:f_up, f_merge:f_merge, ident:ident)
  
  proc addEdge*[Weight, Data](self: var ReRooting[Weight, Data]; u,v:int, d:Weight) =
    self.g[u].add(initEdge[Weight, Data](v, d, self.ident, self.ident))
    self.g[v].add(initEdge[Weight, Data](u, d, self.ident, self.ident))
  proc addBiEdge*[Weight, Data](self: var ReRooting[Weight, Data]; u,v:int, d,e:Weight) =
    self.g[u].add(initEdge[Weight, Data](v, d, self.ident, self.ident))
    self.g[v].add(initEdge[Weight, Data](u, e, self.ident, self.ident))
  proc addBiEdge*[Weight, Data](self: var ReRooting[Weight, Data]; u,v:int, d:Weight) =
    self.g[u].add(initEdge[Weight, Data](v, d, self.ident, self.ident))
    self.g[v].add(initEdge[Weight, Data](u, d, self.ident, self.ident))

  proc dfs_sub*[Weight, Data](self: var ReRooting[Weight, Data]; idx, par:int) =
    for e in self.g[idx]:
      if e.to == par: continue
      self.dfs_sub(e.to, idx)
      self.subdp[idx] = self.f_merge(self.subdp[idx], self.f_up(self.subdp[e.to], e.weight))
  
  proc dfs_all*[Weight, Data](self: var ReRooting[Weight, Data]; idx, par:int, top:Data) =
    var buff = self.ident
    for i in 0..<self.g[idx].len:
      var e = self.g[idx][i].addr
      e[].ndp = buff
      e[].dp = self.f_up(if par == e.to: top else: self.subdp[e.to], e[].weight)
      buff = self.f_merge(buff, e[].dp)
    self.dp[idx] = buff
    buff = self.ident
    for i in countdown(self.g[idx].len - 1, 0):
      var e = self.g[idx][i].addr
      if e[].to != par:
        var tmp = self.f_merge(e[].ndp, buff)
        self.dfs_all(e[].to, idx, tmp)
      e[].ndp = self.f_merge(e[].ndp, buff)
      buff = self.f_merge(buff, e[].dp)
  
  proc solve*[Weight, Data](self: var ReRooting[Weight, Data]):seq[Data] =
    self.dfs_sub(0, -1)
    self.dfs_all(0, -1, self.ident)
    return self.dp
  
