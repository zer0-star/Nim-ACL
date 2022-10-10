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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_CHAEMON_WARLUS_OPERATOR_HPP:\n  const ATCODER_CHAEMON_WARLUS_OPERATOR_HPP*\
    \ = 1\n  import macros\n  proc discardableId*[T](x: T): T {.discardable.} = x\n\
    \n  proc warlusImpl(x, y:NimNode):NimNode =\n    # \u3059\u3067\u306B\u5B9A\u7FA9\
    \u3055\u308C\u3066\u3044\u308B\u3082\u306E\u306B\u4EE3\u5165\u3059\u308B\u3088\
    \u3046\u306A\u4F7F\u3044\u65B9\u306F\u3042\u307E\u308A\u3057\u306A\u3044\n   \
    \ # \u307E\u305F\u3053\u306E\u66F8\u304D\u65B9\u3092\u3059\u308B\u3068\u95A2\u6570\
    \u3068\u304B\u3067\u4E0D\u4FBF\u306B\u306A\u308B\u3053\u3068\u304C\u591A\u3044\
    \u306E\u3067\u3069\u3046\u3057\u3088\u3046\u304B\n    #return quote do:\n    #\
    \  when declaredInScope(`x`):\n    #    `x` = `y`\n    #  else:\n    #    var\
    \ `x` = `y`\n    return quote do:\n      var `x` = `y`\n\n  macro `:=`*(x, y:\
    \ untyped): untyped =\n    result = newStmtList()\n    if x.kind == nnkCurly:\n\
    \      for i,xi in x: result.add warlusImpl(xi, y)\n    elif x.kind == nnkPar:\n\
    \      for i,xi in x: result.add warlusImpl(xi, y[i])\n    else:\n      result.add\
    \ warlusImpl(x, y)\n      result.add quote do:\n        discardableId(`x`)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/warlus_operator.nim
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
  - atcoder/extra/header/header.nim
  - atcoder/extra/header/header.nim
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
  - atcoder/extra/header/header.nim
  - atcoder/extra/header/header.nim
  timestamp: '2022-10-10 21:34:07+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/warlus_operator.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/warlus_operator.nim
- /library/atcoder/extra/other/warlus_operator.nim.html
title: atcoder/extra/other/warlus_operator.nim
---
