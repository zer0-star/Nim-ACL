---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/dp/cumulative_sum_2D_test.nim
    title: verify/extra/dp/cumulative_sum_2D_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/dp/cumulative_sum_2D_test.nim
    title: verify/extra/dp/cumulative_sum_2D_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.2/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_CUMULATIVE_SUM_2D_HPP:\n  const ATCODER_CUMULATIVE_SUM_2D_HPP*\
    \ = 1\n  import std/sequtils\n  \n  type CumulativeSum2D*[T] = object\n    built:\
    \ bool\n    data: seq[seq[T]]\n  \n  proc initCumulativeSum2D*[T](W, H:int):CumulativeSum2D[T]\
    \ = CumulativeSum2D[T](data: newSeqWith(W + 1, newSeqWith(H + 1, T(0))), built:false)\n\
    \  proc initCumulativeSum2D*[T](data:seq[seq[T]]):CumulativeSum2D[T] =\n    result\
    \ = initCumulativeSum2D[T](data.len, data[0].len)\n    for i in 0..<data.len:\n\
    \      for j in 0..<data[i].len:\n        result.add(i,j,data[i][j])\n    result.build()\n\
    \  \n  proc add*[T](self:var CumulativeSum2D[T]; x, y:int, z:T) =\n    let (x,\
    \ y) = (x + 1, y + 1)\n    if x >= self.data.len or y >= self.data[0].len: return\n\
    \    self.data[x][y] += z\n  \n  proc build*[T](self:var CumulativeSum2D[T]) =\n\
    \    self.built = true\n    for i in 1..<self.data.len:\n      for j in 1..<self.data[i].len:\n\
    \        self.data[i][j] += self.data[i][j - 1] + self.data[i - 1][j] - self.data[i\
    \ - 1][j - 1]\n  \n  proc `[]`*[T](self: CumulativeSum2D[T], rx, ry:Slice[int]):T\
    \ =\n    assert(self.built)\n    let (gx, gy) = (rx.b+1, ry.b+1)\n    let (sx,\
    \ sy) = (rx.a, ry.a)\n    return self.data[gx][gy] - self.data[sx][gy] - self.data[gx][sy]\
    \ + self.data[sx][sy]\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/dp/cumulative_sum_2d.nim
  requiredBy: []
  timestamp: '2020-12-19 22:31:09+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/dp/cumulative_sum_2D_test.nim
  - verify/extra/dp/cumulative_sum_2D_test.nim
documentation_of: atcoder/extra/dp/cumulative_sum_2d.nim
layout: document
redirect_from:
- /library/atcoder/extra/dp/cumulative_sum_2d.nim
- /library/atcoder/extra/dp/cumulative_sum_2d.nim.html
title: atcoder/extra/dp/cumulative_sum_2d.nim
---
