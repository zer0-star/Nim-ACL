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
  - icon: ':question:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':question:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':question:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':question:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
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
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_cycle_detection_test.nim
    title: verify/extra/graph/yosupo_cycle_detection_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/graph/yosupo_cycle_detection_test.nim
    title: verify/extra/graph/yosupo_cycle_detection_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
    title: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
    title: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
    title: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
    title: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_staticrmq_test.nim
    title: verify/extra/structure/yosupo_staticrmq_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_staticrmq_test.nim
    title: verify/extra/structure/yosupo_staticrmq_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':question:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_INTERNAL_UNDERSCORED_CALLS_HPP:\n  const ATCODER_INTERNAL_UNDERSCORED_CALLS_HPP*\
    \ = 1\n  import macros\n\n  proc underscoredCall(n, arg0: NimNode): NimNode =\n\
    \    proc underscorePos(n: NimNode): int =\n      for i in 1 ..< n.len:\n    \
    \    if n[i].eqIdent(\"_\"): return i\n      return 0\n\n    if n.kind in nnkCallKinds:\n\
    \      result = copyNimNode(n)\n      result.add n[0]\n\n      let u = underscorePos(n)\n\
    \      for i in 1..u-1: result.add n[i]\n      result.add arg0\n      for i in\
    \ u+1..n.len-1: result.add n[i]\n    elif n.kind in {nnkAsgn, nnkExprEqExpr}:\n\
    \      var field = n[0]\n      if n[0].kind == nnkDotExpr and n[0][0].eqIdent(\"\
    _\"):\n        # handle _.field = ...\n        field = n[0][1]\n      result =\
    \ newDotExpr(arg0, field).newAssignment n[1]\n    else:\n      # handle e.g. 'x.dup(sort)'\n\
    \      result = newNimNode(nnkCall, n)\n      result.add n\n      result.add arg0\n\
    \n  proc underscoredCalls*(result, calls, arg0: NimNode) =\n    expectKind calls,\
    \ {nnkArgList, nnkStmtList, nnkStmtListExpr}\n\n    for call in calls:\n     \
    \ if call.kind in {nnkStmtList, nnkStmtListExpr}:\n        underscoredCalls(result,\
    \ call, arg0)\n      else:\n        result.add underscoredCall(call, arg0)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/internal_underscored_calls.nim
  requiredBy:
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/other/internal_sugar.nim
  - atcoder/extra/other/internal_sugar.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/other/internal_sugar.nim
  - atcoder/extra/other/internal_sugar.nim
  timestamp: '2020-12-05 23:18:49+09:00'
  verificationStatus: LIBRARY_SOME_WA
  verifiedWith:
  - verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
  - verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
  - verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - verify/extra/structure/yosupo_staticrmq_test.nim
  - verify/extra/structure/yosupo_staticrmq_test.nim
  - verify/extra/graph/yosupo_cycle_detection_test.nim
  - verify/extra/graph/yosupo_cycle_detection_test.nim
documentation_of: atcoder/extra/other/internal_underscored_calls.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/internal_underscored_calls.nim
- /library/atcoder/extra/other/internal_underscored_calls.nim.html
title: atcoder/extra/other/internal_underscored_calls.nim
---
