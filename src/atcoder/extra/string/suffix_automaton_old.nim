when not declared ATCODER_SUFFIX_AUTOMATION_HPP:
  # MLEするので不採用
  # https://atcoder.jp/contests/abc433/submissions/71443594
  const ATCODER_SUFFIX_AUTOMATION_HPP* = 1
  import std/tables
  
  type SuffixAutomatonNode*[C] = ref object
    len*, suf*, org*:int32
    to*:Table[C, int32]
  
  proc copy*[C](nd:SuffixAutomatonNode[C]):SuffixAutomatonNode[C] =
    SuffixAutomatonNode[C](len:nd.len, suf:nd.suf, org:nd.org, to:nd.to)
  
  type SuffixAutomaton*[Node] = object
    nodes*:seq[Node]
    cur*:int32
  
  proc extend*[Node](self:var SuffixAutomaton[Node], c:Node.C) =
    var a = self.cur
    self.cur = int32(self.nodes.len)
    self.nodes.add(Node(len: self.nodes[a].len+1, suf: 0, org: -1,to: initTable[Node.C, int32]()))
    while a != -1 and c notin self.nodes[a].to:
      self.nodes[a].to[c] = self.cur
      a = self.nodes[a].suf
    if a != -1:
      let b = self.nodes[a].to[c]
      if self.nodes[a].len + 1 == self.nodes[b].len:
        self.nodes[self.cur].suf = b
      else:
        let w = int32(self.nodes.len)
        self.nodes.add(self.nodes[b].copy)
        self.nodes[w].len = self.nodes[a].len + 1
        self.nodes[w].org = b
        while a != -1 and self.nodes[a].to[c] == b:
          self.nodes[a].to[c] = w
          a = self.nodes[a].suf
        self.nodes[self.cur].suf = w
        self.nodes[b].suf = w
  
  proc initSuffixautomaton*[C]():auto =
    SuffixAutomaton[SuffixAutomatonNode[C]](nodes: @[SuffixAutomatonNode[C](len:0,suf: -1,org: -1,to:initTable[C,int32]())], cur:0)
  
  proc initSuffixautomaton*[C](s:string):auto =
    result = initSuffixAutomaton[C]()
    for c in s: result.extend(c)
  
  proc toposort*[Node](self: SuffixAutomaton[Node]):seq[int] =
    let n = self.nodes.len
    var c = newSeq[int](n)
    for i in 0..<n:
      for k,v in self.nodes[i].to:
        c[v].inc
    result = newSeq[int](n)
    var (b, e) = (0, 0)
    for i in 0..<n:
      if c[i] == 0: result[e]=i;e.inc
    while e<n:
      let i = result[b];b.inc
      for k,v in self.nodes[i].to:
        c[v].dec
        if c[v] == 0:result[e] = v;e.inc
  
  proc `[]`*[Node](self: SuffixAutomaton[Node], i:int):auto = self.nodes[i]
  iterator pairs*[C](self: SuffixAutomatonNode[C]):(C, int) =
    for k, v in self.to: yield((k, int(v)))
