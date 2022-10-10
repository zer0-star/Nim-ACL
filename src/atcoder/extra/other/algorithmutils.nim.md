---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/string/aho_corasick.nim
    title: atcoder/extra/string/aho_corasick.nim
  - icon: ':warning:'
    path: atcoder/extra/string/aho_corasick.nim
    title: atcoder/extra/string/aho_corasick.nim
  - icon: ':warning:'
    path: atcoder/extra/string/aho_corasick.nim
    title: atcoder/extra/string/aho_corasick.nim
  - icon: ':warning:'
    path: atcoder/extra/string/aho_corasick.nim
    title: atcoder/extra/string/aho_corasick.nim
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links:
    - https://cpprefjp.github.io/reference/algorithm/nth_element.html
    - https://cpprefjp.github.io/reference/algorithm/set_union.html
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_ALGORITHM_UTILS_HPP:\n  const ATCODER_ALGORITHM_UTILS_HPP*\
    \ = 1\n  import std/algorithm\n  iterator permutation*[T](v:seq[T]):seq[T] =\n\
    \    let n = v.len\n    var a = (0..<n).toSeq\n    while true:\n      var result\
    \ = newSeq[int]()\n      for i in 0..<n: result.add v[a[i]]\n      yield result\n\
    \      if not a.nextPermutation(): break\n  \n  iterator combination*[T](v:seq[T],\
    \ r:int):seq[T] =\n    let n = v.len\n    var a = 1.repeat(r) & 0.repeat(n - r)\n\
    \    while true:\n      var result = newSeq[int]()\n      for i in 0..<n:\n  \
    \      if a[i] == 1: result.add(v[i])\n      yield result\n      if not a.prevPermutation():\
    \ break\n\n  proc unguarded_partition[T](a:var openArray[T], first, last:int,\
    \ target:T, comp: proc(a, b:T):bool):int =\n    var\n      l = first\n      r\
    \ = last - 1\n    # i in 0 .. l\u3067\u306Fa[i] < target\n    # i in r ..< a.len\u3067\
    \u306Ftarget <= a[i]\n    while l < r:\n      while l < r and not comp(target,\
    \ a[l]): l.inc\n      while l < r and comp(target, a[r]): r.dec\n      if l <\
    \ r: swap a[l], a[r]\n    return r\n\n  # https://cpprefjp.github.io/reference/algorithm/nth_element.html\n\
    \n  proc nth_element*[T](a:var openArray[T], first, nth, last: int, comp:proc(a,\
    \ b:T):bool = (proc(a, b:T):bool = a < b)) =\n    proc insertion_sort(a:var openArray[T],\
    \ first, last:int) =\n      for i in first ..< last:\n        for j in i + 1 ..<\
    \ last:\n          if comp(a[j], a[i]): swap a[i], a[j]\n    proc median[T](a,\
    \ b, c:T, comp:proc(a, b:T):bool):T =\n      if comp(a, b):\n        if comp(b,\
    \ c): return b\n        elif comp(a, c): return c\n        else: return a\n  \
    \    else: # a >= b\n        if comp(b, c):\n          if comp(a, c): return a\n\
    \          else: return c\n        else: # b >= c\n          return b\n\n    var\
    \ (first, last) = (first, last)\n    while last - first > 3:\n      let m = median(a[first],\
    \ a[first + ((last - first) shr 1)], a[last - 1], comp)\n      var cut = a.unguarded_partition(first,\
    \ last, m, comp)\n      if cut == last - 1: break # all equal\n      if cut <=\
    \ nth:\n        first = cut\n      else:\n        last = cut\n    a.insertion_sort(first,\
    \ last)\n\n  proc nth_element*[T](a:var openArray[T], nth: int, comp:proc(a, b:T):bool\
    \ = (proc(a, b:T):bool = a < b)) =\n    nth_element(a, 0, nth, a.len, comp)\n\
    \  \n  # https://cpprefjp.github.io/reference/algorithm/set_union.html\n  proc\
    \ setUnion*[T](u, v: seq[T]):seq[T] =\n    result = newSeq[T]()\n    var (i,j)\
    \ = (0,0)\n    while true:\n      if i < u.len:\n        if j < v.len:\n     \
    \     if u[i] < v[j]:result.add(u[i]);i+=1\n          elif u[i] > v[j]:result.add(v[j]);j+=1\n\
    \          else: result.add(v[j]);i+=1;j+=1\n        else:\n          result.add(u[i]);i+=1\n\
    \      else:\n        if j < v.len:\n          result.add(v[j]);j+=1\n       \
    \ else:\n          break\n\n\n\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/algorithmutils.nim
  requiredBy:
  - atcoder/extra/string/aho_corasick.nim
  - atcoder/extra/string/aho_corasick.nim
  - atcoder/extra/string/aho_corasick.nim
  - atcoder/extra/string/aho_corasick.nim
  timestamp: '2022-09-17 04:52:33+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/algorithmutils.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/algorithmutils.nim
- /library/atcoder/extra/other/algorithmutils.nim.html
title: atcoder/extra/other/algorithmutils.nim
---
