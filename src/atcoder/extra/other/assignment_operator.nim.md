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
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/header.nim
    title: atcoder/extra/header/header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/header.nim
    title: atcoder/extra/header/header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/header.nim
    title: atcoder/extra/header/header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/header.nim
    title: atcoder/extra/header/header.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
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
  code: "when not declared ATCODER_ASSIGNMENT_OPERATOR_HPP:\n  import std/macros,\
    \ std/strformat\n  const ATCODER_ASSIGNMENT_OPERATOR_HPP* = 1\n  proc `max=`*[S,\
    \ T](a: var S, b: T):bool {.discardable.} =\n    return if a < b: a = b; true\
    \ else: false\n  proc `min=`*[S, T](a: var S, b: T):bool {.discardable.} =\n \
    \   return if a > b: a = b; true else: false\n  template `>?=`*(x,y:typed):bool\
    \ = x.max= y\n  template `<?=`*(x,y:typed):bool = x.min= y\n  proc `//`*[T:SomeInteger](x,y:T):T\
    \ = x div y\n  proc `%`*[T:SomeInteger](x,y:T):T = x mod y\n  macro generateAssignmentOperator*(ops:varargs[untyped])\
    \ =\n    var strBody = \"\"\n    for op in ops:\n      let op = op.repr\n    \
    \  var op_raw = op\n      if op_raw[0] == '`':\n        op_raw = op_raw[1..^2]\n\
    \      strBody &= fmt\"\"\"proc `{op_raw}=`*[S, T](a:var S, b:T):auto {{.inline\
    \ discardable.}} = (mixin {op};a = `{op_raw}`(a, b);return a){'\\n'}\"\"\"\n \
    \   parseStmt(strBody)\n  generateAssignmentOperator(`mod`, `div`, `and`, `or`,\
    \ `xor`, `shr`, `shl`, `<<`, `>>`, `%`, `//`, `&`, `|`, `^`)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/assignment_operator.nim
  requiredBy:
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/header.nim
  - atcoder/extra/header/header.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/header.nim
  - atcoder/extra/header/header.nim
  timestamp: '2022-07-03 22:20:00+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/assignment_operator.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/assignment_operator.nim
- /library/atcoder/extra/other/assignment_operator.nim.html
title: atcoder/extra/other/assignment_operator.nim
---
