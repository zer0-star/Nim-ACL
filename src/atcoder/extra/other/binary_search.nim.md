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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_BINARY_SEARCH_HPP:\n  const ATCODER_BINARY_SEARCH_HPP*\
    \ = 1\n\n  proc minLeft*(f:proc(x:int):bool, s:Slice[int]):int =\n    var (l,\
    \ r) = (s.a - 1, s.b)\n    if not f(r): return s.b + 1\n    while r - l > 1:\n\
    \      let d = (r - l) shr 1\n      let m = l + d\n      if f(m): r = m\n    \
    \  else: l = m\n    return r\n  proc maxRight*(f:proc(x:int):bool, s:Slice[int]):int\
    \ =\n    var (l, r) = (s.a, s.b + 1)\n    if not f(l): return s.a - 1\n    while\
    \ r - l > 1:\n      let d = (r - l) shr 1\n      let m = l + d\n      if f(m):\
    \ l = m\n      else: r = m\n    return l\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/binary_search.nim
  requiredBy: []
  timestamp: '2021-05-19 22:57:49+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/binary_search.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/binary_search.nim
- /library/atcoder/extra/other/binary_search.nim.html
title: atcoder/extra/other/binary_search.nim
---
