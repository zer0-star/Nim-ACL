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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_LI_CHAO_TREE_HPP:\n  const ATCODER_LI_CHAO_TREE_HPP*\
    \ = 1\n  import std/sequtils\n  type\n    Line*[T] = object\n      a, b:T\n  \
    \  LiChaoTree*[T] = object\n      len*: int\n      xs: seq[T]\n      seg: seq[Line[T]]\n\
    \  \n  proc initLine*[T](a, b:T):Line[T] = Line[T](a:a, b:b)\n  proc get*[T](self:\
    \ Line[T], x:T):T =\n    result = self.a * x + self.b\n  proc over*[T](self, b:\
    \ Line[T], x: T):bool = self.get(x) < b.get(x)\n  \n  proc initLiChaoTree*[T](x:\
    \ seq[T], inf_val:T):LiChaoTree[T] =\n    var xs = x\n    var len = 1\n    while\
    \ len < xs.len: len = len shl 1\n    while xs.len < len: xs.add(xs[^1] + 1)\n\
    \    #block:\n    #  var seg = newSeq[Line[T]](2 * len - 1)\n    #  for i in 0\
    \ ..< seg.len:\n    #    seg[i] = initLine(T(0), inf_val)\n    return LiChaoTree[T](len:len,\
    \ xs:xs, seg:newSeqWith(2 * len - 1, initLine(T(0), inf_val)))\n  \n  proc disjoint*(x,\
    \ y:Slice[int]):bool = x.b < y.a or y.b < x.a\n  proc subset*(x, y:Slice[int]):bool\
    \ = y.a <= x.a and x.b <= y.b\n\n  proc update*[T](self: var LiChaoTree[T], x:ptr[Line],\
    \ k:int, ks:Slice[int]) =\n    let (l, r) = (ks.a, ks.b + 1)\n    let mid = (l\
    \ + r) shr 1\n    let\n      latte = x[].over(self.seg[k], self.xs[l])\n     \
    \ malta = x[].over(self.seg[k], self.xs[mid])\n    if malta: swap(self.seg[k],\
    \ x[])\n    if l + 1 >= r: return\n    elif latte != malta: self.update(x, 2 *\
    \ k + 1, l ..< mid)\n    else: self.update(x, 2 * k + 2, mid ..< r)\n\n  \n  #proc\
    \ update*[T](self: var LiChaoTree[T], x:Line[T], s:Slice[int], k:int, ks:Slice[int])\
    \ =\n  #  if disjoint(s, ks): return\n  #  let (l, r) = (ks.a, ks.b + 1)\n  #\
    \  var m = (l + r) shr 1\n  #  if m == r: m -= 1\n  #  if not subset(ks, s):\n\
    \  #    self.update(x, s, 2 * k + 1, l..<m)\n  #    self.update(x, s, 2 * k +\
    \ 2, m..<r)\n  #  else:\n  #    let\n  #      latte = x.over(self.seg[k], self.xs[l])\n\
    \  #      malta = x.over(self.seg[k], self.xs[m])\n  #    var x = x\n  #    if\
    \ malta: swap(self.seg[k], x)\n  #    if l + 1 >= r: return\n  #    elif latte\
    \ != malta: self.update(x, s, 2 * k + 1, l..<m)\n  #    else: self.update(x, s,\
    \ 2 * k + 2, m..<r)\n  \n  proc update*[T](self: var LiChaoTree[T], a, b:T, s:Slice[int])\
    \ =\n    let l = initLine(a, b)\n    self.update(l, s, 0, 0..<self.len)\n  proc\
    \ update*[T](self: var LiChaoTree[T], a, b:T) =\n    var l = initLine(a, b)\n\
    \    #echo \"update: \", a, \" \", b\n    #self.update(l, 0..<self.len, 0, 0..<self.len)\n\
    \    self.update(l.addr, 0, 0..<self.len)\n\n  proc query*[T](self: var LiChaoTree[T],\
    \ k:int):T =\n    let x = self.xs[k]\n    #echo \"query: \", x\n    var k = k\
    \ + self.len - 1;\n    result = self.seg[k].get(x)\n    while k > 0:\n      k\
    \ = (k - 1) shr 1\n      result = min(result, self.seg[k].get(x))\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/li_chao_tree.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/li_chao_tree.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/li_chao_tree.nim
- /library/atcoder/extra/structure/li_chao_tree.nim.html
title: atcoder/extra/structure/li_chao_tree.nim
---
