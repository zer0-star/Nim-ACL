---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/string/aho_corasick.nim
    title: atcoder/extra/string/aho_corasick.nim
  - icon: ':warning:'
    path: atcoder/extra/string/aho_corasick.nim
    title: atcoder/extra/string/aho_corasick.nim
  - icon: ':warning:'
    path: atcoder/extra/string/aho_corasick.nim
    title: atcoder/extra/string/aho_corasick.nim
  - icon: ':warning:'
    path: atcoder/extra/string/aho_corasick.nim
    title: atcoder/extra/string/aho_corasick.nim
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_TRIE_HPP:\n  const ATCODER_TRIE_HPP* = 1\n  import\
    \ std/algorithm\n  type TrieNode*[char_size:static[int]] = object\n    nxt*: array[char_size,\
    \ int]\n    exist*: int\n    accept*: seq[int]\n  \n  proc initTrieNode*[char_size:static[int]]():TrieNode[char_size]\
    \ =\n    result.exist = 0\n    result.nxt.fill(-1)\n\n  type Trie*[char_size,\
    \ margin:static[int]] = object of RootObj\n    nodes*:seq[TrieNode[char_size]]\n\
    \    root*:int\n  \n  #using Node = TrieNode< char_size >;\n\n  proc initTrie*[char_size,\
    \ margin:static[int]]():Trie[char_size, margin] =\n    result.root = 0\n    result.nodes.add(initTrieNode[char_size]())\n\
    \n  proc update_direct*(self:var Trie, node, id:int) =\n    self.nodes[node].accept.add(id)\n\
    \n  proc update_child*(self: var Trie, node, child, id:int) =\n    self.nodes[node].exist.inc\n\
    \n  proc add*(self: var Trie, str:string, str_index, node_index, id:int) =\n \
    \   if str_index == str.len:\n      self.update_direct(node_index, id)\n    else:\n\
    \      let c = str[str_index].ord - self.margin\n      if self.nodes[node_index].nxt[c]\
    \ == -1:\n        self.nodes[node_index].nxt[c] = self.nodes.len\n        self.nodes.add(initTrieNode[self.char_size]());\n\
    \      self.add(str, str_index + 1, self.nodes[node_index].nxt[c], id)\n     \
    \ self.update_child(node_index, self.nodes[node_index].nxt[c], id)\n\n  proc add*(self:\
    \ var Trie, str:string, id:int) =\n    self.add(str, 0, 0, id)\n\n  proc add*(self:\
    \ var Trie, str:string) =\n    self.add(str, self.nodes[0].exist)\n\n  proc query*(self:\
    \ Trie, str:string, f:proc(a:int):void, str_index, node_index:int) =\n    for\
    \ idx in self.nodes[node_index].accept:\n      f(idx)\n    if str_index == str.len:\n\
    \      return\n    else:\n      let c = str[str_index].ord - self.margin\n   \
    \   if self.nodes[node_index].nxt[c] == -1: return\n      self.query(str, f, str_index\
    \ + 1, self.nodes[node_index].nxt[c])\n\n  proc query*(self: Trie, str:string,\
    \ f:proc(a:int):void) =\n    query(str, f, 0, 0)\n\n  proc count*(self: Trie):int\
    \ =\n    return self.nodes[0].exist\n\n  proc len*(self: Trie):int =\n    return\
    \ self.nodes.len\n\n#block:\n#  var\n#    trie = initTrie[26, 'a'.ord]()\n#  let\n\
    #    S = nextString()\n#    M = nextInt()\n#    P = Seq[M: nextString()]\n#  \
    \  W = Seq[M: nextInt()]\n#  for i in M: trie.add(P[i])\n#  var dp = Seq[S.len\
    \ + 1: int]\n#  for i in S.len:\n#    proc update(idx:int) =\n#      debug dp.len,\
    \ i + P[idx].len\n#      dp[i + P[idx].len] = max(dp[i + P[idx].len], dp[i] +\
    \ W[idx])\n#    trie.query(S, update, i, 0)\n#    dp[i + 1] = max(dp[i + 1], dp[i])\n\
    #  echo dp[^1]\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/trie.nim
  requiredBy:
  - atcoder/extra/string/aho_corasick.nim
  - atcoder/extra/string/aho_corasick.nim
  - atcoder/extra/string/aho_corasick.nim
  - atcoder/extra/string/aho_corasick.nim
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/trie.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/trie.nim
- /library/atcoder/extra/structure/trie.nim.html
title: atcoder/extra/structure/trie.nim
---
