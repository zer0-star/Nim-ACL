---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/cycle_detection.nim
    title: atcoder/extra/graph/cycle_detection.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/graph/cycle_detection.nim
    title: atcoder/extra/graph/cycle_detection.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':question:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':question:'
    path: atcoder/extra/other/internal_underscored_calls.nim
    title: atcoder/extra/other/internal_underscored_calls.nim
  - icon: ':question:'
    path: atcoder/extra/other/internal_underscored_calls.nim
    title: atcoder/extra/other/internal_underscored_calls.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/cycle_detection
    links:
    - https://judge.yosupo.jp/problem/cycle_detection
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/cycle_detection\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/other/internal_sugar\nimport\
    \ atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/cycle_detection\n\
    import std/options, std/sequtils\n\nproc main() =\n  let N, M = nextInt()\n  var\
    \ g = initGraph(N)\n\n  for i in 0..<M:\n    var\n      u = nextInt()\n      v\
    \ = nextInt()\n    g.addEdge(u, v, i)\n  \n  let c = g.cycle_detection()\n  if\
    \ c.isSome:\n    let c = c.get\n    echo c.len\n    let v = collect(newSeq):\n\
    \      for e in c:\n        e.weight\n    echo v.join(\"\\n\")\n  else:\n    echo\
    \ -1\n\nmain()\n"
  dependsOn:
  - atcoder/extra/other/internal_underscored_calls.nim
  - atcoder/extra/graph/cycle_detection.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/header.nim
  - atcoder/extra/other/internal_sugar.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/internal_underscored_calls.nim
  - atcoder/extra/graph/cycle_detection.nim
  - atcoder/header.nim
  - atcoder/extra/other/internal_sugar.nim
  isVerificationFile: true
  path: verify/extra/graph/yosupo_cycle_detection_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/graph/yosupo_cycle_detection_test.nim
layout: document
redirect_from:
- /verify/verify/extra/graph/yosupo_cycle_detection_test.nim
- /verify/verify/extra/graph/yosupo_cycle_detection_test.nim.html
title: verify/extra/graph/yosupo_cycle_detection_test.nim
---
