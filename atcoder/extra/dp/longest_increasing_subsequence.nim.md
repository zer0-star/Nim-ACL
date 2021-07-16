---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/dp/aoj_dpl_1_d_LIS_test.nim
    title: verify/extra/dp/aoj_dpl_1_d_LIS_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/dp/aoj_dpl_1_d_LIS_test.nim
    title: verify/extra/dp/aoj_dpl_1_d_LIS_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_LONGEST_INCREASING_SUBSEQUENCE_HPP:\n  const ATCODER_LONGEST_INCREASING_SUBSEQUENCE_HPP*\
    \ = 1\n  proc longestIncreasingSubsequence*[T](a:openArray[T], strict:static[bool]\
    \ = false, getSeq:static[bool] = false):auto =\n    var lis = newSeq[T]()\n  \
    \  when getSeq:\n      var\n        tail = -1\n        prev = newSeq[int](a.len)\n\
    \        lis_i = newSeq[int]()\n    for i,p in a:\n      var it: int\n      when\
    \ strict: it = lis.lowerBound(p)\n      else: it = lis.upperBound(p)\n      if\
    \ it == lis.len:\n        lis.add(p)\n        when getSeq:\n          tail = i\n\
    \          prev[i] = if lis_i.len > 0: lis_i[^1] else: -1\n          lis_i.add(i)\n\
    \      else:\n        lis[it] = p\n        when getSeq:\n          lis_i[it] =\
    \ i\n          prev[i] = if it > 0: lis_i[it - 1] else: -1\n    when getSeq:\n\
    \      var i = tail\n      var a = newSeq[int]()\n      while i != -1:\n     \
    \   a.add(i)\n        i = prev[i]\n      a.reverse\n      return a\n    else:\n\
    \      return lis.len\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/dp/longest_increasing_subsequence.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/dp/aoj_dpl_1_d_LIS_test.nim
  - verify/extra/dp/aoj_dpl_1_d_LIS_test.nim
documentation_of: atcoder/extra/dp/longest_increasing_subsequence.nim
layout: document
redirect_from:
- /library/atcoder/extra/dp/longest_increasing_subsequence.nim
- /library/atcoder/extra/dp/longest_increasing_subsequence.nim.html
title: atcoder/extra/dp/longest_increasing_subsequence.nim
---
