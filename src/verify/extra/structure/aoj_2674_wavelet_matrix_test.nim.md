---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/succinct_indexable_dictionary.nim
    title: atcoder/extra/structure/succinct_indexable_dictionary.nim
  - icon: ':x:'
    path: atcoder/extra/structure/succinct_indexable_dictionary.nim
    title: atcoder/extra/structure/succinct_indexable_dictionary.nim
  - icon: ':x:'
    path: atcoder/extra/structure/wavelet_matrix.nim
    title: atcoder/extra/structure/wavelet_matrix.nim
  - icon: ':x:'
    path: atcoder/extra/structure/wavelet_matrix.nim
    title: atcoder/extra/structure/wavelet_matrix.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=2674
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=2674
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=2674\n\
    \ninclude atcoder/header\n\n\nimport atcoder/extra/structure/wavelet_matrix\n\n\
    let N = nextInt()\nlet X = newSeqWith(N, nextInt() + 5 * 10^8)\n\nvar matrix =\
    \ initCompressedWaveletMatrix(X, 30)\nlet Q = nextInt()\nfor _ in 0..<Q:\n  let\
    \ L, R = nextInt() - 1\n  let E = nextInt()\n  echo (R - L + 1) - matrix.range_freq(L\
    \ .. R, min(X[L], X[R]) - E, max(X[L], X[R]) + E + 1)\n"
  dependsOn:
  - atcoder/extra/structure/wavelet_matrix.nim
  - atcoder/extra/structure/wavelet_matrix.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/succinct_indexable_dictionary.nim
  - atcoder/rangeutils.nim
  - atcoder/header.nim
  - atcoder/extra/structure/succinct_indexable_dictionary.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
  requiredBy: []
  timestamp: '2022-09-24 20:04:56+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
- /verify/verify/extra/structure/aoj_2674_wavelet_matrix_test.nim.html
title: verify/extra/structure/aoj_2674_wavelet_matrix_test.nim
---
