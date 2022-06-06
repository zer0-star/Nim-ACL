---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_D
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_D
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_D\n\
    \ninclude \"template/template.nim\"\ninclude \"string/suffix_array.nim\"\n\nproc\
    \ main() =\n  let\n    S = nextString()\n    Q = nextInt()\n\n  var sa = initSuffixArray(S);\n\
    \  for i in 0..<Q:\n    let T = nextString()\n    let range = sa.lowerUpperBound(T)\n\
    \    echo if range[0] != range[1]: 1 else: 0\n\nmain()\n"
  dependsOn: []
  isVerificationFile: true
  path: verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
layout: document
redirect_from:
- /verify/verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
- /verify/verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim.html
title: verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
---
