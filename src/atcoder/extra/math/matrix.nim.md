---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/operator.nim
    title: atcoder/extra/other/operator.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/operator.nim
    title: atcoder/extra/other/operator.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/operator.nim
    title: atcoder/extra/other/operator.nim
  - icon: ':heavy_check_mark:'
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
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/math/characteristic_polynomial.nim
    title: atcoder/extra/math/characteristic_polynomial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/characteristic_polynomial.nim
    title: atcoder/extra/math/characteristic_polynomial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/characteristic_polynomial.nim
    title: atcoder/extra/math/characteristic_polynomial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/characteristic_polynomial.nim
    title: atcoder/extra/math/characteristic_polynomial.nim
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  - icon: ':warning:'
    path: atcoder/extra/math/kitamasa.nim
    title: atcoder/extra/math/kitamasa.nim
  - icon: ':warning:'
    path: atcoder/extra/math/simplex_old.nim
    title: atcoder/extra/math/simplex_old.nim
  - icon: ':warning:'
    path: atcoder/extra/math/simplex_old.nim
    title: atcoder/extra/math/simplex_old.nim
  - icon: ':warning:'
    path: atcoder/extra/math/simplex_old.nim
    title: atcoder/extra/math/simplex_old.nim
  - icon: ':warning:'
    path: atcoder/extra/math/simplex_old.nim
    title: atcoder/extra/math/simplex_old.nim
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_MATRIX_HPP:\n  const ATCODER_MATRIX_HPP* = 1\n\
    \  import std/sequtils, std/algorithm\n  import atcoder/generate_definitions\n\
    \  import atcoder/extra/other/operator\n\n  #type ConvertibleTo*[T] = concept\
    \ x\n  #  T(x) is T\n  #type ConvertibleTo2DArray*[T] = concept a\n  #  true\n\
    \  #  #a is array\n  #  #a[0] is array\n  #  #T(a[0][0]) is T\n\n  type StaticMatrix*[T;\
    \ N, M:static[int];Vector;p:static[tuple]] = object\n    data*:array[N, array[M,\
    \ T]]\n  type DynamicMatrix*[T;Vector;p:static[tuple]] = object\n    N*, M*:int\n\
    \    data*:seq[T]\n  type DynamicVector*[T] = seq[T]\n  type StaticMatrixObj*[T;\
    \ p:static[tuple]] =\n    object\n  type StaticVector*[T; N:static[int]] = array[N,\
    \ T]\n\n  type SomeMatrix* = StaticMatrix | DynamicMatrix\n  type SomeVector*\
    \ = StaticVector | DynamicVector\n\n  template height*(self: DynamicMatrix):int\
    \ = self.N\n  template height*[M:StaticMatrix](self: M):int = M.N\n  template\
    \ width*(self: DynamicMatrix):int = self.M\n  template width*[M:StaticMatrix](self:\
    \ M):int = M.M\n  proc getSeq[M:DynamicMatrix](A:M):seq[seq[M.T]] =\n    result\
    \ = newSeq[seq[M.T]](A.N)\n    for i in 0..<A.N:\n      result[i] = A.data[i *\
    \ A.M ..< (i + 1) * A.M]\n\n  proc `[]`*[M:StaticMatrix](self:M, i, j:int):M.T\
    \ = self.data[i][j]\n  proc `[]`*[M:StaticMatrix](self:var M, i, j:int):var M.T\
    \ = self.data[i][j]\n  proc `[]=`*[M:StaticMatrix](self:var M, i, j:int, a:M.T)\
    \ = self.data[i][j] = a\n  proc `[]`*[M:DynamicMatrix](self:M, i, j:int):M.T =\
    \ self.data[i * self.M + j]\n  proc `[]`*[M:DynamicMatrix](self:var M, i, j:int):var\
    \ M.T = self.data[i * self.M + j]\n  proc `[]=`*[M:DynamicMatrix](self:var M,\
    \ i, j:int, a:M.T) = self.data[i * self.M + j] = a\n\n  proc init*[M:DynamicMatrix](self:typedesc[M]\
    \ or M, n, m:int):M =\n    result.N = n;result.M = m\n    result.data.setLen(n\
    \ * m)\n    for i in 0..<result.data.len:\n      result.data[i] = M.p.zero()\n\
    \  proc init*[M:DynamicMatrix](self:typedesc[M] or M, n:int):M = M.init(n, n)\n\
    \  proc init*[M:StaticMatrixObj | StaticMatrix](self:typedesc[M] or M, n, m:static[int]):auto\
    \ =\n    var A: StaticMatrix[M.T, n, m, StaticVector[M.T, m], M.p]\n    for i\
    \ in 0 ..< n:\n      for j in 0 ..< m:\n        A[i, j] = M.p.zero()\n    return\
    \ A\n  proc init*[M:StaticMatrixObj | StaticMatrix](self:typedesc[M] or M, n:static[int]):auto\
    \ = M.init(n, n)\n\n  template DynamicMatrixType*(T:typedesc):auto =\n    DynamicMatrix[T,\
    \ DynamicVector[T], getDefaultOperator(T)]\n  template DynamicMatrixType*(T:typedesc,\
    \ p:static[OperatorType]):auto =\n    DynamicMatrix[T, DynamicVector[T], p]\n\
    \  \n  template StaticMatrixType*(T:typedesc):auto =\n    StaticMatrixObj[T, getDefaultOperator(T)]\n\
    \  template StaticMatrixType*(T:typedesc, p:static[OperatorType]):auto =\n   \
    \ StaticMatrixObj[T, p]\n\n  proc initVector*[M:DynamicMatrix](self:M or typedesc[M],\
    \ n:int):DynamicVector[M.T] = DynamicVector[M.T](newSeqWith(n, M.p.zero()))\n\
    \  proc initVector*[M:DynamicMatrix](self:M or typedesc[M], a:seq or array):DynamicVector[M.T]\
    \ =\n    result = M.initVector(a.len)\n    for i in 0..<a.len: result[i] = M.T(a[i])\n\
    \  template initVector*[M:StaticMatrix | StaticMatrixObj](self:M or typedesc[M],\
    \ n:static[int]):auto =\n    var a:StaticVector[M.T, n.int]\n    a\n  template\
    \ initVector*[M:StaticMatrix | StaticMatrixObj](self:M or typedesc[M], a:array):auto\
    \ =\n    var v = M.initVector(a.len)\n    for i in 0..<v.len: v[i] = M.T(a[i])\n\
    \    v\n\n  proc init*[T, Vector, p](self:DynamicMatrix[T, Vector, p] or typedesc[DynamicMatrix[T,\
    \ Vector, p]], a: seq or array):auto =\n    let (h, w) = (a.len, a[0].len)\n \
    \   type M = DynamicMatrix[T, Vector, p]\n    result = M.init(h, w)\n    for i\
    \ in 0..<result.height:\n      for j in 0..<result.width:\n        result[i, j]\
    \ = M.T(a[i][j])\n\n  template init*[M:StaticMatrixObj | StaticMatrix](self:M\
    \ or typedesc[M], a:array):auto =\n    const h = a.len\n    const w = a[0].len\n\
    \    var A = M.init(h, w)\n    for i in 0..<h:\n      for j in 0..<w:\n      \
    \  A[i, j] = M.T(a[i][j])\n    A\n\n  proc unit*[M:DynamicMatrix](self: typedesc[M],\
    \ n:int):M =\n    result = M.init(n)\n    for i in 0..<n:\n      result[i, i]\
    \ = M.p.unit()\n  proc unit*[M:DynamicMatrix](self: M, n = -1):M =\n    let n\
    \ = if n == -1: self.height else: n\n    return M.unit(n)\n  proc unit*[M:StaticMatrix\
    \ or StaticMatrixObj](self: typedesc[M], n:static[int]):auto =\n    result = M.init(n)\n\
    \    for i in 0..<n:\n      result[i, i] = M.p.unit()\n  proc unit*[M:StaticMatrix](self:\
    \ M, n:static[int] = -1):M =\n    when n == -1:\n      M.unit(self.height)\n \
    \   else:\n      M.unit(n)\n\n  proc `+=`*[M:SomeMatrix](self: var M, B: M) =\n\
    \    let (n, m) = (self.height, self.width)\n    assert n == B.height() and m\
    \ == B.width()\n    for i in 0..<n:\n      for j in 0..<m:\n        self[i, j]\
    \ = M.p.add(self[i, j], B[i, j])\n  proc `+=`*[V:SomeVector](self: var V, B:V)\
    \ =\n    let n = self.len\n    for i in 0..<n:\n      self[i] = self[i] + B[i]\
    \ # todo\n\n  proc `-=`*[M:SomeMatrix](self: var M, B: M) =\n    let (n, m) =\
    \ (self.height, self.width)\n    assert n == B.height() and m == B.width()\n \
    \   for i in 0..<n:\n      for j in 0..<m:\n        self[i, j] = M.p.subt(self[i,\
    \ j], B[i, j])\n  \n  proc `*=`*[M:SomeMatrix](self: var M, B: M) =\n    #let\
    \ (n,m,p) = (self.height, B.width, self.width)\n    #assert p == B.height\n  \
    \  var C = M.init(self.height, B.width)\n    for i in 0..<self.height:\n     \
    \ for k in 0..<self.width:\n        for j in 0..<B.width:\n          C[i, j] =\
    \ M.p.add(C[i, j], M.p.mult(self[i, k], B[k, j]))\n    self = C.move\n  proc `*`*[M:DynamicMatrix](self:M,\
    \ B:M):auto =\n    #let (n,m,p) = (self.height, B.width, self.width)\n    #assert\
    \ p == B.height\n    var C = M.init(self.height, B.width)\n    for i in 0..<self.height:\n\
    \      for k in 0..<self.width:\n        for j in 0..<B.width:\n          C[i,\
    \ j] = M.p.add(C[i, j], M.p.mult(self[i, k], B[k, j]))\n    return C\n\n  proc\
    \ `*`*(self:StaticMatrix, B:auto):auto =\n    #let (n,m,p) = (self.height, B.width,\
    \ self.width)\n    #assert p == B.height\n    var C = self.init(self.height, B.width)\n\
    \    for i in 0..<self.height:\n      for k in 0..<self.width:\n        for j\
    \ in 0..<B.width:\n          C[i, j] = self.p.add(C[i, j], self.p.mult(self[i,\
    \ k], B[k, j]))\n    return C\n\n  proc `*`*[M:SomeMatrix](self: M, v: M.Vector):\
    \ auto =\n    result = M.initVector(self.height)\n    assert(v.len == self.width)\n\
    \    for i in 0..<self.height:\n      for j in 0..<self.width:\n          result[i]\
    \ = M.p.add(result[i], M.p.mult(self[i, j], v[j]))\n  \n  proc `+`*[M:SomeMatrix](self:\
    \ M, B:M):auto =\n    result = self; result += B\n  proc `-`*[M:SomeMatrix](self:\
    \ M, B:M):auto =\n    result = self; result -= B\n  #proc `*`*[M:DynamicMatrix,\
    \ M1](self: M, B:M1):auto =\n  #  result = self; result *= B\n  proc `+`*[T](self,\
    \ B:DynamicVector[T]):auto =\n    result = self; result += B\n\n\n  proc equals*[M:SomeMatrix](A,\
    \ B:M):bool =\n    let (h, w) = (A.height, A.width)\n    if B.height != h or B.width\
    \ != w: return false\n    for i in 0..<h:\n      for j in 0..<w:\n        if not\
    \ A.p.isZero(A[i, j] - B[i, j]): return false\n    return true\n\n  proc toString*[M:SomeMatrix](self:\
    \ M):string =\n    result = \"\"\n    let (n,m) = (self.height, self.width)\n\
    \    result &= \"[\\n\"\n    for i in 0..<n:\n      result &= \"  \"\n      for\
    \ j in 0..<m:\n        result &= $(self[i, j])\n        result &= (if j + 1 ==\
    \ m: \"\\n\" else: \", \")\n    result &= \"]\"\n\n  proc determinant*[M:SomeMatrix](self:\
    \ M):auto =\n    var B = self.getSeq\n    assert self.width == self.height\n \
    \   result = M.p.unit()\n    for i in 0..<self.width:\n      var idx = -1\n  \
    \    for j in i..<self.width:\n        if not M.p.isZero(B[j][i]):\n         \
    \ idx = j;break\n      if idx == -1:\n        return M.p.zero()\n      if i !=\
    \ idx:\n        result = -result\n        swap(B[i], B[idx])\n      result *=\
    \ B[i][i]\n      let vv = B[i][i]\n      for j in 0..<self.width:\n        B[i][j]\
    \ = M.p.div(B[i][j], vv)\n      for j in i+1..<self.width:\n        let a = B[j][i]\n\
    \        for k in 0..<self.width:\n          B[j][k] -= B[i][k] * a\n\n  proc\
    \ gaussianElimination*[M:SomeMatrix](A:M):(seq[seq[M.T]], seq[int]) =\n    let\n\
    \      (n, m) = (A.height, A.width)\n    var\n      A = A.getSeq\n      ids =\
    \ newSeq[int]()\n      j = 0\n    for i in 0..<n:\n      while j < m:\n      \
    \  var pivot = -1\n        for ii in i..<n:\n          if not M.p.isZero(A[ii][j]):\n\
    \            pivot = ii\n            break\n        if pivot != -1:\n        \
    \  swap(A[i], A[pivot])\n          break\n        j.inc\n      if j == m: break\n\
    \      let d = M.p.div(M.p.unit(), A[i][j])\n      for jj in j..<m: A[i][jj] *=\
    \ d\n      for ii in 0..<n:\n        if ii == i: continue\n        let d = A[ii][j]\n\
    \        for jj in j..<m: A[ii][jj] -= A[i][jj] * d\n      ids.add(j)\n      j.inc\n\
    \    return (A, ids)\n  \n  import std/options\n\n  proc linearEquations*[M:SomeMatrix](A:M,\
    \ b:SomeVector):auto =\n    let (n, m) = (A.height, A.width)\n    assert n ==\
    \ b.len\n    var A2 = M.init(n, m + 1)\n    for i in 0 ..< n:\n      for j in\
    \ 0 ..< m:\n        A2[i, j] = A[i, j]\n      A2[i, m] = b[i]\n    #for i in 0..<n:\
    \ A[i].add(b[i])\n    let (B, ids) = A2.gaussianElimination()\n    if ids.len\
    \ > 0 and ids[^1] == m:\n      type T = (M.Vector, seq[M.Vector])\n      return\
    \ none[T]()\n    var\n      s = ids.toHashSet()\n      id = newSeq[int](m)\n \
    \     ct = 0\n      v = newSeq[M.Vector]()\n      x = M.initVector(m)\n    for\
    \ j in 0..<m:\n      if j notin s:\n        id[j] = ct\n        ct.inc\n     \
    \   var v0 = M.initVector(m)\n        v0[j] = M.T(1)\n        v.add(v0)\n    for\
    \ i,ip in ids:\n      x[ip] = B[i][^1]\n      for j in 0..<m:\n        if j in\
    \ s: continue\n        v[id[j]][ip] -= B[i][j]\n    return (x, v).some\n  \n \
    \ proc inv*[M:SomeMatrix](A:M):M =\n    assert A.height == A.width\n    let n\
    \ = A.height\n    var A2 = M.init(n, n * 2)\n    for i in 0..<n:\n      for j\
    \ in 0..<n:\n        A2[i, j] = A[i, j]\n      A2[i, i + n] = M.p.unit()\n   \
    \ let (G, ids) = A2.gaussianElimination()\n    result = M.init(n)\n    assert\
    \ ids == (0..<n).toSeq\n    for i in 0..<n:\n      for j in 0..<n:\n        result[i,\
    \ j] = G[i][j + n]\n\n  generatePow(StaticMatrix)\n  generatePow(DynamicMatrix)\n"
  dependsOn:
  - atcoder/extra/other/operator.nim
  - atcoder/generate_definitions.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/other/operator.nim
  - atcoder/extra/other/operator.nim
  - atcoder/generate_definitions.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/other/operator.nim
  isVerificationFile: false
  path: atcoder/extra/math/matrix.nim
  requiredBy:
  - atcoder/extra/math/characteristic_polynomial.nim
  - atcoder/extra/math/characteristic_polynomial.nim
  - atcoder/extra/math/simplex_old.nim
  - atcoder/extra/math/simplex_old.nim
  - atcoder/extra/math/kitamasa.nim
  - atcoder/extra/math/kitamasa.nim
  - atcoder/extra/math/characteristic_polynomial.nim
  - atcoder/extra/math/characteristic_polynomial.nim
  - atcoder/extra/math/simplex_old.nim
  - atcoder/extra/math/simplex_old.nim
  - atcoder/extra/math/kitamasa.nim
  - atcoder/extra/math/kitamasa.nim
  timestamp: '2022-10-10 21:34:07+09:00'
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
