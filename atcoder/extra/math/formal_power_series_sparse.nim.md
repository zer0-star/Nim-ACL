---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  - icon: ':x:'
    path: atcoder/extra/math/formal_power_series.nim
    title: atcoder/extra/math/formal_power_series.nim
  _extendedRequiredBy:
  - icon: ':warning:'
    path: tests/test_extra_formal_power_series.nim
    title: tests/test_extra_formal_power_series.nim
  - icon: ':warning:'
    path: tests/test_extra_formal_power_series.nim
    title: tests/test_extra_formal_power_series.nim
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
  code: "when not declared ATCODER_FORMAL_POWER_SERIES_SPARSE_HPP:\n  const ATCODER_FORMAL_POWER_SERIES_SPARSE_HPP*\
    \ = 1\n  import std/sequtils, std/tables, std/algorithm, std/strformat, std/macros\n\
    \  import atcoder/element_concepts\n  import atcoder/extra/math/formal_power_series\n\
    \  type SparseFormalPowerSeries*[T:FieldElem] = seq[tuple[d:int, c:T]] # sorted\
    \ ascending order\n\n#  converter toSparseFormalPowerSeries*[XI, T](a:array[XI,\
    \ (int, T)]):SparseFormalPowerSeries[T] = a.toSeq()\n\n  # SparseMonomial {{{\n\
    \  type SparseMonomial*[T] = object\n    c:T\n    d:int\n  \n  proc initSparseVar*[T](c\
    \ = 1, d = 1):SparseMonomial[T] = SparseMonomial[T](c:T(c), d:d)\n  \n  proc `^`*[T](f:SparseMonomial[T],\
    \ n:int):SparseMonomial[T] =\n    result = f\n    result.d *= n\n    if f.c !=\
    \ T(1): result.c = result.c ^ n\n  \n  converter toSFPS*[T](f:SparseMonomial[T]):SparseFormalPowerSeries[T]\
    \ = @[(f.d,f.c)]\n\n  proc `+`*[T](f, g: SparseMonomial[T]):SparseFormalPowerSeries[T]\
    \ =\n    return toSFPS(f) + toSFPS(g)\n\n  proc `*`*[T](f, g:Monomial[T]):Monomial[T]\
    \ =\n    result.c = f.c * g.c\n    result.d = f.d + g.d\n  # }}}\n\n  converter\
    \ toSFPS*[T](f:Table[int, T]):SparseFormalPowerSeries[T] = toSeq(f).sortedByIt(it.d)\n\
    #  converter toSFPS*[T](a:T):SparseFormalPowerSeries[T] = @[(0, a)]\n  proc deg*[T](a:SparseFormalPowerSeries[T]):int\
    \ = a[^1].d\n  proc `+=`*[T](a:var SparseFormalPowerSeries[T], b:SparseFormalPowerSeries[T])\
    \ =\n    var r:SparseFormalPowerSeries[T]\n    var i, j = 0\n    while i < a.len\
    \ or j < b.len:\n      if i < a.len and j < b.len and a[i].d == b[j].d:\n    \
    \    r.add((a[i].d, a[i].c + b[j].c))\n        i.inc;j.inc\n      else:\n    \
    \    if j == b.len or (i < a.len and a[i].d < b[j].d):\n          r.add(a[i]);i.inc\n\
    \        else:\n          r.add(b[j]);j.inc\n    swap(r, a)\n  proc `+=`*[T](a:var\
    \ SparseFormalPowerSeries[T], b:T) = a += @[(0, b)]\n  proc `-=`*[T](a:var SparseFormalPowerSeries[T],\
    \ b:SparseFormalPowerSeries[T]) =\n    var r:SparseFormalPowerSeries[T]\n    var\
    \ i, j = 0\n    while i < a.len or j < b.len:\n      if i < a.len and j < b.len\
    \ and a[i].d == b[j].d:\n        r.add((a[i].d, a[i].c - b[j].c))\n        i.inc;j.inc\n\
    \      else:\n        if j == b.len or (i < a.len and a[i].d < b[j].d):\n    \
    \      r.add(a[i]);i.inc\n        else:\n          r.add((b[j].d, -b[j].c));j.inc\n\
    \    swap(r, a)\n  proc `-=`*[T](a:var SparseFormalPowerSeries[T], b:T) = a -=\
    \ @[(0, b)]\n\n  proc `*`*[T](a:FormalPowerSeries[T], b:SparseFormalPowerSeries[T],\
    \ deg = -1):FormalPowerSeries[T] =\n    var deg = deg\n    if deg == -1:\n   \
    \   let bdeg = b[^1][0]\n      deg = a.len + bdeg\n    result = initFormalPowerSeries[T](deg)\n\
    \    for i in 0..<a.len:\n      for (j, c) in b:\n        let k = i + j\n    \
    \    if k < deg: result[k] += a[i] * c\n  proc `*=`*[T](a:var SparseFormalPowerSeries[T],\
    \ b:SparseFormalPowerSeries[T], deg = -1) =\n    var r = initTable[int,T]()\n\
    \    for (i, c0) in a:\n      for (j, c1) in b:\n        let k = i + j\n     \
    \   if deg != -1 and k >= deg: continue\n        if k notin r: r[k] = T(0)\n \
    \       r[k] += c0 * c1\n    var rs = SparseFormalPowerSeries[T](r)\n    swap(rs,\
    \ a)\n  proc `*=`*[T](a:var SparseFormalPowerSeries[T], b:T) =\n    for (i, c)\
    \ in a.mitems:\n      c *= b\n\n  macro declareSparseFormalPowerSeriesOperators(op)\
    \ =\n    fmt\"\"\"proc `{op}`*[T](self:SparseFormalPowerSeries[T];r:SparseFormalPowerSeries[T]\
    \ or T):SparseFormalPowerSeries[T] = result = self;result {op}= r\nproc `{op}`*[T](self:\
    \ not SparseFormalPowerSeries and not SparseMonomial, r:SparseFormalPowerSeries[T]):SparseFormalPowerSeries[T]\
    \ = result = @[(0, T(self))];result {op}= r\"\"\".parsestmt\n\n  declareSparseFormalPowerSeriesOperators(`+`)\n\
    \  declareSparseFormalPowerSeriesOperators(`-`)\n  declareSparseFormalPowerSeriesOperators(`*`)\n\
    \n  proc divMod*[T](a: FormalPowerSeries[T], b:SparseFormalPowerSeries[T]):(FormalPowerSeries[T],\
    \ FormalPowerSeries[T]) =\n    var a = a\n    let\n      max_deg = b[^1][0]\n\
    \      inv_max_coef = b[^1][1].inv\n    var q = initFormalPowerSeries[T](a.len\
    \ - max_deg)\n    for i in countdown(q.len - 1, 0):\n      q[i] = a[i + max_deg]\
    \ * inv_max_coef\n      for (d, v) in b:\n        a[i + d] -= q[i] * v\n    return\
    \ (q, a[0..<max_deg])\n  proc `div`*[T:FieldElem](a: FormalPowerSeries[T], b:SparseFormalPowerSeries[T]):auto\
    \ = a.divMod(b)[0]\n  proc `mod`*[T:FieldElem](a: FormalPowerSeries[T], b:SparseFormalPowerSeries[T]):auto\
    \ = a.divMod(b)[1]\n"
  dependsOn:
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/math/formal_power_series.nim
  - atcoder/extra/math/formal_power_series.nim
  isVerificationFile: false
  path: atcoder/extra/math/formal_power_series_sparse.nim
  requiredBy:
  - tests/test_extra_formal_power_series.nim
  - tests/test_extra_formal_power_series.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/formal_power_series_sparse.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/formal_power_series_sparse.nim
- /library/atcoder/extra/math/formal_power_series_sparse.nim.html
title: atcoder/extra/math/formal_power_series_sparse.nim
---
