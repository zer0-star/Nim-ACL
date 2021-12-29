---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/convolution.nim
    title: atcoder/convolution.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/tree/centroid_decomposition.nim
    title: atcoder/extra/tree/centroid_decomposition.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/tree/centroid_decomposition.nim
    title: atcoder/extra/tree/centroid_decomposition.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/frequency_table_of_tree_distance
    links:
    - https://judge.yosupo.jp/problem/frequency_table_of_tree_distance
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/frequency_table_of_tree_distance\n\
    \nimport atcoder/header\n#import atcoder/modint\ninclude atcoder/convolution\n\
    import atcoder/extra/graph/graph_template\nimport std/sequtils, std/strutils\n\
    import atcoder/extra/tree/centroid_decomposition\n\nproc main():void =\n  let\
    \ N = nextInt()\n  var g = initGraph(N)\n  \n  for _ in 0..<N-1:\n    let a, b\
    \ = nextInt()\n    g.addBiEdge(a, b)\n  \n  let (c, tree) = g.CentroidDecomposition()\n\
    \  \n  var\n    used = newSeqWith(N, false)\n    ans = newSeq[int](N)\n  \n  proc\
    \ dfs(c:int) =\n    used[c] = true\n    for e in tree[c]: dfs(e.dst)\n    used[c]\
    \ = false\n    proc dfs2(u:int, p = -1, h = 0, d:var seq[int]) =\n      if h >=\
    \ d.len:\n        d.setLen(h + 1)\n      d[h].inc\n      for e in g[u]:\n    \
    \    if e.dst == p or used[e.dst]: continue\n        dfs2(e.dst, u, h + 1, d)\n\
    \    var base = newSeq[int]()\n    for e in g[c]:\n      if used[e.dst]: continue\n\
    \      var d = newSeq[int]()\n      dfs2(e.dst, c, 1, d)\n      let t = convolution(base,\
    \ d)\n      for i, d in t: ans[i] += d\n      if base.len < d.len: base.setLen(d.len)\n\
    \      for i,d in d:ans[i] += d;base[i] += d\n\n  dfs(c)\n  echo ans[1..^1].join(\"\
    \ \")\n\nmain()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/tree/centroid_decomposition.nim
  - atcoder/convolution.nim
  - atcoder/modint.nim
  - atcoder/header.nim
  - atcoder/internal_bit.nim
  - atcoder/convolution.nim
  - atcoder/internal_bit.nim
  - atcoder/extra/tree/centroid_decomposition.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/element_concepts.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/modint.nim
  isVerificationFile: true
  path: verify/extra/graph/centroid_decomposition_test.nim
  requiredBy: []
  timestamp: '2021-11-18 02:47:29+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/centroid_decomposition_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/centroid_decomposition_test.nim
- /verify/verify/extra/graph/centroid_decomposition_test.nim.html
title: verify/extra/graph/centroid_decomposition_test.nim
---
