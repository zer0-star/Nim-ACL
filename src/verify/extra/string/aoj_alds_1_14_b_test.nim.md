---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_B
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_B
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_B\n\
    \ninclude \"template/template.nim\"\n\ninclude \"string/rolling_hash.nim\"\n\n\
    proc main() =\n  let T, P = nextString()\n  var\n    rh = initRollingHash(T)\n\
    \    rh2 = initRollingHash(P)\n  for i in 0..T.len - P.len:\n    if rh.get(i..<i\
    \ + P.len) == rh2.get(0..<P.len): echo i\n\nmain()\n"
  dependsOn: []
  isVerificationFile: true
  path: verify/extra/string/aoj_alds_1_14_b_test.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/string/aoj_alds_1_14_b_test.nim
layout: document
redirect_from:
- /verify/verify/extra/string/aoj_alds_1_14_b_test.nim
- /verify/verify/extra/string/aoj_alds_1_14_b_test.nim.html
title: verify/extra/string/aoj_alds_1_14_b_test.nim
---
