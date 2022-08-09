---
data:
  _extendedDependsOn: []
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/header/chaemon_header.nim
    title: atcoder/extra/header/chaemon_header.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template.nim
    title: atcoder/extra/template/atcoder-tools_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_global.nim
    title: atcoder/extra/template/atcoder-tools_template_global.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/atcoder-tools_template_with_solve.nim
    title: atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/template.nim
    title: atcoder/extra/template/template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  - icon: ':warning:'
    path: atcoder/extra/template/vim_template.nim
    title: atcoder/extra/template/vim_template.nim
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SLICEUTILS_HPP:\n  const ATCODER_SLICEUTILS_HPP*\
    \ = 1\n  proc index*[T](a:openArray[T]):Slice[int] =\n    a.low..a.high\n  type\
    \ ReversedSlice[T] = distinct Slice[T]\n  type StepSlice[T] = object\n    s:Slice[T]\n\
    \    d:T\n  proc rev*[T](p:Slice[T]):ReversedSlice[T] = ReversedSlice[T](p)\n\
    \  iterator items*(n:int):int = (for i in 0..<n: yield i)\n  iterator items*[T](p:ReversedSlice[T]):T\
    \ =\n    if Slice[T](p).b >= Slice[T](p).a:\n      var i = Slice[T](p).b\n   \
    \   while true:\n        yield i\n        if i == Slice[T](p).a:break\n      \
    \  i.dec\n  proc `>>`*[T](s:Slice[T], d:T):StepSlice[T] =\n    assert d != 0\n\
    \    StepSlice[T](s:s, d:d)\n  proc `<<`*[T](s:Slice[T], d:T):StepSlice[T] =\n\
    \    assert d != 0\n    StepSlice[T](s:s, d: -d)\n  proc low*[T](s:StepSlice[T]):T\
    \ = s.s.a\n  proc high*[T](s:StepSlice[T]):T =\n    let p = s.s.b - s.s.a\n  \
    \  if p < 0: return s.low - 1\n    let d = abs(s.d)\n    return s.s.a + (p div\
    \ d) * d\n  iterator items*[T](p:StepSlice[T]):T = \n    assert p.d != 0\n   \
    \ if p.s.a <= p.s.b:\n      if p.d > 0:\n        var i = p.low\n        let h\
    \ = p.high\n        while i <= h:\n          yield i\n          if i == h: break\n\
    \          i += p.d\n      else:\n        var i = p.high\n        let l = p.low\n\
    \        while i >= l:\n          yield i\n          if i == l: break\n      \
    \    i += p.d\n  proc `[]`*[T:SomeInteger, U](a:openArray[U], s:Slice[T]):seq[U]\
    \ =\n    for i in s:result.add(a[i])\n  proc `[]=`*[T:SomeInteger, U](a:var openArray[U],\
    \ s:StepSlice[T], b:openArray[U]) =\n    var j = 0\n    for i in s:\n      a[i]\
    \ = b[j]\n      j.inc\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/sliceutils.nim
  requiredBy:
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/header/chaemon_header.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/vim_template.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template_with_solve.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/atcoder-tools_template_global.nim
  - atcoder/extra/template/template.nim
  - atcoder/extra/template/template.nim
  timestamp: '2020-12-31 00:01:54+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/sliceutils.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/sliceutils.nim
- /library/atcoder/extra/other/sliceutils.nim.html
title: atcoder/extra/other/sliceutils.nim
---
