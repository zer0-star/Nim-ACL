---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':x:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':x:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
    title: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
    title: verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
    title: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
    title: verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
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
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - verify/extra/structure/yosupo_dynamic_tree_vertex_set_path_composite_link_cut_tree_test.nim
  - verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
  - verify/extra/structure/yosupo_point_set_range_composite_reversible_splay_tree_test.nim
documentation_of: atcoder/extra/other/reference.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/reference.nim
- /library/atcoder/extra/other/reference.nim.html
title: atcoder/extra/other/reference.nim
---
