---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':warning:'
    path: atcoder/extra/other/assignment_operator.nim
    title: atcoder/extra/other/assignment_operator.nim
  - icon: ':warning:'
    path: atcoder/extra/other/assignment_operator.nim
    title: atcoder/extra/other/assignment_operator.nim
  - icon: ':warning:'
    path: atcoder/extra/other/debug.nim
    title: atcoder/extra/other/debug.nim
  - icon: ':warning:'
    path: atcoder/extra/other/debug.nim
    title: atcoder/extra/other/debug.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':x:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':x:'
    path: atcoder/extra/other/internal_sugar.nim
    title: atcoder/extra/other/internal_sugar.nim
  - icon: ':x:'
    path: atcoder/extra/other/internal_underscored_calls.nim
    title: atcoder/extra/other/internal_underscored_calls.nim
  - icon: ':x:'
    path: atcoder/extra/other/internal_underscored_calls.nim
    title: atcoder/extra/other/internal_underscored_calls.nim
  - icon: ':warning:'
    path: atcoder/extra/other/reader.nim
    title: atcoder/extra/other/reader.nim
  - icon: ':warning:'
    path: atcoder/extra/other/reader.nim
    title: atcoder/extra/other/reader.nim
  - icon: ':warning:'
    path: atcoder/extra/other/reference.nim
    title: atcoder/extra/other/reference.nim
  - icon: ':warning:'
    path: atcoder/extra/other/reference.nim
    title: atcoder/extra/other/reference.nim
  - icon: ':warning:'
    path: atcoder/extra/other/seq_array_utils.nim
    title: atcoder/extra/other/seq_array_utils.nim
  - icon: ':warning:'
    path: atcoder/extra/other/seq_array_utils.nim
    title: atcoder/extra/other/seq_array_utils.nim
  - icon: ':warning:'
    path: atcoder/extra/other/sliceutils.nim
    title: atcoder/extra/other/sliceutils.nim
  - icon: ':warning:'
    path: atcoder/extra/other/sliceutils.nim
    title: atcoder/extra/other/sliceutils.nim
  - icon: ':warning:'
    path: atcoder/extra/other/solve_proc.nim
    title: atcoder/extra/other/solve_proc.nim
  - icon: ':warning:'
    path: atcoder/extra/other/solve_proc.nim
    title: atcoder/extra/other/solve_proc.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':warning:'
    path: atcoder/extra/other/warlus_operator.nim
    title: atcoder/extra/other/warlus_operator.nim
  - icon: ':warning:'
    path: atcoder/extra/other/warlus_operator.nim
    title: atcoder/extra/other/warlus_operator.nim
  - icon: ':warning:'
    path: atcoder/extra/other/zip.nim
    title: atcoder/extra/other/zip.nim
  - icon: ':warning:'
    path: atcoder/extra/other/zip.nim
    title: atcoder/extra/other/zip.nim
  _extendedRequiredBy: []
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
  code: "when not declared ATCODER_CHAEMON_HEADER_HPP:\n  const ATCODER_CHAEMON_HEADER_HPP*\
    \ = 1\n  {.hints:off warnings:off assertions:on optimization:speed.}\n  {.checks:off.}\n\
    \  when declared(DO_CHECK):\n    when DO_CHECK:\n      {.checks:on.}\n  import\
    \ std/algorithm as algorithm_lib\n  import std/sequtils as sequtils_lib\n  import\
    \ std/macros as macros_lib\n  import std/math as math_lib\n  import std/sets as\
    \ sets_lib\n  import std/tables as tables_lib\n  import std/strutils as strutils_lib\n\
    \  import std/strformat as strformat_lib\n  import std/options as options_lib\n\
    \  import std/bitops as bitops_lib\n  import std/streams as streams_lib\n\n  import\
    \ atcoder/extra/other/internal_sugar\n  import atcoder/extra/other/reader\n  import\
    \ atcoder/extra/other/sliceutils\n  import atcoder/extra/other/assignment_operator\n\
    \  import atcoder/extra/other/inf\n  import atcoder/extra/other/warlus_operator\n\
    \  import atcoder/extra/other/seq_array_utils\n  include atcoder/extra/other/debug\n\
    \  import atcoder/extra/other/reference\n  import atcoder/extra/other/floatutils\n\
    \  import atcoder/extra/other/zip\n  import atcoder/extra/other/solve_proc\n\n\
    #  converter toBool[T:ref object](x:T):bool = x != nil\n#  converter toBool[T](x:T):bool\
    \ = x != T(0)\n  # misc\n  proc `<`[T](a, b:seq[T]):bool =\n    for i in 0 ..<\
    \ min(a.len, b.len):\n      if a[i] < b[i]: return true\n      elif a[i] > b[i]:\
    \ return false\n    if a.len < b.len: return true\n    else: return false\n\n\
    \  proc ceilDiv*[T:SomeInteger](a, b:T):T =\n    assert b != 0\n    if b < 0:\
    \ return ceilDiv(-a, -b)\n    result = a.floorDiv(b)\n    if a mod b != 0: result.inc\n"
  dependsOn:
  - atcoder/extra/other/zip.nim
  - atcoder/extra/other/zip.nim
  - atcoder/extra/other/internal_underscored_calls.nim
  - atcoder/extra/other/internal_underscored_calls.nim
  - atcoder/extra/other/assignment_operator.nim
  - atcoder/extra/other/reference.nim
  - atcoder/extra/other/reference.nim
  - atcoder/extra/other/assignment_operator.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/debug.nim
  - atcoder/extra/other/debug.nim
  - atcoder/extra/other/sliceutils.nim
  - atcoder/extra/other/sliceutils.nim
  - atcoder/extra/other/reader.nim
  - atcoder/extra/other/reader.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/warlus_operator.nim
  - atcoder/extra/other/warlus_operator.nim
  - atcoder/extra/other/seq_array_utils.nim
  - atcoder/extra/other/seq_array_utils.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/solve_proc.nim
  - atcoder/extra/other/solve_proc.nim
  - atcoder/extra/other/internal_sugar.nim
  - atcoder/extra/other/internal_sugar.nim
  isVerificationFile: false
  path: atcoder/extra/header/chaemon_header.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/header/chaemon_header.nim
layout: document
redirect_from:
- /library/atcoder/extra/header/chaemon_header.nim
- /library/atcoder/extra/header/chaemon_header.nim.html
title: atcoder/extra/header/chaemon_header.nim
---
