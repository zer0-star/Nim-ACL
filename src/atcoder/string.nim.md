---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/lcp_array_test.nim
    title: verify/lcp_array_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/lcp_array_test.nim
    title: verify/lcp_array_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/suffix_array_test.nim
    title: verify/suffix_array_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/suffix_array_test.nim
    title: verify/suffix_array_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/z_algorithm_test.nim
    title: verify/z_algorithm_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/z_algorithm_test.nim
    title: verify/z_algorithm_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_STRING_HPP:\n  const ATCODER_STRING_HPP* = 1\n\n\
    \  import std/algorithm, std/sequtils\n\n  proc sa_naive*(s:seq[int]):seq[int]\
    \ =\n    let n = s.len\n    var sa = newSeq[int](n)\n    for i in 0..<n:sa[i]\
    \ = i\n    sa.sort() do (l, r:int) -> int:\n      if l == r: return 0\n      var\
    \ (l, r) = (l, r)\n      while l < n and r < n:\n        if s[l] != s[r]: return\
    \ cmp[int](s[l], s[r])\n        l.inc;r.inc\n      return cmp[int](n, l)\n   \
    \ return sa\n  \n  proc sa_doubling*(s:seq[int]):seq[int] =\n    let n = s.len\n\
    \    var\n      sa, tmp = newSeq[int](n)\n      rnk = s\n    for i in 0..<n:sa[i]\
    \ = i\n    var k = 1\n    while k < n:\n      proc cmp0(x, y:int):int =\n    \
    \    if rnk[x] != rnk[y]: return cmp[int](rnk[x], rnk[y])\n        let\n     \
    \     rx = if x + k < n: rnk[x + k] else: -1\n          ry = if y + k < n: rnk[y\
    \ + k] else: -1\n        return cmp[int](rx, ry)\n      sa.sort(cmp0)\n      tmp[sa[0]]\
    \ = 0\n      for i in 1..<n:\n        tmp[sa[i]] = tmp[sa[i - 1]] + (if cmp0(sa[i\
    \ - 1], sa[i]) < 0: 1 else: 0)\n      swap(tmp, rnk)\n      k = k shl 1\n    return\
    \ sa\n\n  # SA-IS, linear-time suffix array construction\n  # Reference:\n  #\
    \ G. Nong, S. Zhang, and W. H. Chan,\n  # Two Efficient Algorithms for Linear\
    \ Time Suffix Array Construction\n#  template <int THRESHOLD_NAIVE = 10, int THRESHOLD_DOUBLING\
    \ = 40>\n  proc sa_is*(s:seq[int], upper:int, THRESHOLD_NAIVE:static[int] = 10,\
    \ THRESHOLD_DOUBLING:static[int] = 40):seq[int] =\n    let n = s.len\n    if n\
    \ == 0: return @[]\n    if n == 1: return @[0]\n    if n == 2:\n      if s[0]\
    \ < s[1]:\n        return @[0, 1]\n      else:\n        return @[1, 0]\n    if\
    \ n < THRESHOLD_NAIVE:\n      return sa_naive(s)\n    if n < THRESHOLD_DOUBLING:\n\
    \      return sa_doubling(s)\n    \n    var sa, ls = newSeq[int](n)\n    for i\
    \ in countdown(n - 2, 0):\n      ls[i] = if s[i] == s[i + 1]: ls[i + 1] else:\
    \ (s[i] < s[i + 1]).int\n    var sum_l, sum_s = newSeq[int](upper + 1)\n    for\
    \ i in 0..<n:\n      if ls[i] == 0:\n        sum_s[s[i]].inc\n      else:\n  \
    \      sum_l[s[i] + 1].inc\n    for i in 0..upper:\n      sum_s[i] += sum_l[i]\n\
    \      if i < upper: sum_l[i + 1] += sum_s[i]\n\n    proc induce(lms:seq[int]):auto\
    \ =\n      sa.fill(-1)\n      var buf = sum_s\n      for d in lms:\n        if\
    \ d == n: continue\n        sa[buf[s[d]]] = d\n        buf[s[d]].inc\n      buf\
    \ = sum_l\n      sa[buf[s[n - 1]]] = n - 1\n      buf[s[n - 1]].inc\n      for\
    \ i in 0..<n:\n        let v = sa[i]\n        if v >= 1 and ls[v - 1] == 0:\n\
    \          sa[buf[s[v - 1]]] = v - 1\n          buf[s[v - 1]].inc\n      buf =\
    \ sum_l\n      for i in countdown(n - 1, 0):\n        let v = sa[i]\n        if\
    \ v >= 1 and ls[v - 1] != 0:\n          buf[s[v - 1] + 1].dec\n          sa[buf[s[v\
    \ - 1] + 1]] = v - 1\n  \n    var lms_map = newSeqWith(n + 1, -1)\n    var m =\
    \ 0\n    for i in 1..<n:\n      if ls[i - 1] == 0 and ls[i] != 0:\n        lms_map[i]\
    \ = m\n        m.inc\n    var lms = newSeqOfCap[int](m)\n    for i in 1..<n:\n\
    \      if ls[i - 1] == 0 and ls[i] != 0:\n        lms.add(i)\n  \n    induce(lms)\n\
    \  \n    if m != 0:\n      var sorted_lms = newSeqOfCap[int](m)\n      for v in\
    \ sa:\n        if lms_map[v] != -1: sorted_lms.add(v)\n      var\n        rec_s\
    \ = newSeq[int](m)\n        rec_upper = 0;\n      rec_s[lms_map[sorted_lms[0]]]\
    \ = 0\n      for i in 1..<m:\n        var (l, r) = (sorted_lms[i - 1], sorted_lms[i])\n\
    \        let\n          end_l = if lms_map[l] + 1 < m: lms[lms_map[l] + 1] else:\
    \ n\n          end_r = if lms_map[r] + 1 < m: lms[lms_map[r] + 1] else: n\n  \
    \      var same = true\n        if end_l - l != end_r - r:\n          same = false\n\
    \        else:\n          while l < end_l:\n            if s[l] != s[r]:\n   \
    \           break\n            l.inc\n            r.inc\n          if l == n or\
    \ s[l] != s[r]: same = false\n        if not same: rec_upper.inc\n        rec_s[lms_map[sorted_lms[i]]]\
    \ = rec_upper\n\n      let rec_sa =\n        sa_is[THRESHOLD_NAIVE, THRESHOLD_DOUBLING](rec_s,\
    \ rec_upper)\n\n      for i in 0..<m:\n        sorted_lms[i] = lms[rec_sa[i]]\n\
    \      induce(sorted_lms)\n    return sa\n\n# namespace internal\n  \n  proc suffix_array*(s:seq[int],\
    \ upper:int):seq[int] =\n    assert 0 <= upper\n    for d in s:\n      assert\
    \ 0 <= d and d <= upper\n    return sa_is(s, upper)\n  \n  proc suffix_array*[T](s:seq[T]):seq[int]\
    \ =\n    let n = s.len\n    var idx = newSeq[int](n)\n    for i in 0..<n: idx[i]\
    \ = i\n    idx.sort(proc(l,r:int):int = cmp[int](s[l], s[r]))\n    var s2 = newSeq[int](n)\n\
    \    var now = 0\n    for i in 0..<n:\n      if i != 0 and s[idx[i - 1]] != s[idx[i]]:\
    \ now.inc\n      s2[idx[i]] = now\n    return sa_is(s2, now)\n  \n  proc suffix_array*(s:string):seq[int]\
    \ =\n    return sa_is(s.mapIt(it.int), 255);\n  \n  # Reference:\n  # T. Kasai,\
    \ G. Lee, H. Arimura, S. Arikawa, and K. Park,\n  # Linear-Time Longest-Common-Prefix\
    \ Computation in Suffix Arrays and Its\n  # Applications\n  proc lcp_array*[T](s:seq[T],\
    \ sa:seq[int]):seq[int] =\n    let n = s.len\n    assert n >= 1\n    var rnk =\
    \ newSeq[int](n)\n    for i in 0..<n:\n      rnk[sa[i]] = i\n    var lcp = newSeq[int](n\
    \ - 1)\n    var h = 0;\n    for i in 0..<n:\n      if h > 0: h.dec\n      if rnk[i]\
    \ == 0: continue\n      let j = sa[rnk[i] - 1]\n      while j + h < n and i +\
    \ h < n:\n        if s[j + h] != s[i + h]: break\n        h.inc\n      lcp[rnk[i]\
    \ - 1] = h\n    return lcp\n  \n  proc lcp_array*(s:string, sa:seq[int]):seq[int]\
    \ = lcp_array(s.mapIt(it.int), sa)\n  \n  # Reference:\n  # D. Gusfield,\n  #\
    \ Algorithms on Strings, Trees, and Sequences: Computer Science and\n  # Computational\
    \ Biology\n  proc z_algorithm*[T](s:seq[T]):seq[T] =\n    let n = s.len\n    if\
    \ n == 0: return @[]\n    var z = newSeq[int](n)\n    z[0] = 0\n    var j = 0\n\
    \    for i in 1..<n:\n      var k = z[i].addr\n      k[] = if j + z[j] <= i: 0\
    \ else: min(j + z[j] - i, z[i - j])\n      while i + k[] < n and s[k[]] == s[i\
    \ + k[]]: k[].inc\n      if j + z[j] < i + z[i]: j = i\n    z[0] = n\n    return\
    \ z\n\n  proc z_algorithm*(s:string):auto = z_algorithm(s.mapIt(it.int))\n\n#\
    \ namespace atcoder\n\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/string.nim
  requiredBy: []
  timestamp: '2020-09-24 19:39:03+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/lcp_array_test.nim
  - verify/lcp_array_test.nim
  - verify/suffix_array_test.nim
  - verify/suffix_array_test.nim
  - verify/z_algorithm_test.nim
  - verify/z_algorithm_test.nim
documentation_of: atcoder/string.nim
layout: document
redirect_from:
- /library/atcoder/string.nim
- /library/atcoder/string.nim.html
title: atcoder/string.nim
---
