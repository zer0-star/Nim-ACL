---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_DIRECTION:\n  const ATCODER_DIRECTION* = 1\n  let\
    \ dir4* = [(1, 0), (0, 1), (-1, 0), (0, -1)]\n  let dir8* = [(1, 0), (1, 1), (0,\
    \ 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1)]\n\n  iterator neighbor*(p:(int,\
    \ int), d:openArray[(int, int)]):(int, int) =\n    for d in d:\n      let (i,\
    \ j) = (p[0] + d[0], p[1] + d[1])\n      yield (i, j)\n  iterator neighbor*(p:(int,\
    \ int), d:openArray[(int, int)], limit:(Slice[int], Slice[int])):(int, int) =\n\
    \    for (i, j) in p.neighbor(d):\n      if i notin limit[0] or j notin limit[1]:\
    \ continue\n      yield (i, j)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/direction.nim
  requiredBy: []
  timestamp: '2021-08-10 01:29:44+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/direction.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/direction.nim
- /library/atcoder/extra/other/direction.nim.html
title: atcoder/extra/other/direction.nim
---
