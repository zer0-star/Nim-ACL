---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/convolution.nim
    title: src/nim_acl/convolution.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/convolution.nim
    title: src/nim_acl/convolution.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/segtree.nim
    title: src/nim_acl/segtree.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/segtree.nim
    title: src/nim_acl/segtree.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/extra/structure/universal_segtree.nim
    title: src/nim_acl/extra/structure/universal_segtree.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/extra/structure/universal_segtree.nim
    title: src/nim_acl/extra/structure/universal_segtree.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/lazysegtree.nim
    title: src/nim_acl/lazysegtree.nim
  - icon: ':heavy_check_mark:'
    path: src/nim_acl/lazysegtree.nim
    title: src/nim_acl/lazysegtree.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_test.nim
    title: verify/lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lazy_segtree_test.nim
    title: verify/lazy_segtree_test.nim
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
    path: verify/extra_lazy_segtree_test.nim
    title: verify/extra_lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_lazy_segtree_test.nim
    title: verify/extra_lazy_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_segtree_test.nim
    title: verify/extra_segtree_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra_segtree_test.nim
    title: verify/extra_segtree_test.nim
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_INTERNAL_BITOP_HPP:\n  const ATCODER_INTERNAL_BITOP_HPP*\
    \ = 1\n  import bitops\n\n#ifdef _MSC_VER\n#include <intrin.h>\n#endif\n\n# @param\
    \ n `0 <= n`\n# @return minimum non-negative `x` s.t. `n <= 2**x`\n  proc ceil_pow2*(n:int):int\
    \ =\n    var x = 0\n    while (1'u shl x) < n.uint: x.inc\n    return x\n# @param\
    \ n `1 <= n`\n# @return minimum non-negative `x` s.t. `(n & (1 << x)) != 0`\n\
    \  proc bsf*(n:uint):int =\n    return countTrailingZeroBits(n)\n"
  dependsOn: []
  isVerificationFile: false
  path: src/nim_acl/internal_bit.nim
  requiredBy:
  - src/nim_acl/convolution.nim
  - src/nim_acl/convolution.nim
  - src/nim_acl/segtree.nim
  - src/nim_acl/segtree.nim
  - src/nim_acl/extra/structure/universal_segtree.nim
  - src/nim_acl/extra/structure/universal_segtree.nim
  - src/nim_acl/lazysegtree.nim
  - src/nim_acl/lazysegtree.nim
  timestamp: '2020-09-14 18:38:25+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/lazy_segtree_test.nim
  - verify/lazy_segtree_test.nim
  - verify/lazy_segtree_dynamicmodint_test.nim
  - verify/lazy_segtree_dynamicmodint_test.nim
  - verify/segtree_test.nim
  - verify/segtree_test.nim
  - verify/convolution_test.nim
  - verify/convolution_test.nim
  - verify/extra_lazy_segtree_test.nim
  - verify/extra_lazy_segtree_test.nim
  - verify/extra_segtree_test.nim
  - verify/extra_segtree_test.nim
documentation_of: src/nim_acl/internal_bit.nim
layout: document
redirect_from:
- /library/src/nim_acl/internal_bit.nim
- /library/src/nim_acl/internal_bit.nim.html
title: src/nim_acl/internal_bit.nim
---
