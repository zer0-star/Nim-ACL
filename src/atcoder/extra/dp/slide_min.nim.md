---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/dp/aoj_dsl_3_d_slidemin_test.nim
    title: verify/extra/dp/aoj_dsl_3_d_slidemin_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/dp/aoj_dsl_3_d_slidemin_test.nim
    title: verify/extra/dp/aoj_dsl_3_d_slidemin_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SLIDEMIN_HPP:\n  const ATCODER_SLIDEMIN_HPP* =\
    \ 1\n  import std/deques\n\n  proc slideMin*[T](v:seq[T], k:int):seq[T] =\n  \
    \  var deq = initDeque[T]()\n    result = newSeq[T]()\n    for i in 0..<v.len:\n\
    \      while deq.len > 0 and v[deq[^1]] >= v[i]:\n        discard deq.popLast()\n\
    \      deq.addLast(i)\n      if i - k + 1 >= 0:\n        result.add(v[deq[0]])\n\
    \        if deq[0] == i - k + 1: deq.popFirst()\n  proc slideMax*[T](v:seq[T],\
    \ k:int):seq[T] =\n    var v = v\n    for i in 0..<v.len: v[i] = -v[i]\n    result\
    \ = slideMin(v, k)\n    for i in 0..<result.len: result[i] = -result[i]\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/dp/slide_min.nim
  requiredBy: []
  timestamp: '2020-12-31 00:01:54+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/dp/aoj_dsl_3_d_slidemin_test.nim
  - verify/extra/dp/aoj_dsl_3_d_slidemin_test.nim
documentation_of: atcoder/extra/dp/slide_min.nim
layout: document
redirect_from:
- /library/atcoder/extra/dp/slide_min.nim
- /library/atcoder/extra/dp/slide_min.nim.html
title: atcoder/extra/dp/slide_min.nim
---
