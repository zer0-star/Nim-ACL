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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import sequtils\n\n# DualCumulativeSum2D(imos) {{{\ntype DualCumulativeSum2D*[T]\
    \ = object\n  X, Y:int\n  built: bool\n  data: seq[seq[T]]\n\nproc init*[T](self:var\
    \ DualCumulativeSum2D[T], X, Y:int) =\n  self.X = X\n  self.Y = Y\n  self.built\
    \ = false\n  if self.data.len < X + 1 or self.data[0].len < Y + 1:\n    self.data\
    \ = newSeqWith(X + 1, newSeqWith(Y + 1, T(0)))\n  else:\n    for x in 0..<X+1:\n\
    \      for y in 0..<Y+1:\n        self.data[x][y] = T(0)\n\nproc initDualCumulativeSum2D*[T](X,\
    \ Y:int):DualCumulativeSum2D[T] =\n  result.init(X, Y)\n\n#proc initDualCumulativeSum2D[T](data:seq[seq[T]]):CumulativeSum2D[T]\
    \ =\n#  result = initCumulativeSum2D[T](data.len, data[0].len)\n#  for i in 0..<data.len:\n\
    #    for j in 0..<data[i].len:\n#      result.add(i,j,data[i][j])\n#  result.build()\n\
    \nproc add*[T](self:var DualCumulativeSum2D[T]; rx, ry: Slice[int], z:T) =\n \
    \ assert not self.built\n  let (gx, gy) = (rx.b + 1, ry.b + 1)\n  let (sx, sy)\
    \ = (rx.a, ry.a)\n  self.data[gx][gy] += z\n  self.data[sx][gy] -= z\n  self.data[gx][sy]\
    \ -= z\n  self.data[sx][sy] += z\n\nproc build*[T](self:var DualCumulativeSum2D[T])\
    \ =\n  self.built = true\n  for i in 1..<self.data.len:\n    for j in 0..<self.data[0].len:\n\
    \      self.data[i][j] += self.data[i - 1][j]\n  for j in 1..<self.data[0].len:\n\
    \    for i in 0..<self.data.len:\n      self.data[i][j] += self.data[i][j - 1]\n\
    \nproc `[]`*[T](self: DualCumulativeSum2D[T], x:int, y:int):T =\n  assert(self.built)\n\
    #  let (x, y) = (x + 1, y + 1)\n  if x >= self.data.len or y >= self.data[0].len:\
    \ return T(0)\n  return self.data[x][y]\n\nproc write*[T](self: DualCumulativeSum2D[T])\
    \ =\n  assert(self.built)\n  for i in 0..<self.X:\n    for j in 0..<self.Y:\n\
    \      stdout.write(self[i,j])\n    echo \"\"\n#}}}\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/dp/dual_cumulative_sum_2d.nim
  requiredBy: []
  timestamp: '2021-11-18 02:47:29+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/dp/cumulative_sum_2D_test.nim
  - verify/extra/dp/cumulative_sum_2D_test.nim
documentation_of: atcoder/extra/dp/dual_cumulative_sum_2d.nim
layout: document
redirect_from:
- /library/atcoder/extra/dp/dual_cumulative_sum_2d.nim
- /library/atcoder/extra/dp/dual_cumulative_sum_2d.nim.html
title: atcoder/extra/dp/dual_cumulative_sum_2d.nim
---
