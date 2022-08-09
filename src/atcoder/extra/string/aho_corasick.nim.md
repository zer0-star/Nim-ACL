---
data:
  _extendedDependsOn:
  - icon: ':warning:'
    path: atcoder/extra/structure/trie.nim
    title: atcoder/extra/structure/trie.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/trie.nim
    title: atcoder/extra/structure/trie.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/trie.nim
    title: atcoder/extra/structure/trie.nim
  - icon: ':warning:'
    path: atcoder/extra/structure/trie.nim
    title: atcoder/extra/structure/trie.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_AHO_CORASICK_HPP:\n  const ATCODER_AHO_CORASICK_HPP*\
    \ = 1\n  import tables, deques\n  import atcoder/extra/structure/trie\n\n  template\
    \ getTrie*(char_sz, margin:static[int]):typedesc = Trie[char_sz, margin]\n\n \
    \ type AhoCorasick[char_sz, margin:static[int]] = object\n    FAIL: int\n    correct:\
    \ seq[int]\n    t: getTrie(char_sz + 1, margin)\n\n  proc initAhoCorasick*[char_sz,\
    \ margin:static[int]](): AhoCorasick[char_sz, margin] =\n    result.FAIL = char_sz\n\
    \    result.correct = newSeq[int]()\n    result.t = initTrie[char_sz + 1, margin]()\n\
    \n  proc add*(self: var AhoCorasick, s:string) =\n    self.t.add(s)\n\n  proc\
    \ setUnion*[T](u, v: seq[T]):seq[T] =\n    result = newSeq[T]()\n    var (i,j)\
    \ = (0,0)\n    while true:\n      if i < u.len:\n        if j < v.len:\n     \
    \     if u[i] < v[j]:result.add(u[i]);i+=1\n          elif u[i] > v[j]:result.add(v[j]);j+=1\n\
    \          else: result.add(v[j]);i+=1;j+=1\n        else:\n          result.add(u[i]);i+=1\n\
    \      else:\n        if j < v.len:\n          result.add(v[j]);j+=1\n       \
    \ else:\n          break\n  #  echo u, v, result\n  \n  proc build*(self: var\
    \ AhoCorasick, heavy = true):void =\n    self.correct.setLen(self.t.len)\n   \
    \ for i in 0..<self.t.len:\n      self.correct[i] = self.t.nodes[i].accept.len\n\
    \    var que = initDeque[int]()\n    for i in 0 .. self.char_sz:\n      if self.t.nodes[0].nxt[i]\
    \ != -1:\n        self.t.nodes[self.t.nodes[0].nxt[i]].nxt[self.FAIL] = 0\n  \
    \      que.addLast(self.t.nodes[0].nxt[i])\n      else:\n        self.t.nodes[0].nxt[i]\
    \ = 0\n    while que.len > 0:\n      let f = que.popFirst()\n      var now = self.t.nodes[f].addr\n\
    \      let fail = now[].nxt[self.FAIL]\n      self.correct[f] += self.correct[fail]\n\
    \      for i in 0 ..< self.char_sz:\n        if now[].nxt[i] != -1:\n        \
    \  self.t.nodes[now.nxt[i]].nxt[self.FAIL] = self.t.nodes[fail].nxt[i]\n     \
    \     if heavy:\n            var\n              u = self.t.nodes[now.nxt[i]].accept.addr\n\
    \              v = self.t.nodes[self.t.nodes[fail].nxt[i]].accept.addr\n  #  \
    \          accept = newSeq[int]()\n  #          set_union(begin(u), end(u), begin(v),\
    \ end(v), back_inserter(accept))\n            u[] = setUnion(u[], v[])\n     \
    \     que.addLast(now[].nxt[i])\n        else:\n          now[].nxt[i] = self.t.nodes[fail].nxt[i]\n\
    \  \n  proc match*(self: AhoCorasick, str: string, now = 0):Table[int,seq[int]]\
    \ =\n    var now = now\n    result = initTable[int,seq[int]]()\n    for i, c in\
    \ str:\n      now = self.t.nodes[now].nxt[c.ord - self.margin]\n      for v in\
    \ self.t.nodes[now].accept:\n        if v notin result: result[v] = newSeq[int]()\n\
    \        result[v].add(i)\n  \n  proc move*(self: AhoCorasick, c:char, now = 0):(int,int)\
    \ =\n    var now = self.t.nodes[now].nxt[c.ord - self.margin]\n    return (self.correct[now],\
    \ now)\n  \n  proc move*(self: AhoCorasick, str:string, now = 0):(int,int) =\n\
    \    var now = now\n    var sum = 0\n    for c in str:\n      let nxt = self.move(c,\
    \ now)\n      sum += nxt[0]\n      now = nxt[1]\n    return (sum, now)\n"
  dependsOn:
  - atcoder/extra/structure/trie.nim
  - atcoder/extra/structure/trie.nim
  - atcoder/extra/structure/trie.nim
  - atcoder/extra/structure/trie.nim
  isVerificationFile: false
  path: atcoder/extra/string/aho_corasick.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/string/aho_corasick.nim
layout: document
redirect_from:
- /library/atcoder/extra/string/aho_corasick.nim
- /library/atcoder/extra/string/aho_corasick.nim.html
title: atcoder/extra/string/aho_corasick.nim
---
