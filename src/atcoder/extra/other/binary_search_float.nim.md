---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  _extendedRequiredBy: []
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
  code: "when not declared ATCODER_BINARY_SEARCH_FLOAT_HPP:\n  const ATCODER_BINARY_SEARCH_FLOAT_HPP*\
    \ = 1\n  import std/sugar\n  import atcoder/extra/other/floatutils\n\n  proc minLeft*[Real](f:(Real)->bool,\
    \ s: Slice[Real]):Real =\n    var (l, r) = (s.a, s.b)\n    if not f(r): return\
    \ Real.getInf\n    while not valid_range(l, r):\n      let m = (l + r) / Real(2)\n\
    \      if f(m): r = m\n      else: l = m\n    return r\n  proc maxRight*[Real](f:(Real)->bool,\
    \ s: Slice[Real]):Real =\n    var (l, r) = (s.a, s.b)\n    if not f(l): return\
    \ -Real.getInf\n    while not valid_range(l, r):\n      let m = (l + r) / Real(2)\n\
    \      if f(m): l = m\n      else: r = m\n    return l\n"
  dependsOn:
  - atcoder/extra/other/floatutils.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/floatutils.nim
  isVerificationFile: false
  path: atcoder/extra/other/binary_search_float.nim
  requiredBy: []
  timestamp: '2022-02-05 00:42:13+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/binary_search_float.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/binary_search_float.nim
- /library/atcoder/extra/other/binary_search_float.nim.html
title: atcoder/extra/other/binary_search_float.nim
---
