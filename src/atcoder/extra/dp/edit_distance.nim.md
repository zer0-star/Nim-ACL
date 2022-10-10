---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# editDistance(S, T:string) {{{\nimport sequtils\n\nproc editDistance(S,T:string):int\
    \ =\n  let\n    N = S.len\n    M = T.len\n  dump(S)\n  dump(T)\n  var dp = newSeqWith(N\
    \ + 1, newSeqWith(M + 1, N + M))\n  for i in 0..N: dp[i][0] = i\n  for j in 0..M:\
    \ dp[0][j] = j\n  for i in 1..N:\n    for j in 1..M:\n      dp[i][j] = min(dp[i][j],\
    \ dp[i - 1][j] + 1)\n      dp[i][j] = min(dp[i][j], dp[i][j - 1] + 1)\n      dp[i][j]\
    \ = min(dp[i][j], dp[i - 1][j - 1] + (if S[i - 1] != T[j - 1]: 1 else: 0))\n \
    \ return dp[N][M]\n# }}}\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/dp/edit_distance.nim
  requiredBy: []
  timestamp: '2020-12-05 23:18:49+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/dp/edit_distance.nim
layout: document
redirect_from:
- /library/atcoder/extra/dp/edit_distance.nim
- /library/atcoder/extra/dp/edit_distance.nim.html
title: atcoder/extra/dp/edit_distance.nim
---
