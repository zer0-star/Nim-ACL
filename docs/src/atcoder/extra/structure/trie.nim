when not declared ATCODER_TRIE_HPP:
  const ATCODER_TRIE_HPP* = 1
  import std/algorithm
  type TrieNode*[char_size:static[int]] = object
    nxt*: array[char_size, int]
    exist*: int
    accept*: seq[int]
  
  proc initTrieNode*[char_size:static[int]]():TrieNode[char_size] =
    result.exist = 0
    result.nxt.fill(-1)

  type Trie*[char_size, margin:static[int]] = object of RootObj
    nodes*:seq[TrieNode[char_size]]
    root*:int
  
  #using Node = TrieNode< char_size >;

  proc initTrie*[char_size, margin:static[int]]():Trie[char_size, margin] =
    result.root = 0
    result.nodes.add(initTrieNode[char_size]())

  proc update_direct*(self:var Trie, node, id:int) =
    self.nodes[node].accept.add(id)

  proc update_child*(self: var Trie, node, child, id:int) =
    self.nodes[node].exist.inc

  proc add*(self: var Trie, str:string, str_index, node_index, id:int) =
    if str_index == str.len:
      self.update_direct(node_index, id)
    else:
      let c = str[str_index].ord - self.margin
      if self.nodes[node_index].nxt[c] == -1:
        self.nodes[node_index].nxt[c] = self.nodes.len
        self.nodes.add(initTrieNode[self.char_size]());
      self.add(str, str_index + 1, self.nodes[node_index].nxt[c], id)
      self.update_child(node_index, self.nodes[node_index].nxt[c], id)

  proc add*(self: var Trie, str:string, id:int) =
    self.add(str, 0, 0, id)

  proc add*(self: var Trie, str:string) =
    self.add(str, self.nodes[0].exist)

  proc query*(self: Trie, str:string, f:proc(a:int):void, str_index, node_index:int) =
    for idx in self.nodes[node_index].accept:
      f(idx)
    if str_index == str.len:
      return
    else:
      let c = str[str_index].ord - self.margin
      if self.nodes[node_index].nxt[c] == -1: return
      self.query(str, f, str_index + 1, self.nodes[node_index].nxt[c])

  proc query*(self: Trie, str:string, f:proc(a:int):void) =
    query(str, f, 0, 0)

  proc count*(self: Trie):int =
    return self.nodes[0].exist

  proc len*(self: Trie):int =
    return self.nodes.len

#block:
#  var
#    trie = initTrie[26, 'a'.ord]()
#  let
#    S = nextString()
#    M = nextInt()
#    P = Seq[M: nextString()]
#    W = Seq[M: nextInt()]
#  for i in M: trie.add(P[i])
#  var dp = Seq[S.len + 1: int]
#  for i in S.len:
#    proc update(idx:int) =
#      debug dp.len, i + P[idx].len
#      dp[i + P[idx].len] = max(dp[i + P[idx].len], dp[i] + W[idx])
#    trie.query(S, update, i, 0)
#    dp[i + 1] = max(dp[i + 1], dp[i])
#  echo dp[^1]
