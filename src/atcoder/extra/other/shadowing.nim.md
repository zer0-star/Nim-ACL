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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SHADOWING_HPP:\n  const ATCODER_SHADOWING_HPP*\
    \ = 1\n  import macros\n\n  macro shadow*(v:varargs[untyped]): untyped =\n   \
    \ result = newStmtList()\n    for x in v:\n      result.add quote do:\n      \
    \  var `x` {.used.} = `x`\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/shadowing.nim
  requiredBy:
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  timestamp: '2022-10-10 21:34:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/shadowing.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/shadowing.nim
- /library/atcoder/extra/other/shadowing.nim.html
title: atcoder/extra/other/shadowing.nim
---
