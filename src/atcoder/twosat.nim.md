---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':question:'
    path: atcoder/internal_csr.nim
    title: atcoder/internal_csr.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  - icon: ':x:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_TWOSAT_HPP:\n  const ATCODER_TWOSAT_HPP* = 1\n\n\
    \  import atcoder/internal_scc\n  \n  # Reference:\n  # B. Aspvall, M. Plass,\
    \ and R. Tarjan,\n  # A Linear-Time Algorithm for Testing the Truth of Certain\
    \ Quantified Boolean\n  # Formulas\n  type TwoSAT* = object\n    n:int\n    answer:seq[bool]\n\
    \    scc:internal_scc_graph\n\n  proc init_TwoSAT*(n:int):auto =\n    TwoSAT(n:n,\
    \ answer:newSeq[bool](n), scc:init_internal_scc_graph(2 * n))\n  \n  proc add_clause*(self:var\
    \ TwoSAT, i:int, f:bool, j:int, g:bool) =\n    assert i in 0..<self.n\n    assert\
    \ j in 0..<self.n\n    self.scc.add_edge(2 * i + (if f: 0 else: 1), 2 * j + (if\
    \ g: 1 else: 0))\n    self.scc.add_edge(2 * j + (if g: 0 else: 1), 2 * i + (if\
    \ f: 1 else: 0))\n  proc satisfiable*(self:var TwoSAT):bool =\n    let id = self.scc.scc_ids()[1]\n\
    \    for i in 0..<self.n:\n      if id[2 * i] == id[2 * i + 1]: return false\n\
    \      self.answer[i] = id[2 * i] < id[2 * i + 1]\n    return true\n  proc answer*(self:\
    \ TwoSAT):auto = self.answer\n"
  dependsOn:
  - atcoder/internal_scc.nim
  - atcoder/internal_csr.nim
  - atcoder/internal_scc.nim
  - atcoder/internal_csr.nim
  isVerificationFile: false
  path: atcoder/twosat.nim
  requiredBy: []
  timestamp: '2021-08-18 01:50:54+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/twosat_test.nim
  - verify/twosat_test.nim
documentation_of: atcoder/twosat.nim
layout: document
redirect_from:
- /library/atcoder/twosat.nim
- /library/atcoder/twosat.nim.html
title: atcoder/twosat.nim
---
