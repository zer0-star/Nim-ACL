when not declared ATCODER_GABOW_EDMONS_HPP:
  const ATCODER_GABOW_EDMONS_HPP* = 1
  import deques, sequtils
  
  type edge = object
    to, idx:int
  
  type GabowEdmonds = object
    g:seq[seq[edge]]
    edges:seq[(int,int)]
    mate, label, first: seq[int]
    que:Deque[int]
  
  proc initGabowEdmonds*(n:int):GabowEdmonds =
    return GabowEdmonds(g:newSeq[seq[edge]](n + 1), mate: newSeq[int](n + 1), label: newSeqWith(n + 1, -1), first: newSeq[int](n + 1), que:initDeque[int]())
  
  proc add_edge*(self: var GabowEdmonds; u, v:int) =
    var
      u = u + 1
      v = v + 1
    self.g[u].add(edge(to:v, idx:self.edges.len + self.g.len))
    self.g[v].add(edge(to:u, idx:self.edges.len + self.g.len))
    self.edges.add((u, v))
  
  proc find(self: var GabowEdmonds, x:int):int =
    if self.label[self.first[x]] < 0: return self.first[x]
    self.first[x] = self.find(self.first[x])
    return self.first[x]
  
  proc rematch(self: var GabowEdmonds, v,w:int) =
    let t = self.mate[v]
    self.mate[v] = w
    if self.mate[t] != v: return
    if self.label[v] < self.g.len:
      self.mate[t] = self.label[v]
      self.rematch(self.label[v], t)
    else:
      let
        p = self.edges[self.label[v] - self.g.len]
        (x, y) = p
      self.rematch(x, y)
      self.rematch(y, x)
  
  proc assignLabel(self: var GabowEdmonds, x,y,num:int) =
    var r = self.find(x)
    var s = self.find(y)
    var join = 0;
    if r == s: return
    self.label[r] = -num
    self.label[s] = -num
    while true:
      if s != 0: swap(r, s)
      r = self.find(self.label[self.mate[r]])
      if self.label[r] == -num:
        join = r
        break
      self.label[r] = -num
    var v = self.first[x]
    while v != join:
      self.que.addLast(v)
      self.label[v] = num
      self.first[v] = join
      v = self.first[self.label[self.mate[v]]]
    v = self.first[y]
    while v != join:
      self.que.addLast(v)
      self.label[v] = num
      self.first[v] = join
      v = self.first[self.label[self.mate[v]]]
  
  proc augmentCheck(self: var GabowEdmonds, u:int):bool =
    self.que = initDeque[int]()
    self.first[u] = 0
    self.label[u] = 0
    self.que.addLast(u)
    while self.que.len > 0:
      let x = self.que.popFirst()
      for e in self.g[x]:
        let y = e.to
        if self.mate[y] == 0 and y != u:
          self.mate[y] = x
          self.rematch(x, y)
          return true
        elif self.label[y] >= 0:
          self.assignLabel(x, y, e.idx)
        elif self.label[self.mate[y]] < 0:
          self.label[self.mate[y]] = x
          self.first[self.mate[y]] = y
          self.que.addLast(self.mate[y])
    return false
  
  proc maxMatching*(self: var GabowEdmonds):seq[(int,int)] =
    for i in 1..<self.g.len:
      if self.mate[i] != 0: continue
      if self.augmentCheck(i): self.label = newSeqWith(self.g.len, -1)
    result = newSeq[(int,int)]()
    for i in 1..<self.g.len:
      if i < self.mate[i]: result.add((i - 1, self.mate[i] - 1))
