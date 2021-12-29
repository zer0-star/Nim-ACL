---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/succinct_indexable_dictionary.nim
    title: atcoder/extra/structure/succinct_indexable_dictionary.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/succinct_indexable_dictionary.nim
    title: atcoder/extra/structure/succinct_indexable_dictionary.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/wavelet_matrix.nim
    title: atcoder/extra/structure/wavelet_matrix.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/structure/wavelet_matrix.nim
    title: atcoder/extra/structure/wavelet_matrix.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/range_kth_smallest
    links:
    - https://judge.yosupo.jp/problem/range_kth_smallest
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/range_kth_smallest\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/structure/wavelet_matrix\n\n\
    let N, Q = nextInt()\nlet A = newSeqWith(N, nextInt())\nvar mat = initCompressedWaveletMatrix(A,\
    \ 18)\nfor i in 0..<Q:\n  let a, b, c = nextInt()\n  echo mat.kth_smallest(a ..<\
    \ b, c)\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/header.nim
  - atcoder/extra/structure/succinct_indexable_dictionary.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/wavelet_matrix.nim
  - atcoder/extra/structure/succinct_indexable_dictionary.nim
  - atcoder/extra/structure/wavelet_matrix.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_range_kth_smallest_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_range_kth_smallest_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_range_kth_smallest_test.nim
- /verify/verify/extra/structure/yosupo_range_kth_smallest_test.nim.html
title: verify/extra/structure/yosupo_range_kth_smallest_test.nim
---
