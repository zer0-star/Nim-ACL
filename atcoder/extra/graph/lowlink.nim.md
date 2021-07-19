---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_3_a_lowlink_test.nim
    title: verify/extra/graph/aoj_grl_3_a_lowlink_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_3_a_lowlink_test.nim
    title: verify/extra/graph/aoj_grl_3_a_lowlink_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_3_b_lowlink_test.nim
    title: verify/extra/graph/aoj_grl_3_b_lowlink_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/aoj_grl_3_b_lowlink_test.nim
    title: verify/extra/graph/aoj_grl_3_b_lowlink_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_LOWLINK_HPP:\n  const ATCODER_LOWLINK_HPP* = 1\n\
    \  import atcoder/extra/graph/graph_template\n  proc LowLink*(g:Graph):tuple[articulation:seq[int],\
    \ bridge:seq[(int,int)]] =\n    var\n      used = newSeq[bool](g.len)\n      ord\
    \ = newSeq[int](g.len)\n      low = newSeq[int](g.len)\n      bridge = newSeq[(int,int)]()\n\
    \      articulation = newSeq[int]()\n    proc dfs(idx, k, par:int):int =\n   \
    \   var k = k\n      used[idx] = true\n      ord[idx] = k\n      k += 1\n    \
    \  low[idx] = ord[idx]\n      var\n        is_articulation = false\n        cnt\
    \ = 0\n      for e in g[idx]:\n        if not used[e.dst]:\n          cnt += 1\n\
    \          k = dfs(e.dst, k, idx)\n          low[idx] = min(low[idx], low[e.dst]);\n\
    \          is_articulation = (is_articulation or (par != -1 and low[e.dst] >=\
    \ ord[idx]))\n          if ord[idx] < low[e.dst]: bridge.add((min(idx, e.dst),\
    \ max(idx, e.dst)))\n        elif e.dst != par:\n          low[idx] = min(low[idx],\
    \ ord[e.dst]);\n      is_articulation = (is_articulation or (par == -1) and cnt\
    \ > 1)\n      if is_articulation: articulation.add(idx)\n      return k\n  \n\
    \    var k = 0\n    for i in 0..<g.len:\n      if not used[i]: k = dfs(i, k, -1)\n\
    \    return (articulation, bridge)\n"
  dependsOn:
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/graph/graph_template.nim
  isVerificationFile: false
  path: atcoder/extra/graph/lowlink.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/graph/aoj_grl_3_b_lowlink_test.nim
  - verify/extra/graph/aoj_grl_3_b_lowlink_test.nim
  - verify/extra/graph/aoj_grl_3_a_lowlink_test.nim
  - verify/extra/graph/aoj_grl_3_a_lowlink_test.nim
documentation_of: atcoder/extra/graph/lowlink.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/lowlink.nim
- /library/atcoder/extra/graph/lowlink.nim.html
title: atcoder/extra/graph/lowlink.nim
---
