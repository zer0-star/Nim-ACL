---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
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
  code: "when not declared ATCODER_CHAEMON_WARLUS_OPERATOR_HPP:\n  const ATCODER_CHAEMON_WARLUS_OPERATOR_HPP*\
    \ = 1\n  import strformat, macros\n  proc discardableId*[T](x: T): T {.discardable.}\
    \ = x\n\n  proc warlusImpl(x, y:string):string =\n    fmt\"\"\"when declaredInScope({x}):{'\\\
    n'} {x} = {y}{'\\n'}else:{'\\n'}  var {x} = {y}{'\\n'}\"\"\"\n\n  macro `:=`*(x,\
    \ y: untyped): untyped =\n    var strBody = \"\"\n    if x.kind == nnkCurly:\n\
    \      for i,xi in x: strBody &= warlusImpl(xi.repr, y.repr)\n    elif x.kind\
    \ == nnkPar:\n      for i,xi in x: strBody &= warlusImpl(xi.repr, y[i].repr)\n\
    \    else:\n      strBody &= warlusImpl(x.repr, y.repr)\n      strBody &= fmt\"\
    discardableId({x.repr})\"\n    parseStmt(strBody)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/warlus_operator.nim
  requiredBy:
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/warlus_operator.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/warlus_operator.nim
- /library/atcoder/extra/other/warlus_operator.nim.html
title: atcoder/extra/other/warlus_operator.nim
---