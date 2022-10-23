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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_CONVEX_HULL_TRICK_ADD_MONOTONE:\n  const ATCODER_CONVEX_HULL_TRICK_ADD_MONOTONE*\
    \ = 1\n  import std/deques\n  type ConvexHullTrickAddMonotone*[T] = object\n \
    \   isMin:bool\n    H:Deque[(T,T)]\n  \n  proc initConvexHullTrickAddMonotone*[T](isMin:bool):ConvexHullTrickAddMonotone[T]\
    \ =\n    return ConvexHullTrickAddMonotone[T](H:initDeque[(T, T)](), isMin:isMin)\n\
    \  \n  proc empty[T](self: ConvexHullTrickAddMonotone[T]):bool = self.H.len ==\
    \ 0\n  \n  #  void clear() { H.clear(); }\n  \n  proc sgn[T](self: ConvexHullTrickAddMonotone[T],\
    \ x:T):int =\n    return if x == T(0): 0 else: (if x < T(0):  -1 else: 1)\n  \n\
    \  proc check[T](self: ConvexHullTrickAddMonotone[T], a,b,c:(T,T)):bool =\n  \
    \  if b[1] == a[1] or c[1] == b[1]:\n      return self.sgn(b[0] - a[0]) * self.sgn(c[1]\
    \ - b[1]) >= self.sgn(c[0] - b[0]) * self.sgn(b[1] - a[1])\n  \n    #return (b[0]-a[0])*(c[1]-b[1])\
    \ >= (b[1]-a[1])*(c[0]-b[0]);\n    return\n        (b[0] - a[0]).float * self.sgn(c[1]\
    \ - b[1]).float / abs(b[1] - a[1]).float >= (c[0] - b[0]).float * self.sgn(b[1]\
    \ - a[1]).float / abs(c[1] - b[1]).float\n  \n  proc add*[T](self: var ConvexHullTrickAddMonotone[T],\
    \ a, b:T) =\n    var (a, b) = (a, b)\n    if not self.isMin:\n      a *= -1;b\
    \ *= -1\n    let line = (a, b)\n    if self.empty():\n      self.H.addFirst(line)\n\
    \      return;\n    if self.H[0][0] <= a:\n      if self.H[0][0] == a:\n     \
    \   if self.H[0][1] <= b: return\n        self.H.popFirst\n      while self.H.len\
    \ >= 2 and self.check(line, self.H[0], self.H[1]): self.H.popFirst\n      self.H.addFirst(line)\n\
    \    else:\n      assert(a <= self.H[self.H.len-1][0])\n      if self.H[self.H.len-1][0]\
    \ == a:\n        if self.H[self.H.len-1][1] <= b: return\n        self.H.popLast()\n\
    \      while self.H.len >= 2 and self.check(self.H[self.H.len-2], self.H[self.H.len-1],\
    \ line): self.H.popLast\n      self.H.addLast(line)\n  \n  proc get_y[T](self:\
    \ ConvexHullTrickAddMonotone[T], a:(T, T), x:T):T =\n    return a[0] * x + a[1];\n\
    \  \n  proc query*[T](self: ConvexHullTrickAddMonotone[T], x:T):T =\n    assert(not\
    \ self.empty())\n    var (l, r) = (-1, self.H.len - 1)\n    while l + 1 < r:\n\
    \      let m = (l + r) shr 1\n      if self.get_y(self.H[m], x) >= self.get_y(self.H[m\
    \ + 1], x): l = m\n      else: r = m\n    if self.isMin: return self.get_y(self.H[r],\
    \ x)\n    return -self.get_y(self.H[r], x)\n  \n  proc query_monotone_inc*[T](self:\
    \ var ConvexHullTrickAddMonotone[T], x:T):T =\n    assert(not self.empty())\n\
    \    while self.H.len >= 2 and self.get_y(self.H[0], x) >= self.get_y(self.H[1],\
    \ x): self.H.popFirst\n    if self.isMin: return self.get_y(self.H[0], x)\n  \
    \  return -self.get_y(self.H[0], x)\n  \n  proc query_monotone_dec*[T](self: var\
    \ ConvexHullTrickAddMonotone[T], x:T):T =\n    assert(not self.empty())\n    while\
    \ self.H.size() >= 2 and get_y(self.H[self.H.len - 1], x) >= self.get_y(self.H[self.H.len\
    \ - 2], x): self.H.popLast\n    if self.isMin: return self.get_y(self.H[self.H.len\
    \ - 1], x)\n    return -self.get_y(self.H[self.H.len - 1], x)\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/convex_hull_trick_add_monotone.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/convex_hull_trick_add_monotone.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/convex_hull_trick_add_monotone.nim
- /library/atcoder/extra/structure/convex_hull_trick_add_monotone.nim.html
title: atcoder/extra/structure/convex_hull_trick_add_monotone.nim
---
