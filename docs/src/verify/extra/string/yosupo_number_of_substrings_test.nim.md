---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/string/suffix_automaton.nim
    title: atcoder/extra/string/suffix_automaton.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/string/suffix_automaton.nim
    title: atcoder/extra/string/suffix_automaton.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    PROBLEM: https://judge.yosupo.jp/problem/number_of_substrings
    links:
    - https://judge.yosupo.jp/problem/number_of_substrings
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/number_of_substrings\n\
    \ninclude atcoder/header\ninclude atcoder/extra/string/suffix_automaton\n\nproc\
    \ main() =\n  let s = nextString()\n  var sa = initSuffixautomaton[char](s)\n\
    \  var idx=sa.toposort()\n  let n = sa.x.len\n  var cnt = newSeq[int](n)\n  var\
    \ ans = -1\n  cnt[0] = 1\n  for i in idx:\n    ans += cnt[i]\n    for k,v in sa[i].to:\n\
    \      cnt[v] += cnt[i]\n  \n  echo ans\n\nmain()\n"
  dependsOn:
  - atcoder/extra/string/suffix_automaton.nim
  - atcoder/header.nim
  - atcoder/extra/string/suffix_automaton.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/string/yosupo_number_of_substrings_test.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/string/yosupo_number_of_substrings_test.nim
layout: document
redirect_from:
- /verify/verify/extra/string/yosupo_number_of_substrings_test.nim
- /verify/verify/extra/string/yosupo_number_of_substrings_test.nim.html
title: verify/extra/string/yosupo_number_of_substrings_test.nim
---
