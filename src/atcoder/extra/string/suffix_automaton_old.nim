when not declared ATCODER_EXTRA_SUFFIX_AUTOMATON_HPP:
  const ATCODER_EXTRA_SUFFIX_AUTOMATON_HPP* = 1
  import std/tables
  type SA_Node* = ref object
    next*: Table[char, int32]
    link*, len*: int32

  type SuffixAutomaton*[Node] = object
    nodes*: seq[Node]
    last*: int32

  proc initSuffixAutomaton*(): SuffixAutomaton[SA_Node] =
    SuffixAutomaton[SA_Node](nodes: @[SA_Node(next: initTable[char, int32](), link: -1, len: 0)], last: 0)

  proc push*(self: var SuffixAutomaton, c: char) =
    let
      new_node = int32(self.nodes.len)
    self.nodes.add(SA_Node(next: initTable[char, int32](), link: -1, len:self.nodes[self.last].len + 1))
    var p = self.last
    while p != -1 and c notin self.nodes[p].next:
      self.nodes[p].next[c] = new_node
      p = self.nodes[p].link
    let q = if p == -1: 0'i32 else: self.nodes[p].next[c]
    if p == -1 or self.nodes[p].len + 1 == self.nodes[q].len:
      self.nodes[new_node].link = q
    else:
      # clone node (q -> new_q)
      let new_q = int32(self.nodes.len)
      self.nodes.add(SA_Node(next: self.nodes[q].next, link:self.nodes[q].link, len:self.nodes[p].len + 1));
      self.nodes[q].link = new_q
      self.nodes[new_node].link = new_q

      while p != -1 and self.nodes[p].next[c] == q:
        self.nodes[p].next[c] = new_q
        p = self.nodes[p].link
    self.last = new_node

  proc initSuffixAutomaton*(S: string): SuffixAutomaton[SA_Node] =
    result = initSuffixAutomaton()
    for c in S: result.push(c)

  proc `[]`*[Node](self: SuffixAutomaton[Node], i:int):SA_Node = self.nodes[i]
  iterator pairs*(node: SA_Node):(char, int32) =
    for k, v in node.next: yield((k, v))


