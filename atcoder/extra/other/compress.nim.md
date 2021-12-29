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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_COMPRESS_HPP:\n  const ATCODER_COMPRESS_HPP* =\
    \ 1\n  type Compress[T] = seq[T]\n\n  proc build*[T](v:var Compress[T]) =\n  \
    \  v = v.toSet.toSeq.sorted\n  proc initCompress*[T](a:varargs[seq[T]]):Compress[T]\
    \ =\n    if a.len == 0:return\n    for p in a:\n      for x in p: result.add(x)\n\
    \    result.build\n  proc id*[T](c:Compress[T], a:T):int =\n    result = c.binarySearch(a)\n\
    \    assert result != -1, \"Error: No such value: \" & $a\n  proc `{}`*[T](c:Compress[T],\
    \ a:T):int = c.id(a)\n  proc val*[T](c:Compress[T], i:int):T = c[i]\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/compress.nim
  requiredBy: []
  timestamp: '2021-12-11 18:27:17+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/compress.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/compress.nim
- /library/atcoder/extra/other/compress.nim.html
title: atcoder/extra/other/compress.nim
---
