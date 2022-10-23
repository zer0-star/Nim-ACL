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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_FOLD_HPP:\n  const ATCODER_FOLD_HPP* = 1\n  proc\
    \ fold_associative*[T](v:seq[T], f:proc(a, b:T):T):T =\n    if v.len == 0: return\
    \ # \u4F55\u3082\u306A\u3044\u3082\u306E\u306E\u7A4D\u554F\u984C\n    var v =\
    \ v\n    while v.len >= 2:\n      var i = 0\n      for j in countup(0, v.len -\
    \ 1, 2):\n        v[i] =\n          if j + 1 < v.len:\n            f(v[j], v[j\
    \ + 1])\n          else:\n            v[j]\n        i.inc\n      v.setLen(i)\n\
    \    return v[0]\n  \n  # v[0] + v[0]*v[1] + v[0]*v[1]*v[2] + ...\n  proc fold_staircase_sum*[T](v:seq[T],\
    \ sum:proc(a, b:T):T, prod:proc(a, b:T):T):T =\n    proc fold_staircase_sum_sub(l,\
    \ r:int):tuple[p, s:T] =\n      doAssert l < r\n      if l + 1 == r: return (v[l],\
    \ v[l])\n      let m = (l + r) shr 1\n      let (pa, sa) = fold_staircase_sum_sub(l,\
    \ m)\n      let (pb, sb) = fold_staircase_sum_sub(m, r)\n      return (prod(pa,\
    \ pb), sum(sa, prod(pa, sb)))\n    if v.len == 0: return # \u6CE8\u610F\n    return\
    \ fold_staircase_sum_sub(0, v.len).s\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/fold.nim
  requiredBy: []
  timestamp: '2022-10-23 18:37:31+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/fold.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/fold.nim
- /library/atcoder/extra/other/fold.nim.html
title: atcoder/extra/other/fold.nim
---
