when not declared ATCODER_AHO_CORASICK_HPP:
  const ATCODER_AHO_CORASICK_HPP* = 1
  import tables, deques
  import atcoder/extra/structure/trie
  import atcoder/extra/other/algorithmutils

  template getTrie*(char_sz, margin:static[int]):typedesc = Trie[char_sz, margin]

  type AhoCorasick[char_sz, margin:static[int]] = object
    FAIL*: int
    correct*: seq[int]
    t*: getTrie(char_sz + 1, margin)

  proc initAhoCorasick*[char_sz, margin:static[int]](): AhoCorasick[char_sz, margin] =
    result.FAIL = char_sz
    result.correct = newSeq[int]()
    result.t = initTrie[char_sz + 1, margin]()

  proc add*(self: var AhoCorasick, s:string) =
    self.t.add(s)

  proc build*(self: var AhoCorasick, heavy = true):void =
    self.correct.setLen(self.t.len)
    for i in 0..<self.t.len:
      self.correct[i] = self.t.nodes[i].accept.len
    var que = initDeque[int]()
    for i in 0 .. self.char_sz:
      if self.t.nodes[0].nxt[i] != -1:
        self.t.nodes[self.t.nodes[0].nxt[i]].nxt[self.FAIL] = 0
        que.addLast(self.t.nodes[0].nxt[i])
      else:
        self.t.nodes[0].nxt[i] = 0
    while que.len > 0:
      let f = que.popFirst()
      var now = self.t.nodes[f].addr
      let fail = now[].nxt[self.FAIL]
      self.correct[f] += self.correct[fail]
      for i in 0 ..< self.char_sz:
        if now[].nxt[i] != -1:
          self.t.nodes[now.nxt[i]].nxt[self.FAIL] = self.t.nodes[fail].nxt[i]
          if heavy:
            var
              u = self.t.nodes[now.nxt[i]].accept.addr
              v = self.t.nodes[self.t.nodes[fail].nxt[i]].accept.addr
  #            accept = newSeq[int]()
  #          set_union(begin(u), end(u), begin(v), end(v), back_inserter(accept))
            u[] = setUnion(u[], v[])
          que.addLast(now[].nxt[i])
        else:
          now[].nxt[i] = self.t.nodes[fail].nxt[i]
  
  proc match*(self: AhoCorasick, str: string, now = 0):Table[int,seq[int]] =
    var now = now
    result = initTable[int,seq[int]]()
    for i, c in str:
      now = self.t.nodes[now].nxt[c.ord - self.margin]
      for v in self.t.nodes[now].accept:
        if v notin result: result[v] = newSeq[int]()
        result[v].add(i)
  
  proc move*(self: AhoCorasick, c:char, now = 0):(int,int) =
    var now = self.t.nodes[now].nxt[c.ord - self.margin]
    return (self.correct[now], now)
  
  proc move*(self: AhoCorasick, str:string, now = 0):(int,int) =
    var now = now
    var sum = 0
    for c in str:
      let nxt = self.move(c, now)
      sum += nxt[0]
      now = nxt[1]
    return (sum, now)
