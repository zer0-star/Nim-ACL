---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_test.nim
    title: verify/lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_test.nim
    title: verify/lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/scc_test.nim
    title: verify/scc_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/scc_test.nim
    title: verify/scc_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/z_algorithm_test.nim
    title: verify/z_algorithm_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/z_algorithm_test.nim
    title: verify/z_algorithm_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_dynamicmodint_test.nim
    title: verify/lazy_segtree_dynamicmodint_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_dynamicmodint_test.nim
    title: verify/lazy_segtree_dynamicmodint_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/segtree_test.nim
    title: verify/segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/segtree_test.nim
    title: verify/segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/convolution_test.nim
    title: verify/convolution_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/convolution_test.nim
    title: verify/convolution_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/twosat_test.nim
    title: verify/twosat_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/floor_sum_test.nim
    title: verify/floor_sum_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/floor_sum_test.nim
    title: verify/floor_sum_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/suffix_array_test.nim
    title: verify/suffix_array_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/suffix_array_test.nim
    title: verify/suffix_array_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lcp_array_test.nim
    title: verify/lcp_array_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lcp_array_test.nim
    title: verify/lcp_array_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_lazy_segtree_test.nim
    title: verify/extra_lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_lazy_segtree_test.nim
    title: verify/extra_lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/shortest_path_test.nim
    title: verify/shortest_path_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/shortest_path_test.nim
    title: verify/shortest_path_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/map_test.nim
    title: verify/map_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_segtree_test.nim
    title: verify/extra_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_segtree_test.nim
    title: verify/extra_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/fenwick_tree_test.nim
    title: verify/fenwick_tree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/fenwick_tree_test.nim
    title: verify/fenwick_tree_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_HEADER_HPP:\n  {.hints:off checks:off assertions:on\
    \ checks:off optimization:speed .}\n  const ATCODER_HEADER_HPP = 1\n  import algorithm,\
    \ sequtils, tables, macros, math, sets, strutils, streams, strformat, sugar\n\
    \  \n  proc scanf*(formatstr: cstring){.header: \"<stdio.h>\", varargs.}\n  proc\
    \ getchar*(): char {.header: \"<stdio.h>\", varargs.}\n  proc nextInt*(base:int\
    \ = 0): int =\n    scanf(\"%lld\",addr result)\n    result -= base\n  proc nextFloat*():\
    \ float = scanf(\"%lf\",addr result)\n  proc nextString*(): string =\n    var\
    \ get = false;result = \"\"\n    while true:\n      var c = getchar()\n      if\
    \ int(c) > int(' '): get = true;result.add(c)\n      elif get: break\n  template\
    \ `max=`*(x,y:typed):void = x = max(x,y)\n  template `min=`*(x,y:typed):void =\
    \ x = min(x,y)\n  template inf*(T): untyped = \n    when T is SomeFloat: T(Inf)\n\
    \    elif T is SomeInteger: ((T(1) shl T(sizeof(T)*8-2)) - (T(1) shl T(sizeof(T)*4-1)))\n\
    \    else: assert(false)\n"
  dependsOn: []
  isVerificationFile: false
  path: src/nim_acl/header.nim
  requiredBy: []
  timestamp: '2020-09-14 00:37:28+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/lazy_segtree_test.nim
  - verify/lazy_segtree_test.nim
  - verify/scc_test.nim
  - verify/scc_test.nim
  - verify/z_algorithm_test.nim
  - verify/z_algorithm_test.nim
  - verify/lazy_segtree_dynamicmodint_test.nim
  - verify/lazy_segtree_dynamicmodint_test.nim
  - verify/segtree_test.nim
  - verify/segtree_test.nim
  - verify/convolution_test.nim
  - verify/convolution_test.nim
  - verify/twosat_test.nim
  - verify/twosat_test.nim
  - verify/floor_sum_test.nim
  - verify/floor_sum_test.nim
  - verify/suffix_array_test.nim
  - verify/suffix_array_test.nim
  - verify/lcp_array_test.nim
  - verify/lcp_array_test.nim
  - verify/extra_lazy_segtree_test.nim
  - verify/extra_lazy_segtree_test.nim
  - verify/shortest_path_test.nim
  - verify/shortest_path_test.nim
  - verify/map_test.nim
  - verify/map_test.nim
  - verify/extra_segtree_test.nim
  - verify/extra_segtree_test.nim
  - verify/fenwick_tree_test.nim
  - verify/fenwick_tree_test.nim
documentation_of: src/nim_acl/header.nim
layout: document
redirect_from:
- /library/src/nim_acl/header.nim
- /library/src/nim_acl/header.nim.html
title: src/nim_acl/header.nim
---
