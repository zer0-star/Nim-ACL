when not declared ATCODER_SUFFIX_AUTOMATION_HPP:
  const ATCODER_SUFFIX_AUTOMATION_HPP* = 1
  import tables
  
  type SuffixAutomatonNode*[C] = ref object
    len, suf, org:int
    to:Table[C, int]
  
  proc copy*[C](nd:SuffixAutomatonNode[C]):SuffixAutomatonNode[C] =
    SuffixAutomatonNode[C](len:nd.len, suf:nd.suf, org:nd.org, to:nd.to)
  
  type SuffixAutomaton*[Node] = object
    x:seq[Node]
    cur:int
  
  proc extend*[Node](self:var SuffixAutomaton[Node], c:Node.C) =
    var a = self.cur
    self.cur = self.x.len
    self.x.add(Node(len: self.x[a].len+1, suf: 0, org: -1,to: initTable[Node.C, int]()))
    while a != -1 and c notin self.x[a].to:
      self.x[a].to[c] = self.cur
      a = self.x[a].suf
    if a != -1:
      let b = self.x[a].to[c]
      if self.x[a].len + 1 == self.x[b].len:
        self.x[self.cur].suf = b
      else:
        let w = self.x.len
        self.x.add(self.x[b].copy)
        self.x[w].len = self.x[a].len + 1
        self.x[w].org = b
        while a != -1 and self.x[a].to[c] == b:
          self.x[a].to[c] = w
          a = self.x[a].suf
        self.x[self.cur].suf = w
        self.x[b].suf = w
  
  proc initSuffixautomaton*[C]():auto =
    SuffixAutomaton[SuffixAutomatonNode[C]](x: @[SuffixAutomatonNode[C](len:0,suf: -1,org: -1,to:initTable[C,int]())], cur:0)
  
  proc initSuffixautomaton*[C](s:string):auto =
    result = initSuffixAutomaton[C]()
    for c in s: result.extend(c)
  
  proc toposort*[Node](self: SuffixAutomaton[Node]):seq[int] =
    let n = self.x.len
    var c = newSeq[int](n)
    for i in 0..<n:
      for k,v in self.x[i].to:
        c[v].inc
    result = newSeq[int](n)
    var (b, e) = (0, 0)
    for i in 0..<n:
      if c[i] == 0: result[e]=i;e.inc
    while e<n:
      let i = result[b];b.inc
      for k,v in self.x[i].to:
        c[v].dec
        if c[v] == 0:result[e] = v;e.inc
  
  proc `[]`*[Node](self: SuffixAutomaton[Node], i:int):auto = self.x[i]
