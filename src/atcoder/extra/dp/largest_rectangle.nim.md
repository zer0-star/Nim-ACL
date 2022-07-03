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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "proc largestRectangle[T](height:seq[T]):T =\n  var\n    st = newSeq[int]()\n\
    \    height = height\n  height.add(0)\n  var left = newSeq[int](height.len)\n\
    \  var ret = T(0)\n  for i in 0..<height.len:\n    while st.len > 0 and height[st[^1]]\
    \ >= height[i]:\n      ret = max(ret, T(i - left[st[^1]] - 1) * height[st[^1]])\n\
    \      discard st.pop()\n    left[i] = if st.len == 0: -1 else: st[^1]\n    st.add(i)\n\
    \  return ret\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/dp/largest_rectangle.nim
  requiredBy: []
  timestamp: '2020-12-05 23:18:49+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/dp/largest_rectangle.nim
layout: document
redirect_from:
- /library/atcoder/extra/dp/largest_rectangle.nim
- /library/atcoder/extra/dp/largest_rectangle.nim.html
title: atcoder/extra/dp/largest_rectangle.nim
---
