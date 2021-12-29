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
    path: atcoder/extra/geometry/geometry_template.nim
    title: atcoder/extra/geometry/geometry_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/geometry_template.nim
    title: atcoder/extra/geometry/geometry_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/geometry_template.nim
    title: atcoder/extra/geometry/geometry_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/geometry_template.nim
    title: atcoder/extra/geometry/geometry_template.nim
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
    path: atcoder/extra/other/internal_complex.nim
    title: atcoder/extra/other/internal_complex.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/internal_complex.nim
    title: atcoder/extra/other/internal_complex.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/internal_complex.nim
    title: atcoder/extra/other/internal_complex.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/internal_complex.nim
    title: atcoder/extra/other/internal_complex.nim
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
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_5_a_closest_pair_test.nim
    title: verify/extra/geometry/aoj_cgl_5_a_closest_pair_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_5_a_closest_pair_test.nim
    title: verify/extra/geometry/aoj_cgl_5_a_closest_pair_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_5_A
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.1/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_CLOSEST_PAIR_HPP:\n  const ATCODER_CLOSEST_PAIR_HPP*\
    \ = 1\n  import atcoder/extra/other/internal_complex\n  import atcoder/extra/other/floatutils\n\
    \  import atcoder/extra/geometry/geometry_template\n\n  proc inplace_merge*[T](v:\
    \ var seq[T], left, mid, right: int, cmp:proc(a,b:T):bool) =\n    let\n      v1\
    \ = v[left..<mid]\n      v2 = v[mid..<right]\n    var\n      vi = left\n     \
    \ i, j = 0\n    while vi < right:\n      var is_v1: bool\n      if i == v1.len:\
    \ is_v1 = false\n      elif j == v2.len: is_v1 = true\n      else:\n        if\
    \ cmp(v2[j], v1[i]): is_v1 = false\n        else: is_v1 = true\n      if is_v1:\
    \ v[vi] = v1[i];vi.inc;i.inc\n      else: v[vi] = v2[j];vi.inc;j.inc\n  \n  #\
    \ http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_5_A\n  proc closest_pair*[Real](ps:\
    \ seq[Point[Real]]):Real =\n  #  if ps.len <= 1: throw (0)\n    if ps.len <= 1:\
    \ assert(false)\n    var ps = ps\n    ps.sort() do (x, y:Point[Real]) -> int:\n\
    \      if x <~ y: -1\n      elif x >~ y: 1\n      else: 0\n  \n    proc compare_y(a,\
    \ b:Point[Real]):bool =\n      return a.im <~ b.im\n  \n    var beet = newSeq[Point[Real]](ps.len)\n\
    \    let INF = 1e+100\n  \n    proc rec(left, right:int):Real =\n      if right\
    \ - left <= 1: return INF\n      let mid = (left + right) shr 1\n      let x =\
    \ ps[mid].re\n      result = min(rec(left, mid), rec(mid, right))\n      # TODO\n\
    \  #    inplace_merge(begin(ps) + left, begin(ps) + mid, begin(ps) + right, compare_y);\n\
    \      ps.inplace_merge(left, mid, right, compare_y)\n      var p = 0;\n     \
    \ for i in left..<right:\n        if abs(ps[i].re - x) >=~ result: continue\n\
    \        for j in 0..<p:\n          let luz = ps[i] - beet[p - j - 1]\n      \
    \    if luz.im >=~ result: break\n          result = min(result, abs(luz))\n \
    \       beet[p] = ps[i];\n        p += 1\n    return rec(0, ps.len)\n  # }}}\n"
  dependsOn:
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/static_var.nim
  isVerificationFile: false
  path: atcoder/extra/geometry/closest_pair.nim
  requiredBy: []
  timestamp: '2021-05-22 03:00:32+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/geometry/aoj_cgl_5_a_closest_pair_test.nim
  - verify/extra/geometry/aoj_cgl_5_a_closest_pair_test.nim
documentation_of: atcoder/extra/geometry/closest_pair.nim
layout: document
redirect_from:
- /library/atcoder/extra/geometry/closest_pair.nim
- /library/atcoder/extra/geometry/closest_pair.nim.html
title: atcoder/extra/geometry/closest_pair.nim
---
