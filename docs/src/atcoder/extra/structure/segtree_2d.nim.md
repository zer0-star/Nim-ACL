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
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SEGTREE_2D_HPP:\n  const ATCODER_SEGTREE_2D_HPP*\
    \ = 1\n  import atcoder/segtree\n  type SegTree2D*[S; SegTree] = object\n    N2:\
    \ int\n    xs: seq[S]\n    ys: seq[seq[S]]\n    segt: seq[SegTree]\n\n  proc initSegTree2D*[S](v:\
    \ seq[tuple[x, y:int]], op: static[proc(a, b:S):S], e: static[proc():S]):auto\
    \ =\n    type st = SegTreeType[S](op, e)\n    result = SegTree2D[S, st]()\n  \
    \  for i in 0 ..< v.len: result.xs.add v[i].x\n    result.xs.sort\n    result.xs\
    \ = result.xs.deduplicate(true)\n    var N2 = 1\n    while N2 < result.xs.len:\
    \ N2 *= 2\n\n    result.ys.setLen(N2 * 2)\n    result.segt.setLen(N2 * 2)\n  \
    \  result.N2 = N2\n\n    for (x, y) in v:\n      let xi = result.xs.lowerBound(x)\n\
    \      var i = xi + result.N2\n      while i > 0:\n        result.ys[i].add y\n\
    \        i = i shr 1\n\n    for i in 1 ..< result.ys.len:\n      result.ys[i].sort\n\
    \      result.ys[i] = result.ys[i].deduplicate(true)\n      result.segt[i].init(result.ys[i].len)\n\
    \n  proc add*[ST:SegTree2D](self: var ST, x, y:int, v:ST.S) =\n    let xi = self.xs.lowerBound(x)\n\
    \    doAssert self.xs[xi] == x\n    var i = xi + self.N2\n    while i > 0:\n \
    \     let yi = self.ys[i].lowerBound(y)\n      doAssert self.ys[i][yi] == y\n\
    \      self.segt[i][yi] = self.SegTree.calc_op(self.segt[i][yi], v)\n      i =\
    \ i shr 1\n\n  proc get*[ST:SegTree2D](self: var ST, x, y:int):ST.S =\n    let\
    \ xi = self.xs.lowerBound(x)\n    doAssert self.xs[xi] == x\n    result = self.SegTree.calc_e()\n\
    \    var i = xi + self.N2\n    while i > 0:\n      let yi = self.ys[i].lowerBound(y)\n\
    \      doAssert self.ys[i][yi] == y\n      result = self.SegTree.calc_op(self.segt[i][yi],\
    \ result)\n      i = i shr 1\n  proc `[]`*[ST:SegTree2D](self: var ST, x, y:int):ST.S\
    \ = self.get(x, y)\n\n  proc prod*[ST:SegTree2D](self: var ST, xp, yp: Slice[int]\
    \ or int):ST.S =\n    when xp is int:\n      let xp = xp .. xp\n    when yp is\
    \ int:\n      let yp = yp .. yp\n    var\n      sml, smr = self.SegTree.calc_e()\n\
    \    let\n      xl = xp.a\n      xr = xp.b + 1\n      yl = yp.a\n      yr = yp.b\
    \ + 1\n      xil = self.xs.lowerBound(xl)\n      xir = self.xs.lowerBound(xr)\n\
    \    var\n      l = xil + self.N2\n      r = xir + self.N2\n    while l < r:\n\
    \      if (l and 1) != 0:\n        let\n          yli = self.ys[l].lowerBound(yl)\n\
    \          yri = self.ys[l].lowerBound(yr)\n        sml = self.SegTree.calc_op(self.segt[l][yli\
    \ ..< yri], sml)\n        l.inc\n      if (r and 1) != 0:\n        r.dec\n   \
    \     let\n          yli = self.ys[r].lowerBound(yl)\n          yri = self.ys[r].lowerBound(yr)\n\
    \        smr = self.SegTree.calc_op(self.segt[r][yli ..< yri], smr)\n      l =\
    \ l shr 1\n      r = r shr 1\n    return self.SegTree.calc_op(sml, smr)\n  proc\
    \ `[]`*[ST:SegTree2D](self: var ST, xp, yp: Slice[int] or int):ST.S = self.prod(xp,\
    \ yp)\n"
  dependsOn:
  - atcoder/internal_bit.nim
  - atcoder/segtree.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/segtree.nim
  - atcoder/internal_bit.nim
  - atcoder/segtree.nim
  - atcoder/rangeutils.nim
  - atcoder/rangeutils.nim
  - atcoder/internal_bit.nim
  - atcoder/segtree.nim
  isVerificationFile: false
  path: atcoder/extra/structure/segtree_2d.nim
  requiredBy: []
  timestamp: '2022-10-23 18:37:31+09:00'
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
