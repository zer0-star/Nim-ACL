---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':x:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':x:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':x:'
    path: atcoder/extra/math/matrix.nim
    title: atcoder/extra/math/matrix.nim
  - icon: ':x:'
    path: atcoder/extra/other/operator.nim
    title: atcoder/extra/other/operator.nim
  - icon: ':x:'
    path: atcoder/extra/other/operator.nim
    title: atcoder/extra/other/operator.nim
  - icon: ':x:'
    path: atcoder/extra/other/operator.nim
    title: atcoder/extra/other/operator.nim
  - icon: ':x:'
    path: atcoder/extra/other/operator.nim
    title: atcoder/extra/other/operator.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
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
  code: "\n#when false:\nwhen not declared ATCODER_SIMPLEX_HPP:\n  const ATCODER_SIMPLEX_HPP*\
    \ = 1\n  import atcoder/extra/math/matrix\n\n  const EPS = 1e-8\n  type Status\
    \ = enum\n    OPTIMAL, UNBOUNDED, NOSOLUTION, UNKNOWN\n  type two_stage_simplex*[T]\
    \ = object\n    N, M:int\n    st:Status\n    a:MatrixType(T)\n    s:seq[int]\n\
    \ \n  proc status*[T](self:two_stage_simplex[T]):Status = self.st\n  proc solution*[T](self:two_stage_simplex[T]):tuple[val:T,\
    \ x:seq[T]] = \n    var x = newSeq[T](self.M)\n    for i in 0..<self.N:\n    \
    \  x[self.s[i+1]] = self.a[i+1][^1]\n    return (-self.a[0][self.M], x)\n  proc\
    \ solve*[T](self:var two_stage_simplex[T]):Status =\n    self.M += self.N; self.N\
    \ += 1\n    self.solve_sub() # solve stage one\n    if self.solution().val > EPS:\
    \ return NOSOLUTION\n    self.N -= 1; self.M -= self.N\n    swap self.a[0], self.a[^1];\
    \ discard self.a.pop() # modify table\n    for i in 0..self.N:\n      swap self.a[i][self.M],\
    \ self.a[i][^1]\n      self.a[i].setlen(self.M+1)\n    return self.solve_sub()\
    \ # solve stage two\n  proc solve_sub*[T](self:var two_stage_simplex[T]):Status\
    \ {.discardable.} =\n    var p, q:int\n    while true:\n      #print();\n    \
    \  q = 0\n      while q <= self.M and self.a[0][q] >= -EPS: q.inc\n      if q\
    \ >= self.M: break\n      p = 0\n      while p <= self.N and self.a[p][q] <= EPS:\
    \ p.inc\n      if p > self.N: break\n      for i in p+1..self.N: # bland's care\
    \ for cyclation\n        if self.a[i][q] > EPS:\n          let\n            l\
    \ = self.a[i][self.M]/self.a[i][q]\n            r = self.a[p][self.M]/self.a[p][q]\n\
    \          if l < r or (l == r and self.s[i] < self.s[q]):\n            p = i\n\
    \          #if self.a[i][self.M]/self.a[i][q] < self.a[p][self.M]/self.a[p][q]\
    \ or\n          #   (self.a[i][self.M]/self.a[i][q] == self.a[p][self.M]/self.a[p][q]\
    \ and self.s[i] < self.s[q]):\n          #  p = i\n      self.pivot(p, q)\n  \
    \  if q >= self.M: return OPTIMAL\n    else: return UNBOUNDED\n  proc pivot*[T](self:\
    \ var two_stage_simplex[T], p, q:int) =\n    for j in 0..self.N:\n      for k\
    \ in countdown(self.M, 0):\n        if j != p and k != q:\n          self.a[j][k]\
    \ -= self.a[p][k]*self.a[j][q]/self.a[p][q]\n    for j in 0..self.N:\n      if\
    \ j != p: self.a[j][q] = 0\n    for k in 0..self.M:\n      if k != q: self.a[p][k]\
    \ = self.a[p][k]/self.a[p][q]\n    self.a[p][q] = T(1)\n    self.s[p] = q\n\n\
    \  proc init_two_stage_simplex*[T](A:MatrixType(float), b, c:seq[T]):two_stage_simplex[T]\
    \ =\n    let\n      N = A.len\n      M = A[0].len\n    var\n      a = MatrixType(T).init(N\
    \ + 2, M + N + 1)\n      s = newSeq[int](N + 2)\n    for j in 0..<M: a[N+1][j]\
    \ = c[j] # make simplex table\n    for i in 0..<N:\n      for j in 0..<M:\n  \
    \      a[i+1][j] = A[i][j]\n    for i in 0..<N: a[i+1][M+N] = b[i] # add helper\
    \ table\n    for i in 0..<N: a[ 0 ][i+M] = 1\n    for i in 0..<N: a[i+1][i+M]\
    \ = 1\n    for i in 0..<N: s[i+1]      = i+M\n    for i in 1..N:\n      for j\
    \ in 0..N+M:\n        a[0][j] += a[i][j];\n    result = two_stage_simplex[T](N:N,\
    \ M:M, st:Status.UNKNOWN, a:a, s:s)\n    result.st = result.solve()\n\n#block:\n\
    #  type MT = MatrixType(float)\n#  var A = MT.init(\n#    [\n#      [1, 2, 1,\
    \ 0, 0], \n#      [1, 1, 0, 1, 0], \n#      [3, 1, 0, 0, 1]\n#    ]\n#  )\n# \
    \ var b = MT.initVector([14, 8, 18])\n#  var c = MT.initVector([-2, -3, 0, 0,\
    \ 0])\n#  echo A, b, c\n#  var tss = init_two_stage_simplex(A, b, c)\n#  echo\
    \ tss.solution\n\n\n"
  dependsOn:
  - atcoder/extra/other/operator.nim
  - atcoder/generate_definitions.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/extra/other/operator.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/extra/other/operator.nim
  - atcoder/generate_definitions.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/matrix.nim
  - atcoder/extra/other/operator.nim
  - atcoder/extra/math/matrix.nim
  isVerificationFile: false
  path: atcoder/extra/math/simplex.nim
  requiredBy: []
  timestamp: '2022-09-24 20:04:56+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/simplex.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/simplex.nim
- /library/atcoder/extra/math/simplex.nim.html
title: atcoder/extra/math/simplex.nim
---
