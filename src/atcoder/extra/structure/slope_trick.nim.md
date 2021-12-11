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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SLOPE_TRICK_HPP:\n  const ATCODER_SLOPE_TRICK_HPP*\
    \ = 1\n#  const T INF[T] = numeric_limits< T >::max() / 3;\n  import heapqueue\n\
    \n  type SlopeTrick*[T] = object\n    min_f, inf:T\n    L, R:HeapQueue[T]\n  \
    \  add_left, add_right: T\n#    priority_queue< T, vector< T >, less<> > L;\n\
    #    priority_queue< T, vector< T >, greater<> > R;\n\n  proc initSlopeTrick*[T]():SlopeTrick[T]\
    \ =\n    return SlopeTrick[T](min_f: 0, inf:T.high div 3, add_left: 0, add_right:\
    \ 0)\n\n  proc push_R*[T](self: var SlopeTrick[T], a:T) =\n    self.R.push(a -\
    \ self.add_right)\n \n  proc top_R*[T](self:SlopeTrick[T]):T =\n    if self.R.len\
    \ == 0: return self.inf\n    else: return self.R[0] + self.add_right\n \n  proc\
    \ pop_R*[T](self:var SlopeTrick[T]):T =\n    var val = self.top_R()\n    if self.R.len\
    \ > 0: discard self.R.pop()\n    return val\n\n  proc push_L*[T](self:var SlopeTrick[T],\
    \ a:T) =\n    self.L.push(-(a - self.add_left))\n \n  proc top_L*[T](self: SlopeTrick[T]):T\
    \ =\n    if self.L.len == 0: return -self.inf\n    else: return -self.L[0] + self.add_left\n\
    \ \n  proc pop_L*[T](self:var SlopeTrick[T]):T =\n    var val = self.top_L()\n\
    \    if self.L.len > 0: discard self.L.pop()\n    return val\n \n  proc len*[T](self:SlopeTrick[T]):int\
    \ =\n    return self.L.len + self.R.len\n \n#public:\n#  SlopeTrick() : min_f(0),\
    \ add_left(0), add_right(0) {}\n \n  type Query*[T] = object\n    lx*, rx*, min_f*:T\n\
    \n  # return min f(x)\n  proc query*[T](self:SlopeTrick[T]):Query[T] =\n    return\
    \ Query[T](lx:self.top_L(), rx:self.top_R(), min_f:self.min_f)\n\n  # f(x) +=\
    \ a\n  proc add_all*[T](self:var SlopeTrick[T], a:T) =\n    self.min_f += a\n\n\
    \  # add \\_\n  # f(x) += max(a - x, 0)\n  proc add_a_minus_x*[T](self: var SlopeTrick[T],\
    \ a:T) =\n    self.min_f += max(T(0), a - self.top_R())\n    self.push_R(a)\n\
    \    self.push_L(self.pop_R())\n\n  # add _/\n  # f(x) += max(x - a, 0)\n  proc\
    \ add_x_minus_a*[T](self: var SlopeTrick[T], a:T) =\n    self.min_f += max(T(0),\
    \ self.top_L() - a)\n    self.push_L(a)\n    self.push_R(self.pop_L())\n\n  #\
    \ add \\/\n  # f(x) += abs(x - a)\n  proc add_abs*[T](self: var SlopeTrick[T],\
    \ a:T) =\n    self.add_a_minus_x(a)\n    self.add_x_minus_a(a)\n\n  # \\/ -> \\\
    _\n  # f_{new} (x) = min f(y) (y <= x)\n  proc clear_right*[T](self: var SlopeTrick[T])\
    \ =\n    while self.R.len > 0: discard self.R.pop()\n \n  # \\/ -> _/\n  # f_{new}\
    \ (x) = min f(y) (y >= x)\n  proc clear_left*[T](self: var SlopeTrick[T]) =\n\
    \    while self.L.len > 0: discard self.L.pop()\n \n  # \\/ -> \\_/\n  # f_{new}\
    \ (x) = min f(y) (x-b <= y <= x-a)\n  proc shift*[T](self: var SlopeTrick[T],\
    \ a, b:T) =\n    assert a <= b\n    self.add_left += a\n    self.add_right +=\
    \ b\n \n  # \\/. -> .\\/\n  # f_{new} (x) = f(x - a)\n  proc shift*[T](self: var\
    \ SlopeTrick[T], a:T) =\n    self.shift(a, a)\n \n  # L, R \u3092\u7834\u58CA\u3059\
    \u308B\n  proc get*[T](self: var SlopeTrick[T], x:T):T =\n    result = self.min_f\n\
    \    while self.L.len > 0:\n      result += max(T(0), self.pop_L() - x)\n    while\
    \ self.R.len > 0:\n      result += max(T(0), x - self.pop_R())\n \n  proc merge*[T](self,\
    \ st: var SlopeTrick[T]) =\n    if st.len > self.len:\n      swap self.st.L, self.L\n\
    \      swap self.st.R, self.R\n      swap self.st.add_left, self.add_left\n  \
    \    swap self.st.add_right, self.add_right\n      swap self.st.min_f, self.min_f\n\
    \    while not st.R.len == 0:\n      add_x_minus_a(st.pop_R())\n    while not\
    \ st.L.len == 0:\n      add_a_minus_x(st.pop_L())\n    self.min_f += st.min_f\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/structure/slope_trick.nim
  requiredBy: []
  timestamp: '2021-11-18 02:51:01+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/structure/slope_trick.nim
layout: document
redirect_from:
- /library/atcoder/extra/structure/slope_trick.nim
- /library/atcoder/extra/structure/slope_trick.nim.html
title: atcoder/extra/structure/slope_trick.nim
---
