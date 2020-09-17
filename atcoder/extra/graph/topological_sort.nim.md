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
  code: "# Topological Sort {{{\nwhen not declared ATCODER_TOPOLOGICAL_SORT_HPP:\n\
    \  const ATCODER_TOPOLOGICAL_SORT_HPP* = 1\n  import \"atcoder/extra/graph/template\"\
    \n  proc topologicalSort*(g:Graph[int]):seq[int] =\n    let N = g.len\n    var\
    \ deg = newSeq[int](N)\n    for i in 0..<N:\n      for e in g[i]:\n        deg[e.dst].inc\n\
    \    var st = newSeq[int]()\n    for i in 0..<N:\n      if deg[i] == 0: st.add(i)\n\
    \    result = newSeq[int]()\n    while st.len > 0:\n      let p = st.pop()\n \
    \     result.add(p)\n      for e in g[p]:\n        deg[e.dst].dec\n        if\
    \ deg[e.dst] == 0: st.add(e.dst)\n# }}}\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/graph/topological_sort.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/topological_sort.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/topological_sort.nim
- /library/atcoder/extra/graph/topological_sort.nim.html
title: atcoder/extra/graph/topological_sort.nim
---
