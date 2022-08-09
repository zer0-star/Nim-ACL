---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/persistent_array.nim
    title: atcoder/extra/structure/persistent_array.nim
  - icon: ':x:'
    path: atcoder/extra/structure/persistent_array.nim
    title: atcoder/extra/structure/persistent_array.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/persistent_queue
    links:
    - https://judge.yosupo.jp/problem/persistent_queue
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/persistent_queue\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/structure/persistent_array\n\n\
    const M = 500000\nvar S: array[-1..M-1, tuple[a:PersistentArray[int], head, tail:int]]\n\
    \nproc main() =\n  let Q = nextInt()\n  S[-1] = (initPersistentArray(newSeq[int](M)),\
    \ 0, 0)\n  for i in 0..<Q:\n    let q, t = nextInt()\n    var (a, head, tail)\
    \ = S[t]\n    if q == 0:\n      let x = nextInt()\n      a[tail] = x\n      tail.inc\n\
    \    else:\n      echo a[head]\n      head.inc\n    S[i] = (a, head, tail)\n\n\
    main()\n"
  dependsOn:
  - atcoder/extra/structure/persistent_array.nim
  - atcoder/header.nim
  - atcoder/extra/structure/persistent_array.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_persistent_queue_test.nim
  requiredBy: []
  timestamp: '2021-12-11 23:59:27+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_persistent_queue_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_persistent_queue_test.nim
- /verify/verify/extra/structure/yosupo_persistent_queue_test.nim.html
title: verify/extra/structure/yosupo_persistent_queue_test.nim
---
