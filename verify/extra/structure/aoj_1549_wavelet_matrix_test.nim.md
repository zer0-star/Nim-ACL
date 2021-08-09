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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1549
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1549
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1549\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/structure/wavelet_matrix\n\n\
    let n = nextInt()\nconst OFS = 10^6\nvar a = newSeqWith(n, nextInt() + OFS)\n\
    var wm = initCompressedWaveletMatrix(a, 17)\n\nlet q = nextInt()\nfor i in 0..<q:\n\
    \  let\n    l = nextInt()\n    r = nextInt() + 1\n    d = nextInt() + OFS\n  var\
    \ ans = OFS * 2\n  if wm.rank(d, l) < wm.rank(d, r):\n    ans = 0\n  else:\n \
    \   let succ = wm.next_value(l ..< r, d)\n    if succ != -1: ans.min= abs(succ\
    \ - d)\n    let pred = wm.prev_value(l ..< r, d)\n    if pred != -1: ans.min=\
    \ abs(pred - d)\n  echo ans\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/structure/succinct_indexable_dictionary.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/succinct_indexable_dictionary.nim
  - atcoder/header.nim
  - atcoder/extra/structure/wavelet_matrix.nim
  - atcoder/extra/structure/wavelet_matrix.nim
  - atcoder/rangeutils.nim
  isVerificationFile: true
  path: verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
- /verify/verify/extra/structure/aoj_1549_wavelet_matrix_test.nim.html
title: verify/extra/structure/aoj_1549_wavelet_matrix_test.nim
---
