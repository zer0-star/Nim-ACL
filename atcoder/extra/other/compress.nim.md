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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_COMPRESS_HPP:\n  const ATCODER_COMPRESS_HPP* =\
    \ 1\n  type Compless[T] = seq[T]\n\n  proc initCompress*[T](a:varargs[seq[T]]):seq[T]\
    \ =\n    var v = newSeq[int]()\n    for p in a:\n      for x in p: v.add(x)\n\
    \    v = v.toSet.toSeq.sorted\n    return v\n\n  proc id*[T](c:Compless[T], a:T):int\
    \ =\n    result = c.binarySearch(a)\n    assert result != -1, \"Error: No such\
    \ value: \" & $a\n  proc val*[T](c:Compless[T], i:int):T = c[i]\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/compress.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/compress.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/compress.nim
- /library/atcoder/extra/other/compress.nim.html
title: atcoder/extra/other/compress.nim
---
