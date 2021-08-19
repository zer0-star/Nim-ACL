---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  - icon: ':warning:'
    path: atcoder/mincostflow.nim
    title: atcoder/mincostflow.nim
  - icon: ':warning:'
    path: test/example/mincostflow_practice.nim
    title: test/example/mincostflow_practice.nim
  - icon: ':warning:'
    path: test/example/mincostflow_practice.nim
    title: test/example/mincostflow_practice.nim
  - icon: ':warning:'
    path: tests/test_mincostflow.nim
    title: tests/test_mincostflow.nim
  - icon: ':warning:'
    path: tests/test_mincostflow.nim
    title: tests/test_mincostflow.nim
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_INTERNAL_HEAP:\n  const ATCODER_INTERNAL_HEAP*\
    \ = 1\n  proc push_heap*[T](v: var openArray[T], p:Slice[int]) {.inline.} =\n\
    \    var i = p.b\n    while i > 0:\n      var p = (i - 1) shr 1\n      if v[p]\
    \ < v[i]: swap v[p], v[i]\n      else: break\n      i = p\n  proc pop_heap*[T](v:\
    \ var openArray[T], p:Slice[int]) {.inline.} =\n    swap v[0], v[p.b]\n    var\
    \ p = p\n    p.b.dec\n    var i = 0\n    while true:\n      var (c0, c1) = (i\
    \ * 2 + 1, i * 2 + 2)\n      if c1 in p:\n        if v[c1] > v[i]:\n         \
    \ if v[c0] > v[c1]:\n            swap(v[i], v[c0])\n            i = c0\n     \
    \     else:\n            swap(v[i], v[c1])\n            i = c1\n        elif v[c0]\
    \ > v[i]:\n          swap(v[i], v[c0])\n          i = c0\n        else:\n    \
    \      break\n      elif c0 in p:\n        if v[c0] > v[i]:\n          swap(v[i],\
    \ v[c0])\n          i = c0\n        else:\n          break\n      else:\n    \
    \    break\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/internal_heap.nim
  requiredBy:
  - atcoder/mincostflow.nim
  - atcoder/mincostflow.nim
  - tests/test_mincostflow.nim
  - tests/test_mincostflow.nim
  - test/example/mincostflow_practice.nim
  - test/example/mincostflow_practice.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/internal_heap.nim
layout: document
redirect_from:
- /library/atcoder/internal_heap.nim
- /library/atcoder/internal_heap.nim.html
title: atcoder/internal_heap.nim
---
