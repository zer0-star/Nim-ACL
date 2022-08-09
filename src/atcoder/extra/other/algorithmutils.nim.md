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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_ALGORITHM_UTILS_HPP:\n  const ATCODER_ALGORITHM_UTILS_HPP*\
    \ = 1\n  import std/algorithm\n  iterator permutation*[T](v:seq[T]):seq[T] =\n\
    \    let n = v.len\n    var a = (0..<n).toSeq\n    while true:\n      var result\
    \ = newSeq[int]()\n      for i in 0..<n: result.add v[a[i]]\n      yield result\n\
    \      if not a.nextPermutation(): break\n  \n  iterator combination*[T](v:seq[T],\
    \ r:int):seq[T] =\n    let n = v.len\n    var a = 1.repeat(r) & 0.repeat(n - r)\n\
    \    while true:\n      var result = newSeq[int]()\n      for i in 0..<n:\n  \
    \      if a[i] == 1: result.add(v[i])\n      yield result\n      if not a.prevPermutation():\
    \ break\n\n  proc median[T](a, b, c:T):T =\n    if a <= b:\n      if b <= c: return\
    \ b\n      elif a <= c: return c\n      else: return a\n    else: # a > b\n  \
    \    if b <= c:\n        if a <= c: return a\n        else: return c\n      else:\
    \ # b > c\n        return b\n  \n  proc unguarded_partition[T](a:var openArray[T],\
    \ first, last:int, target:T):int =\n    var\n      l = first\n      r = last -\
    \ 1\n    # i in 0 .. l\u3067\u306Fa[i] < target\n    # i in r ..< a.len\u3067\u306F\
    target <= a[i]\n    while l < r:\n      while l < r and a[l] <= target: l.inc\n\
    \      while l < r and target < a[r]: r.dec\n      if l < r: swap a[l], a[r]\n\
    \    return r\n  \n  proc nth_element*[T](a:var openArray[T], first, nth, last:\
    \ int) =\n    proc insertion_sort(a:var openArray[T], first, last:int) =\n   \
    \   for i in first ..< last:\n        for j in i + 1 ..< last:\n          if a[j]\
    \ < a[i]: swap a[i], a[j]\n    var (first, last) = (first, last)\n    while last\
    \ - first > 3:\n      let m = median(a[first], a[first + ((last - first) shr 1)],\
    \ a[last - 1])\n      var cut = a.unguarded_partition(first, last, m)\n      if\
    \ cut == last - 1: break # all equal\n      if cut <= nth:\n        first = cut\n\
    \      else:\n        last = cut\n    a.insertion_sort(first, last)\n\n  proc\
    \ nth_element*[T](a:var openArray[T], nth: int) =\n    nth_element(a, 0, nth,\
    \ a.len)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/algorithmutils.nim
  requiredBy: []
  timestamp: '2022-07-03 22:20:00+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/algorithmutils.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/algorithmutils.nim
- /library/atcoder/extra/other/algorithmutils.nim.html
title: atcoder/extra/other/algorithmutils.nim
---
