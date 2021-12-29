---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/math/simplex.nim
    title: atcoder/extra/math/simplex.nim
  - icon: ':warning:'
    path: atcoder/extra/math/simplex.nim
    title: atcoder/extra/math/simplex.nim
  - icon: ':warning:'
    path: atcoder/extra/math/simplex.nim
    title: atcoder/extra/math/simplex.nim
  - icon: ':warning:'
    path: atcoder/extra/math/simplex.nim
    title: atcoder/extra/math/simplex.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/yosupo_system_of_linear_equations_test.nim
    title: verify/extra/math/yosupo_system_of_linear_equations_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/math/yosupo_system_of_linear_equations_test.nim
    title: verify/extra/math/yosupo_system_of_linear_equations_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_MATRIX_HPP:\n  const ATCODER_MATRIX_HPP* = 1\n\
    \  import std/sequtils\n  import atcoder/element_concepts, atcoder/generate_definitions\n\
    \n  type Matrix*[T; p:static[tuple]] = seq[seq[T]]\n  type Vector*[T] = seq[T]\n\
    \n  proc height*(self: Matrix):int = self.len\n  proc width*(self: Matrix):int\
    \ = self[0].len\n  template getZero*[M:Matrix](self:typedesc[M] or M):auto =\n\
    \    block:\n      let zero = M.p[0]\n      zero()\n  template getUnit*[M:Matrix](self:typedesc[M]\
    \ or M):auto =\n    block:\n      let unit = M.p[1]\n      unit()\n  template\
    \ isZero*[M:Matrix](self:typedesc[M] or M, a:M.T):bool =\n    block:\n      let\
    \ isZero = M.p[2]\n      isZero(a)\n\n  proc init*[M:Matrix](self:typedesc[M]\
    \ or M, n, m:int):M =\n    result = newSeqWith(n, newSeqWith(m, M.getZero()))\n\
    \  proc init*[M:Matrix](self:typedesc[M] or M, n:int):M = M.init(n, n)\n\n  template\
    \ MatrixType*(T:typedesc, zero:static[proc():T], unit:static[proc():T], isZero:static[proc(a:T):bool]):auto\
    \ = Matrix[T, (zero, unit, isZero)]\n  template MatrixType*(T:typedesc):auto =\n\
    \    MatrixType(T, zero = proc():T = T(0), unit = proc():T = T(1), isZero = proc(a:T):bool\
    \ = (a == T(0)))\n  template MatrixType*(T:typedesc, zero:static[proc():T], unit:static[proc():T]):auto\
    \ =\n    MatrixType(T, zero, unit, proc(a:T):bool = (a == zero()))\n\n  proc initMatrix*[T:RingElem](n,\
    \ m:int, z:static[proc():T], u:static[proc():T]):auto =\n    type M = MatrixType(T,\
    \ z, u)\n    return M.init(n, m)\n  proc initMatrix*[T:RingElem](n:int, z:static[proc():T],\
    \ u:static[proc():T]):auto = \n    type M = MatrixType(T, z, u)\n    return M.init(n,\
    \ n)\n\n  proc initMatrix*[T:RingElem](n, m:int):auto =\n    type M = MatrixType(T)\n\
    \    return M.init(n, m)\n  proc initMatrix*[T:RingElem](n:int):auto =\n    type\
    \ M = MatrixType(T)\n    return M.init(n, n)\n\n  proc init*[M:Matrix](self:M\
    \ or typedesc[M], a:seq or array):M =\n    when a is seq[seq[M.T]]:\n      return\
    \ M(a)\n    else:\n      let (h, w) = (a.len, a[0].len)\n      result = M.init(h,\
    \ w)\n      for i in 0..<result.height:\n        for j in 0..<result.width:\n\
    \          result[i][j] = M.T(a[i][j])\n\n  proc initVector*[M:Matrix](self:M\
    \ or typedesc[M], n:int):Vector[M.T] = Vector[M.T](newSeqWith(n, M.getZero()))\n\
    \  proc initVector*[M:Matrix](self:M or typedesc[M], a:seq or array):Vector[M.T]\
    \ =\n    when a is seq[M.T]:\n      return a\n    else:\n      result = M.initVector(a.len)\n\
    \      for i in 0..<a.len: result[i] = M.T(a[i])\n\n  proc unit*[M:Matrix](self:\
    \ typedesc[M], n:int):M =\n    result = M.init(n)\n    for i in 0..<n:\n     \
    \ result[i][i] = M.getUnit()\n  proc unit*[M:Matrix](self: M, n = -1):M =\n  \
    \  let n = if n == -1: self.height else: n\n    return M.unit(n)\n\n  proc `+=`*[M:Matrix](self:\
    \ var M, B: M) =\n    let (n, m) = (self.height, self.width)\n    assert n ==\
    \ B.height() and m == B.width()\n    for i in 0..<n:\n      for j in 0..<m:\n\
    \        self[i][j] += B[i][j]\n  proc `+=`*[T](self: var Vector[T], B:Vector[T])\
    \ =\n    let n = self.len\n    for i in 0..<n:\n      self[i] += B[i]\n\n  proc\
    \ `-=`*[M:Matrix](self: var M, B: M) =\n    let (n, m) = (self.height, self.width)\n\
    \    assert n == B.height() and m == B.width()\n    for i in 0..<n:\n      for\
    \ j in 0..<m:\n        self[i][j] -= B[i][j]\n  \n  proc `*=`*[M:Matrix](self:\
    \ var M, B: M) =\n    let (n,m,p) = (self.height, B.width, self.width)\n    assert\
    \ p == B.height\n    var C = M.init(n, m)\n    for i in 0..<n:\n      for k in\
    \ 0..<p:\n        for j in 0..<m:\n          C[i][j] += self[i][k] * B[k][j]\n\
    \    swap(self, C)\n  proc `*`*[M:Matrix](self: M, v: Vector[M.T]): Vector[M.T]\
    \ =\n    let (n, m) = (self.height, self.width)\n    result = M.initVector(n)\n\
    \    assert(v.len == m)\n    for i in 0..<n:\n      for j in 0..<m:\n        \
    \  result[i] += self[i][j] * v[j]\n  \n  proc `+`*[M:Matrix](self: M, B:M):auto\
    \ =\n    result = self; result += B\n  proc `-`*[M:Matrix](self: M, B:M):auto\
    \ =\n    result = self; result -= B\n  proc `*`*[M:Matrix](self: M, B:M):auto\
    \ =\n    result = self; result *= B\n  proc `+`*[T](self, B:Vector[T]):auto =\n\
    \    result = self; result += B\n\n\n  proc equals*[M:Matrix](A, B:M):bool =\n\
    \    let (h, w) = (A.height, A.width)\n    if B.height != h or B.width != w: return\
    \ false\n    for i in 0..<h:\n      for j in 0..<w:\n        if not A.isZero(A[i][j]\
    \ - B[i][j]): return false\n    return true\n\n  proc toString*[M:Matrix](self:\
    \ M):string =\n    result = \"\"\n    let (n,m) = (self.height, self.width)\n\
    \    result &= \"[\\n\"\n    for i in 0..<n:\n      result &= \"  \"\n      for\
    \ j in 0..<m:\n        result &= $(self[i][j])\n        result &= (if j + 1 ==\
    \ m: \"\\n\" else: \", \")\n    result &= \"]\"\n\n  proc determinant*[M:Matrix](self:\
    \ M):auto =\n    var B = self\n    assert self.width == self.height\n    result\
    \ = M.getUnit()\n    for i in 0..<self.width:\n      var idx = -1\n      for j\
    \ in i..<self.width:\n        if not M.isZero(B[j][i]):\n          idx = j;break\n\
    \      if idx == -1:\n        return M.getZero()\n      if i != idx:\n       \
    \ result = -result\n        swap(B[i], B[idx])\n      result *= B[i][i]\n    \
    \  let vv = B[i][i]\n      for j in 0..<self.width:\n        B[i][j] /= vv\n \
    \     for j in i+1..<self.width:\n        let a = B[j][i]\n        for k in 0..<self.width:\n\
    \          B[j][k] -= B[i][k] * a\n\n  proc gaussianElimination*[M:Matrix](A:M):(M,\
    \ seq[int]) =\n    let\n      (n, m) = (A.height, A.width)\n    var\n      A =\
    \ A\n      ids = newSeq[int]()\n      j = 0\n    for i in 0..<n:\n      while\
    \ j < m:\n        var pivot = -1\n        for ii in i..<n:\n          if not M.isZero(A[ii][j]):\n\
    \            pivot = ii\n            break\n        if pivot != -1:\n        \
    \  swap(A[i], A[pivot])\n          break\n        j.inc\n      if j == m: break\n\
    \      let d = M.T(1) / A[i][j]\n      for jj in j..<m: A[i][jj] *= d\n      for\
    \ ii in 0..<n:\n        if ii == i: continue\n        let d = A[ii][j]\n     \
    \   for jj in j..<m: A[ii][jj] -= A[i][jj] * d\n      ids.add(j)\n      j.inc\n\
    \    return (A, ids)\n  \n  import std/options\n\n  proc linearEquations*[M:Matrix](A:M,\
    \ b:Vector[M.T]):Option[(Vector[M.T], seq[Vector[M.T]])] =\n    let (n, m) = (A.height,\
    \ A.width)\n    assert n == b.len\n    var A = A\n    for i in 0..<n: A[i].add(b[i])\n\
    \    let (B, ids) = A.gaussianElimination()\n    if ids.len > 0 and ids[^1] ==\
    \ m:\n      return none[(Vector[M.T], seq[Vector[M.T]])]()\n    var\n      s =\
    \ ids.toHashSet()\n      id = newSeq[int](m)\n      ct = 0\n      v = newSeq[Vector[M.T]]()\n\
    \      x = M.initVector(m)\n    for j in 0..<m:\n      if j notin s:\n       \
    \ id[j] = ct\n        ct.inc\n        var v0 = M.initVector(m)\n        v0[j]\
    \ = M.T(1)\n        v.add(v0)\n    for i,ip in ids:\n      x[ip] = B[i][^1]\n\
    \      for j in 0..<m:\n        if j in s: continue\n        v[id[j]][ip] -= B[i][j]\n\
    \    return (x, v).some\n  \n  proc inv*[M:Matrix](A:M):M =\n    assert A.height\
    \ == A.width\n    let n = A.height\n    var A2 = M.init(n, n * 2)\n    for i in\
    \ 0..<n:\n      for j in 0..<n:\n        A2[i][j] = A[i][j]\n      A2[i][i + n]\
    \ = M.getUnit()\n    let (G, ids) = A2.gaussianElimination()\n    result = M.init(n)\n\
    \    assert ids == (0..<n).toSeq\n    for i in 0..<n:\n      for j in 0..<n:\n\
    \        result[i][j] = G[i][j + n]\n\n  generatePow(Matrix)\n"
  dependsOn:
  - atcoder/generate_definitions.nim
  - atcoder/element_concepts.nim
  - atcoder/generate_definitions.nim
  - atcoder/element_concepts.nim
  - atcoder/generate_definitions.nim
  - atcoder/element_concepts.nim
  - atcoder/generate_definitions.nim
  - atcoder/element_concepts.nim
  isVerificationFile: false
  path: atcoder/extra/math/matrix.nim
  requiredBy:
  - atcoder/extra/math/simplex.nim
  - atcoder/extra/math/simplex.nim
  - atcoder/extra/math/simplex.nim
  - atcoder/extra/math/simplex.nim
  timestamp: '2021-08-20 02:39:44+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/math/yosupo_system_of_linear_equations_test.nim
  - verify/extra/math/yosupo_system_of_linear_equations_test.nim
documentation_of: atcoder/extra/math/matrix.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/matrix.nim
- /library/atcoder/extra/math/matrix.nim.html
title: atcoder/extra/math/matrix.nim
---
