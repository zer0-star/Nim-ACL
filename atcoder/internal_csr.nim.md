---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':question:'
    path: atcoder/internal_scc.nim
    title: atcoder/internal_scc.nim
  - icon: ':warning:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  - icon: ':warning:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  - icon: ':question:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  - icon: ':question:'
    path: atcoder/scc.nim
    title: atcoder/scc.nim
  - icon: ':x:'
    path: atcoder/twosat.nim
    title: atcoder/twosat.nim
  - icon: ':x:'
    path: atcoder/twosat.nim
    title: atcoder/twosat.nim
  - icon: ':warning:'
    path: test/example/mincostflow_practice.nim
    title: test/example/mincostflow_practice.nim
  - icon: ':warning:'
    path: test/example/mincostflow_practice.nim
    title: test/example/mincostflow_practice.nim
  - icon: ':warning:'
    path: test/example/twosat_practice.nim
    title: test/example/twosat_practice.nim
  - icon: ':warning:'
    path: test/example/twosat_practice.nim
    title: test/example/twosat_practice.nim
  - icon: ':warning:'
    path: tests/test_mincostflow.nim
    title: tests/test_mincostflow.nim
  - icon: ':warning:'
    path: tests/test_mincostflow.nim
    title: tests/test_mincostflow.nim
  - icon: ':warning:'
    path: tests/test_scc.nim
    title: tests/test_scc.nim
  - icon: ':warning:'
    path: tests/test_scc.nim
    title: tests/test_scc.nim
  - icon: ':warning:'
    path: tests/test_twosat.nim
    title: tests/test_twosat.nim
  - icon: ':warning:'
    path: tests/test_twosat.nim
    title: tests/test_twosat.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
    title: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
    title: verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
  - icon: ':x:'
    path: verify/scc_test.nim
    title: verify/scc_test.nim
  - icon: ':x:'
    path: verify/scc_test.nim
    title: verify/scc_test.nim
  - icon: ':x:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  - icon: ':x:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':question:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_INTERNAL_CSR_HPP:\n  const ATCODER_INTERNAL_CSR_HPP*\
    \ = 1\n\n  type csr*[E] = object\n    start*: seq[int]\n    elist*: seq[E]\n \
    \ proc initCsr*[E](n:int, edges:seq[(int, E)]):csr[E] =\n    var start = newSeq[int](n\
    \ + 1)\n    var elist = newSeq[E](edges.len)\n    for e in edges: start[e[0] +\
    \ 1].inc\n    for i in 1..n: start[i] += start[i - 1]\n    var counter = start\n\
    \    for e in edges:\n      elist[counter[e[0]]] = e[1]\n      counter[e[0]].inc\n\
    \    return csr[E](start:start, elist:elist)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/internal_csr.nim
  requiredBy:
  - atcoder/mincostflow.nim
  - atcoder/mincostflow.nim
  - atcoder/twosat.nim
  - atcoder/twosat.nim
  - atcoder/scc.nim
  - atcoder/scc.nim
  - atcoder/internal_scc.nim
  - atcoder/internal_scc.nim
  - tests/test_twosat.nim
  - tests/test_twosat.nim
  - tests/test_mincostflow.nim
  - tests/test_mincostflow.nim
  - tests/test_scc.nim
  - tests/test_scc.nim
  - test/example/mincostflow_practice.nim
  - test/example/mincostflow_practice.nim
  - test/example/twosat_practice.nim
  - test/example/twosat_practice.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_SOME_WA
  verifiedWith:
  - verify/twosat_test.nim
  - verify/twosat_test.nim
  - verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
  - verify/extra/graph/aoj_grl_3_c_strongly_connected_components_test.nim
  - verify/scc_test.nim
  - verify/scc_test.nim
documentation_of: atcoder/internal_csr.nim
layout: document
redirect_from:
- /library/atcoder/internal_csr.nim
- /library/atcoder/internal_csr.nim.html
title: atcoder/internal_csr.nim
---
