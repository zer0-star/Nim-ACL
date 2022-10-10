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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import macros\nmacro Please(x): untyped = nnkStmtList.newTree()\n\nPlease\
    \ use Nim-ACL\nPlease use Nim-ACL\nPlease use Nim-ACL\n\n\n\nimport macros;macro\
    \ ImportExpand(s:untyped):untyped = parseStmt($s[2])\nwhen not declared ATCODER_SHADOWING_HPP:\n\
    \  const ATCODER_SHADOWING_HPP* = 1\n  import macros\n  proc discardableId*[T](x:\
    \ T): T {.discardable.} = x\n\n  macro shadow*(v:varargs[untyped]): untyped =\n\
    \    result = newStmtList()\n    for x in v:\n      result.add quote do:\n   \
    \     var `x` = `x`\n\nproc f(a, b, c:int) =\n  shadow a, b, c\n  a.inc\n\necho\
    \ f(1, 2, 3)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/combined.nim
  requiredBy: []
  timestamp: '2022-10-10 21:34:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/combined.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/combined.nim
- /library/atcoder/extra/other/combined.nim.html
title: atcoder/extra/other/combined.nim
---
