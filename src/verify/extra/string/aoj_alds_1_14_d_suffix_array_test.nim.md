---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/string/suffix_array_utils.nim
    title: atcoder/extra/string/suffix_array_utils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/string/suffix_array_utils.nim
    title: atcoder/extra/string/suffix_array_utils.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_D
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_D
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_D\n\
    \ninclude atcoder/header\n#import atcoder/string\nimport atcoder/extra/string/suffix_array_utils\n\
    \nproc main() =\n  let\n    S = nextString()\n    Q = nextInt()\n\n  var sa =\
    \ S.initSuffixArray\n  for i in 0..<Q:\n    let T = nextString()\n    let range\
    \ = sa.lowerUpperBound(T)\n    echo if range[0] != range[1]: 1 else: 0\n\nmain()\n"
  dependsOn:
  - atcoder/extra/string/suffix_array_utils.nim
  - atcoder/extra/string/suffix_array_utils.nim
  - atcoder/header.nim
  - atcoder/string.nim
  - atcoder/string.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
  requiredBy: []
  timestamp: '2022-07-03 22:20:00+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
layout: document
redirect_from:
- /verify/verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
- /verify/verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim.html
title: verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
---
