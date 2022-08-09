---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_D
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "#define PROBLEM \"http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=ALDS1_14_D\"\
    \n\ninclude \"../../template/template.nim\"\n\ninclude \"../aho_corasick.nim\"\
    \n\nproc main() =\n  let\n    S = nextString()\n    Q = nextInt()\n#  var a =\
    \ initAhoCorasick(26, 'a'.ord);\n  var a = initAhoCorasick('z'.ord + 1 - '0'.ord,\
    \ '0'.ord);\n  for i in 0..<Q:\n    let T = nextString()\n    a.add(T)\n  a.build(false)\n\
    \  var\n    ans = newSeq[int](Q)\n    r = a.match(S)\n  for k,v in r:\n    ans[k]\
    \ = 1\n  for t in ans: echo t\n\nmain()\n"
  dependsOn: []
  isVerificationFile: false
  path: verify/extra/string/aoj_alds_1_14_d_aho_corasick_test_backup.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: verify/extra/string/aoj_alds_1_14_d_aho_corasick_test_backup.nim
layout: document
redirect_from:
- /library/verify/extra/string/aoj_alds_1_14_d_aho_corasick_test_backup.nim
- /library/verify/extra/string/aoj_alds_1_14_d_aho_corasick_test_backup.nim.html
title: verify/extra/string/aoj_alds_1_14_d_aho_corasick_test_backup.nim
---
