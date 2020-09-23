---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: test/example/twosat_practice.nim
    title: test/example/twosat_practice.nim
  - icon: ':warning:'
    path: test/example/twosat_practice.nim
    title: test/example/twosat_practice.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
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
  dependsOn:
  - atcoder/internal_scc.nim
  - atcoder/internal_scc.nim
  isVerificationFile: false
  path: atcoder/twosat.nim
  requiredBy:
  - test/example/twosat_practice.nim
  - test/example/twosat_practice.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
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
