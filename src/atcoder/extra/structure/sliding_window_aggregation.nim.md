---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
    title: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
  - icon: ':x:'
    path: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
    title: verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SLIDING_WINDOW_HPP:\n  const ATCODER_SLIDING_WINDOW_HPP*\
    \ = 1\n  type\n    SlidingWindowAggregationNode[T] = object\n      val, sum:T\n\
    \    SlidingWindowAggregation*[T] = object\n      f:proc(a, b:T):T\n      e:proc():T\n\
    \      front, back:seq[SlidingWindowAggregationNode[T]]\n\n  proc initSlidingWindowAggregation*[T](f:proc(a,\
    \ b:T):T, e:proc():T):SlidingWindowAggregation[T] = \n    result.f = f\n    result.e\
    \ = e\n\n  proc empty*[T](self:SlidingWindowAggregation[T]):bool =\n    return\
    \ self.front.len == 0 and self.back.len == 0\n\n  proc len*[T](self:SlidingWindowAggregation[T]):int\
    \ =\n    self.front.len + self.back.len\n\n  proc fold_all*[T](self:SlidingWindowAggregation[T]):T\
    \ =\n    if self.front.len == 0 and self.back.len == 0:\n      return self.e()\n\
    \    elif self.front.len == 0:\n      return self.back[^1].sum\n    elif self.back.len\
    \ == 0:\n      return self.front[^1].sum\n    else:\n      return self.f(self.front[^1].sum,\
    \ self.back[^1].sum);\n\n  proc push*[T](self:var SlidingWindowAggregation[T],\
    \ x:T) =\n    if self.back.len == 0:\n      self.back.add(SlidingWindowAggregationNode[T](val:x,\
    \ sum:x))\n    else:\n      self.back.add(SlidingWindowAggregationNode[T](val:x,\
    \ sum:self.f(self.back[^1].sum, x)))\n\n  proc pop*[T](self:var SlidingWindowAggregation[T])\
    \ =\n    if self.front.len == 0:\n      var b = self.back.pop()\n      b.sum =\
    \ b.val\n      self.front.add(b)\n      while self.back.len > 0:\n        let\
    \ b = self.back.pop()\n        self.front.add(SlidingWindowAggregationNode[T](val:b.val,\
    \ sum:self.f(b.val, self.front[^1].sum)));\n    discard self.front.pop()\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/sliding_window_aggregation.nim
  requiredBy: []
  timestamp: '2021-03-01 01:28:35+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
  - verify/extra/structure/yosupo_queue_operate_all_composite_test.nim
documentation_of: atcoder/extra/structure/sliding_window_aggregation.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/sliding_window_aggregation.nim
- /library/atcoder/extra/structure/sliding_window_aggregation.nim.html
title: atcoder/extra/structure/sliding_window_aggregation.nim
---
