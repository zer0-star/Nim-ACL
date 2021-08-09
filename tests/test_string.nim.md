---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':question:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':question:'
    path: atcoder/extra/other/internal_underscored_calls.nim
    title: atcoder/extra/other/internal_underscored_calls.nim
  - icon: ':question:'
    path: atcoder/extra/other/internal_underscored_calls.nim
    title: atcoder/extra/other/internal_underscored_calls.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import std/unittest\nimport atcoder/string as string_lib\nimport std/sequtils,\
    \ std/algorithm\nimport std/math\ninclude atcoder/extra/other/internal_sugar\n\
    \nproc `<`(a, b:seq[int]):bool =\n  var i = 0\n  while true:\n    if i == b.len:\
    \ return false\n    elif i == a.len: return true\n    elif a[i] != b[i]: return\
    \ a[i] < b[i]\n    i.inc\n\nproc sa_naive(s:seq[int]):seq[int] =\n  let n = s.len\n\
    \  var sa = (0..<n).toSeq\n  sa.sort() do (l, r:int) -> int:\n    cmp[seq[int]](s[l..^1],\
    \ s[r..^1])\n  return sa\n\nproc lcp_naive(s, sa:seq[int]):seq[int] =\n  let n\
    \ = s.len\n  assert n > 0\n  var lcp = newSeq[int](n - 1)\n  for i in 0..<n-1:\n\
    \    let\n      l = sa[i]\n      r = sa[i + 1]\n    while l + lcp[i] < n and r\
    \ + lcp[i] < n and s[l + lcp[i]] == s[r + lcp[i]]: lcp[i].inc\n  return lcp\n\n\
    proc z_naive(s:seq[int]):seq[int] =\n  let n = s.len\n  var z = newSeq[int](n)\n\
    \  for i in 0..<n:\n    while i + z[i] < n and s[z[i]] == s[i + z[i]]: z[i].inc\n\
    \  return z\n\ntest \"StringTest, Empty\":\n  check newSeq[int]() == suffix_array(\"\
    \")\n  check newSeq[int]() == suffix_array(newSeq[int]())\n\n  check newSeq[int]()\
    \ == z_algorithm(\"\")\n  check newSeq[int]() == z_algorithm(newSeq[int]())\n\n\
    test \"StringTest, SALCPNaive\":\n  for n in 1..5:\n    let m = 4^n\n    for f\
    \ in 0..<m:\n      var\n        s = newSeq[int](n)\n        g = f\n        max_c\
    \ = 0\n      for i in 0..<n:\n        s[i] = g mod 4\n        max_c = max(max_c,\
    \ s[i])\n        g = g div 4\n      let sa = sa_naive(s)\n      check sa == suffix_array(s)\n\
    \      check sa == suffix_array(s, max_c)\n      check lcp_naive(s, sa) == lcp_array(s,\
    \ sa)\n\n  for n in 1..10:\n    let m = 2^n\n    for f in 0..<m:\n      var\n\
    \        s = newSeq[int](n)\n        g = f\n        max_c = 0\n      for i in\
    \ 0..<n:\n        s[i] = g mod 2\n        max_c = max(max_c, s[i])\n        g\
    \ = g div 2\n      let sa = sa_naive(s)\n      check sa == suffix_array(s)\n \
    \     check sa == suffix_array(s, max_c)\n      check lcp_naive(s, sa) == lcp_array(s,\
    \ sa)\n\ntest \"StringTest, InternalSANaiveNaive\":\n  for n in 1..5:\n    let\
    \ m = 4^n\n    for f in 0..<m:\n      var\n        s = newSeq[int](n)\n      \
    \  g = f\n      for i in 0..<n: \n        s[i] = g mod 4\n        g = g div 4\n\
    \n      let sa = string_lib.sa_naive(s)\n      check sa_naive(s) == sa\n\n  for\
    \ n in 1..10:\n    let m = 2^n\n    for f in 0..<m:\n      var s = newSeq[int](n)\n\
    \      var g = f\n      for i in 0..<n:\n        s[i] = g mod 2\n        g = g\
    \ div 2\n\n      let sa = string_lib.sa_naive(s)\n      check sa_naive(s) == sa\n\
    \ntest \"StringTest, InternalSADoublingNaive\":\n  for n in 1..5:\n    let m =\
    \ 4^n\n    for f in 0..<m:\n      var\n        s = newSeq[int](n)\n        g =\
    \ f\n      for i in 0..<n: \n        s[i] = g mod 4\n        g = g div 4\n\n \
    \     let sa = string_lib.sa_doubling(s)\n      check sa_naive(s) == sa\n\n  for\
    \ n in 1..10:\n    let m = 2^n\n    for f in 0..<m:\n      var s = newSeq[int](n)\n\
    \      var g = f\n      for i in 0..<n:\n        s[i] = g mod 2\n        g = g\
    \ div 2\n\n      let sa = string_lib.sa_doubling(s)\n      check sa_naive(s) ==\
    \ sa\n\ntest \"StringTest, InternalSAISNaive\":\n  for n in 1..5:\n    let m =\
    \ 4^n\n    for f in 0..<m:\n      var\n        s = newSeq[int](n)\n        g =\
    \ f\n      for i in 0..<n: \n        s[i] = g mod 4\n        g = g div 4\n\n \
    \     let sa = string_lib.sa_is(s, s.max, -1, -1)\n      check sa_naive(s) ==\
    \ sa\n\n  for n in 1..10:\n    let m = 2^n\n    for f in 0..<m:\n      var s =\
    \ newSeq[int](n)\n      var g = f\n      for i in 0..<n:\n        s[i] = g mod\
    \ 2\n        g = g div 2\n\n      let sa = string_lib.sa_is(s, s.max, -1, -1)\n\
    \      check sa_naive(s) == sa\n\ntest \"StringTest, SAAllATest\":\n  for n in\
    \ 1..100:\n    let s = newSeq[int](10)\n    check sa_naive(s) == suffix_array(s)\n\
    \    check sa_naive(s) == suffix_array(s, 10)\n    check sa_naive(s) == suffix_array(s,\
    \ 12)\n\ntest \"StringTest, SAAllABTest\":\n  for n in 1..100:\n#    var s = lc[i\
    \ mod 2 | (i <- 0..<n), int]\n    let s = collect(newSeq):\n      for i in 0..<n:\n\
    \        i mod 2\n    check sa_naive(s) == suffix_array(s)\n    check sa_naive(s)\
    \ == suffix_array(s, 3)\n  for n in 1..100:\n#    var s = lc[1 - i mod 2 | (i\
    \ <- 0..<n), int]\n    let s = collect(newSeq):\n      for i in 0..<n:\n     \
    \   1 - i mod 2\n    check sa_naive(s) == suffix_array(s)\n    check sa_naive(s)\
    \ == suffix_array(s, 3)\n\ntest \"StringTest, SA\":\n  let s = \"missisippi\"\n\
    \n  let sa = suffix_array(s)\n\n  let answer = [\n    \"i\",       # 9\n    \"\
    ippi\",    # 6\n    \"isippi\",    # 4\n    \"issisippi\",   # 1\n    \"missisippi\"\
    ,  # 0\n    \"pi\",      # 8\n    \"ppi\",     # 7\n    \"sippi\",     # 5\n \
    \   \"sisippi\",   # 3\n    \"ssisippi\",  # 2\n  ]\n\n  check answer.len == sa.len\n\
    \n  for i in 0..<sa.len:\n    check answer[i] == s.substr(sa[i])\n\ntest \"StringTest,\
    \ SASingle\":\n  check @[0] == suffix_array(@[0])\n  check @[0] == suffix_array(@[-1])\n\
    \  check @[0] == suffix_array(@[1]);\n  check @[0] == suffix_array(@[int.low])\n\
    \  check @[0] == suffix_array(@[int.high])\n\ntest \"StringTest, LCP\":\n  let\
    \ s = \"aab\"\n  let sa = suffix_array(s)\n  check @[0, 1, 2] == sa\n  let lcp\
    \ = lcp_array(s, sa)\n  check @[1, 0] == lcp\n\n  check lcp == lcp_array(@[0'i32,\
    \ 0'i32, 1'i32], sa)\n  check lcp == lcp_array(@[-100'i32, -100'i32, 100'i32],\
    \ sa)\n  check lcp == lcp_array(@[int32.low, int32.low, int32.high], sa)\n\n \
    \ check lcp == lcp_array(@[int64.low, int64.low, int64.high], sa)\n\n  check lcp\
    \ == lcp_array(@[uint32.low, uint32.low, uint32.high], sa)\n  check lcp == lcp_array(@[uint64.low,\
    \ uint64.low, uint64.high], sa)\n\ntest \"StringTest, ZAlgo\":\n  let\n    s =\
    \ \"abab\"\n    z = z_algorithm(s)\n  check @[4, 0, 2, 0] == z\n  check @[4, 0,\
    \ 2, 0] == z_algorithm(@[1, 10, 1, 10])\n  check z_naive(@[0, 0, 0, 0, 0, 0, 0])\
    \ == z_algorithm(@[0, 0, 0, 0, 0, 0, 0])\n\ntest \"StringTest, ZNaive\":\n  for\
    \ n in 1..6:\n    let m = 4^n\n    for f in 0..<m:\n      var s = newSeq[int](n)\n\
    \      var g = f\n      for i in 0..<n:\n        s[i] = g mod 4\n        g = g\
    \ div 4\n      check z_naive(s) == z_algorithm(s)\n  for n in 1..10:\n    let\
    \ m = 2^n\n    for f in 0..<m:\n      var s = newSeq[int](n)\n      var g = f\n\
    \      for i in 0..<n:\n        s[i] = g mod 2\n        g = g div 2\n      check\
    \ z_naive(s) == z_algorithm(s)\n"
  dependsOn:
  - atcoder/extra/other/internal_sugar.nim
  - atcoder/extra/other/internal_sugar.nim
  - atcoder/extra/other/internal_underscored_calls.nim
  - atcoder/extra/other/internal_underscored_calls.nim
  isVerificationFile: false
  path: tests/test_string.nim
  requiredBy: []
  timestamp: '2020-12-05 23:18:49+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_string.nim
layout: document
redirect_from:
- /library/tests/test_string.nim
- /library/tests/test_string.nim.html
title: tests/test_string.nim
---
