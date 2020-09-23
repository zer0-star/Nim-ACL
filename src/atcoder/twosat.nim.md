---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_TWOSAT_HPP:\n  const ATCODER_TWOSAT_HPP* = 1\n\n\
    \  import atcoder/internal_scc\n  \n  # Reference:\n  # B. Aspvall, M. Plass,\
    \ and R. Tarjan,\n  # A Linear-Time Algorithm for Testing the Truth of Certain\
    \ Quantified Boolean\n  # Formulas\n  type two_sat* = object\n    n:int\n    answer:seq[bool]\n\
    \    scc:internal_scc_graph\n\n  proc init_two_sat*(n:int):auto =\n    two_sat(n:n,\
    \ answer:newSeq[bool](n), scc:init_internal_scc_graph(2 * n))\n  \n  proc add_clause*(self:var\
    \ two_sat, i:int, f:bool, j:int, g:bool) =\n    assert i in 0..<self.n\n    assert\
    \ j in 0..<self.n\n    self.scc.add_edge(2 * i + (if f: 0 else: 1), 2 * j + (if\
    \ g: 1 else: 0))\n    self.scc.add_edge(2 * j + (if g: 0 else: 1), 2 * i + (if\
    \ f: 1 else: 0))\n  proc satisfiable*(self:var two_sat):bool =\n    let id = self.scc.scc_ids()[1]\n\
    \    for i in 0..<self.n:\n      if id[2 * i] == id[2 * i + 1]: return false\n\
    \      self.answer[i] = id[2 * i] < id[2 * i + 1]\n    return true\n  proc answer*(self:\
    \ two_sat):auto = self.answer\n"
  dependsOn: []
  isVerificationFile: false
  path: src/atcoder/twosat.nim
  requiredBy: []
  timestamp: '2020-09-18 23:26:10+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/atcoder/twosat.nim
layout: document
redirect_from:
- /library/src/atcoder/twosat.nim
- /library/src/atcoder/twosat.nim.html
title: src/atcoder/twosat.nim
---
