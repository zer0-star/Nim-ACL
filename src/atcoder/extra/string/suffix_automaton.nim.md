---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/string/yosupo_number_of_substrings_test.nim
    title: verify/extra/string/yosupo_number_of_substrings_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/string/yosupo_number_of_substrings_test.nim
    title: verify/extra/string/yosupo_number_of_substrings_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SUFFIX_AUTOMATION_HPP:\n  const ATCODER_SUFFIX_AUTOMATION_HPP*\
    \ = 1\n  import tables\n  \n  type SuffixAutomatonNode*[C] = ref object\n    len,\
    \ suf, org:int\n    to:Table[C, int]\n  \n  proc copy*[C](nd:SuffixAutomatonNode[C]):SuffixAutomatonNode[C]\
    \ =\n    SuffixAutomatonNode[C](len:nd.len, suf:nd.suf, org:nd.org, to:nd.to)\n\
    \  \n  type SuffixAutomaton*[Node] = object\n    x:seq[Node]\n    cur:int\n  \n\
    \  proc extend*[Node](self:var SuffixAutomaton[Node], c:Node.C) =\n    var a =\
    \ self.cur\n    self.cur = self.x.len\n    self.x.add(Node(len: self.x[a].len+1,\
    \ suf: 0, org: -1,to: initTable[Node.C, int]()))\n    while a != -1 and c notin\
    \ self.x[a].to:\n      self.x[a].to[c] = self.cur\n      a = self.x[a].suf\n \
    \   if a != -1:\n      let b = self.x[a].to[c]\n      if self.x[a].len + 1 ==\
    \ self.x[b].len:\n        self.x[self.cur].suf = b\n      else:\n        let w\
    \ = self.x.len\n        self.x.add(self.x[b].copy)\n        self.x[w].len = self.x[a].len\
    \ + 1\n        self.x[w].org = b\n        while a != -1 and self.x[a].to[c] ==\
    \ b:\n          self.x[a].to[c] = w\n          a = self.x[a].suf\n        self.x[self.cur].suf\
    \ = w\n        self.x[b].suf = w\n  \n  proc initSuffixautomaton*[C]():auto =\n\
    \    SuffixAutomaton[SuffixAutomatonNode[C]](x: @[SuffixAutomatonNode[C](len:0,suf:\
    \ -1,org: -1,to:initTable[C,int]())], cur:0)\n  \n  proc initSuffixautomaton*[C](s:string):auto\
    \ =\n    result = initSuffixAutomaton[C]()\n    for c in s: result.extend(c)\n\
    \  \n  proc toposort*[Node](self: SuffixAutomaton[Node]):seq[int] =\n    let n\
    \ = self.x.len\n    var c = newSeq[int](n)\n    for i in 0..<n:\n      for k,v\
    \ in self.x[i].to:\n        c[v].inc\n    result = newSeq[int](n)\n    var (b,\
    \ e) = (0, 0)\n    for i in 0..<n:\n      if c[i] == 0: result[e]=i;e.inc\n  \
    \  while e<n:\n      let i = result[b];b.inc\n      for k,v in self.x[i].to:\n\
    \        c[v].dec\n        if c[v] == 0:result[e] = v;e.inc\n  \n  proc `[]`*[Node](self:\
    \ SuffixAutomaton[Node], i:int):auto = self.x[i]\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/string/suffix_automaton.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/string/yosupo_number_of_substrings_test.nim
  - verify/extra/string/yosupo_number_of_substrings_test.nim
documentation_of: atcoder/extra/string/suffix_automaton.nim
layout: document
redirect_from:
- /library/atcoder/extra/string/suffix_automaton.nim
- /library/atcoder/extra/string/suffix_automaton.nim.html
title: atcoder/extra/string/suffix_automaton.nim
---
