---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/internal_bit.nim
    title: atcoder/internal_bit.nim
  - icon: ':question:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':question:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':question:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':question:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/segtree.nim
    title: atcoder/segtree.nim
  - icon: ':x:'
    path: atcoder/segtree.nim
    title: atcoder/segtree.nim
  - icon: ':x:'
    path: atcoder/segtree.nim
    title: atcoder/segtree.nim
  - icon: ':x:'
    path: atcoder/segtree.nim
    title: atcoder/segtree.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/structure/yosupo_point_add_rectangle_sum_2d_segtree_test.nim
    title: verify/extra/structure/yosupo_point_add_rectangle_sum_2d_segtree_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_point_add_rectangle_sum_2d_segtree_test.nim
    title: verify/extra/structure/yosupo_point_add_rectangle_sum_2d_segtree_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SEGTREE_2D_HPP:\n  const ATCODER_SEGTREE_2D_HPP*\
    \ = 1\n  import atcoder/segtree\n  type SegTree2D*[S; SegTree] = object\n    N2:\
    \ int\n    xs: seq[S]\n    ys: seq[seq[S]]\n    segt: seq[SegTree]\n\n  proc initSegTree2D*[S](v:\
    \ seq[tuple[x, y:int]], op: static[proc(a, b:S):S], e: static[proc():S]):auto\
    \ =\n    type st = SegTreeType[S](op, e)\n    result = SegTree2D[S, st]()\n  \
    \  for i in 0 ..< v.len: result.xs.add v[i].x\n    result.xs.sort\n    result.xs\
    \ = result.xs.deduplicate(true)\n    var N2 = 1\n    while N2 < result.xs.len:\
    \ N2 *= 2\n\n    result.ys.setLen(N2 * 2)\n    result.segt.setLen(N2 * 2)\n  \
    \  result.N2 = N2\n\n    var result_p = result.addr\n    proc setYs(i, xi, y,\
    \ l, r:int) =\n      result_p[].ys[i].add y\n      if r - l > 1:\n        let\
    \ m = (l + r) shr 1\n        if xi in l ..< m:\n          setYs(i * 2 + 1, xi,\
    \ y, l, m)\n        else:\n          setYs(i * 2 + 2, xi, y, m, r)\n\n    for\
    \ (x, y) in v:\n      let xi = result.xs.lowerBound(x)\n      setYs(0, xi, y,\
    \ 0, N2)\n    for i in 0 ..< result.ys.len:\n      result.ys[i].sort;result.ys[i]\
    \ = result.ys[i].deduplicate(true)\n      result.segt[i].init(result.ys[i].len)\n\
    \n  proc set*[ST:SegTree2D](self:var ST, i, xi, y: int, v:ST.S, l, r:int) =\n\
    \    let yi = self.ys[i].lowerBound(y)\n    self.segt[i][yi] = v\n    if r - l\
    \ > 1:\n      let m = (l + r) shr 1\n      if xi in l ..< m:\n        self.set(i\
    \ * 2 + 1, xi, y, v, l, m)\n      else:\n        self.set(i * 2 + 2, xi, y, v,\
    \ m, r)\n  proc get*[ST:SegTree2D](self:ST, i, xi, y: int, l, r:int):ST.S =\n\
    \    if r - l > 1:\n      let m = (l + r) shr 1\n      if xi in l ..< m:\n   \
    \     return self.get(i * 2 + 1, xi, y, l, m)\n      else:\n        return self.get(i\
    \ * 2 + 2, xi, y, m, r)\n    else:\n      let yi = self.ys[i].lowerBound(y)\n\
    \      return self.segt[i][yi]\n\n\n  proc prod*[ST:SegTree2D](self: ST, i, xil,\
    \ xir, yl, yr, l, r:int):int =\n    if xir <= l or r <= xil: return self.SegTree.calc_e()\n\
    \    elif xil <= l and r <= xir:\n      let\n        yil = self.ys[i].lowerBound(yl)\n\
    \        yir = self.ys[i].lowerBound(yr)\n      return self.segt[i][yil ..< yir]\n\
    \    else:\n      let m = (l + r) shr 1\n      return self.SegTree.calc_op(self.prod(i\
    \ * 2 + 1, xil, xir, yl, yr, l, m), self.prod(i * 2 + 2, xil, xir, yl, yr, m,\
    \ r))\n  \n  proc set*[ST:SegTree2D](self: var ST, x, y:int, v:ST.S) =\n    let\
    \ xi = self.xs.lowerBound(x)\n    self.set(0, xi, y, v, 0, self.N2)\n  proc `[]=`*[ST:SegTree2D](self:\
    \ var ST, x, y:int, v:ST.S) = self.set(x, y, v)\n  proc get*[ST:SegTree2D](self:\
    \ var ST, x, y:int):ST.S =\n    let xi = self.xs.lowerBound(x)\n    return self.get(0,\
    \ xi, y, 0, self.N2)\n  proc `[]`*[ST:SegTree2D](self: var ST, x, y:int):ST.S\
    \ = self.get(x, y)\n\n  proc prod*[ST:SegTree2D](self: var ST, xp, yp: Slice[int]\
    \ or int):ST.S =\n    when xp is int:\n      let xp = xp .. xp\n    when yp is\
    \ int:\n      let yp = yp .. yp\n    let\n      xl = xp.a\n      xr = xp.b + 1\n\
    \      yl = yp.a\n      yr = yp.b + 1\n      xil = self.xs.lowerBound(xl)\n  \
    \    xir = self.xs.lowerBound(xr)\n    self.prod(0, xil, xir, yl, yr, 0, self.N2)\n\
    \  proc `[]`*[ST:SegTree2D](self: var ST, xp, yp: Slice[int] or int):ST.S = self.prod(xp,\
    \ yp)\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/segtree.nim
  - atcoder/segtree.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/internal_bit.nim
  - atcoder/segtree.nim
  - atcoder/segtree.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  isVerificationFile: false
  path: atcoder/extra/structure/segtree_2d.nim
  requiredBy: []
  timestamp: '2022-09-17 04:52:33+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/yosupo_point_add_rectangle_sum_2d_segtree_test.nim
  - verify/extra/structure/yosupo_point_add_rectangle_sum_2d_segtree_test.nim
documentation_of: atcoder/extra/structure/segtree_2d.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/segtree_2d.nim
- /library/atcoder/extra/structure/segtree_2d.nim.html
title: atcoder/extra/structure/segtree_2d.nim
---
