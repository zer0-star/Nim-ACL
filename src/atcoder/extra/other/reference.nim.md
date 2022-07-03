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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_REFERENCE_HPP:\n  const ATCODER_REFERENCE_HPP*\
    \ = 1\n  import std/macros, std/strformat\n\n  template byaddr*(lhs, typ, ex)\
    \ =\n    when typ is typeof(nil):\n      let tmp = addr(ex)\n    else:\n     \
    \ let tmp: ptr typ = addr(ex)\n    template lhs: untyped = tmp[]\n\n  macro `=&`*(lhs,\
    \ rhs:untyped) =\n    parseStmt(fmt\"\"\"byaddr({lhs.repr}, {rhs.repr}.type, {rhs.repr})\"\
    \"\")\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/reference.nim
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
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/reference.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/reference.nim
- /library/atcoder/extra/other/reference.nim.html
title: atcoder/extra/other/reference.nim
---
