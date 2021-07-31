---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
  - icon: ':warning:'
    path: atcoder/maxflow.nim
    title: atcoder/maxflow.nim
  - icon: ':warning:'
    path: test/example/maxflow_practice.nim
    title: test/example/maxflow_practice.nim
  - icon: ':warning:'
    path: test/example/maxflow_practice.nim
    title: test/example/maxflow_practice.nim
  - icon: ':warning:'
    path: tests/test_maxflow.nim
    title: tests/test_maxflow.nim
  - icon: ':warning:'
    path: tests/test_maxflow.nim
    title: tests/test_maxflow.nim
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
  code: "when not declared ATCODER_INTERNAL_QUEUE_HPP:\n  const ATCODER_INTERNAL_QUEUE_HPP*\
    \ = 1\n\n  type simple_queue[T] = object\n    payload:seq[T]\n    pos:int\n  proc\
    \ init_simple_queue*[T]():auto = simple_queue[T](payload:newSeq[T](), pos:0)\n\
    # TODO\n#      void reserve(int n) { payload.reserve(n); }\n  proc len*[T](self:simple_queue[T]):int\
    \ = self.payload.len - self.pos\n  proc empty*[T](self:simple_queue[T]):bool =\
    \ self.pos == self.payload.len\n  proc push*[T](self:var simple_queue[T], t:T)\
    \ = self.payload.add(t)\n  proc front*[T](self:simple_queue[T]):T = self.payload[self.pos]\n\
    \  proc clear*[T](self:var simple_queue[T]) =\n    self.payload.setLen(0)\n  \
    \  self.pos = 0;\n  proc pop*[T](self:var simple_queue[T]) = self.pos.inc\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/internal_queue.nim
  requiredBy:
  - atcoder/maxflow.nim
  - atcoder/maxflow.nim
  - tests/test_maxflow.nim
  - tests/test_maxflow.nim
  - test/example/maxflow_practice.nim
  - test/example/maxflow_practice.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/internal_queue.nim
layout: document
redirect_from:
- /library/atcoder/internal_queue.nim
- /library/atcoder/internal_queue.nim.html
title: atcoder/internal_queue.nim
---
