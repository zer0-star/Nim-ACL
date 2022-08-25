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
    path: verify/extra/geometry/aoj_cgl_7_f_tangent_to_a_circle_test.nim
    title: verify/extra/geometry/aoj_cgl_7_f_tangent_to_a_circle_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_7_f_tangent_to_a_circle_test.nim
    title: verify/extra/geometry/aoj_cgl_7_f_tangent_to_a_circle_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_7_g_common_tangent_test.nim
    title: verify/extra/geometry/aoj_cgl_7_g_common_tangent_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_7_g_common_tangent_test.nim
    title: verify/extra/geometry/aoj_cgl_7_g_common_tangent_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_F
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_G
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_TANGENT_HPP:\n  const ATCODER_TANGENT_HPP* = 1\n\
    \  import std/math\n  import atcoder/extra/other/floatutils\n  import atcoder/extra/other/internal_complex\n\
    \  import atcoder/extra/geometry/geometry_template\n  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_F\n\
    \  # tangent of circle c through point p\n  proc tangent*[Real](c1: Circle[Real],\
    \ p2:Point[Real]):(Point[Real], Point[Real]) =\n    return crosspoint(c1, initCircle(p2,\
    \ sqrt(norm(c1.p - p2) - c1.r * c1.r)))\n  \n  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_G\n\
    \  # common tangent of circles c1 and c2\n  proc tangent*[Real](c1, c2: Circle[Real]):seq[Line[Real]]\
    \ =\n    result = newSeq[Line[Real]]()\n    if c1.r <~ c2.r:\n      result = tangent(c2,\
    \ c1)\n      for l in result.mitems:\n        swap(l.a, l.b)\n      return\n \
    \   let g = norm(c1.p - c2.p)\n    if g =~ 0.Real: return\n    let\n      u =\
    \ (c2.p - c1.p) / sqrt(g)\n  #    v = rotate(PI * 0.5, u)\n      xx = rotate(PI\
    \ * 0.5.Real, initPoint(1.Real, 0.Real))\n      v = initPoint(- u.im, u.re)\n\
    \    for s in [-1, 1]:\n      let h = (c1.r + s.Real * c2.r) / sqrt(g)\n     \
    \ let d = 1.Real - h * h\n      if d =~ 0.Real:\n        result.add(initLine(c1.p\
    \ + u * c1.r.complex, c1.p + (u + v) * c1.r.complex))\n      elif d >~ 0.Real:\n\
    \        let\n          uu = u * h.complex\n          vv = v * sqrt(1 - h * h).complex\n\
    \        result.add(initLine(c1.p + (uu + vv) * c1.r.complex, c2.p - (uu + vv)\
    \ * c2.r.complex * s.Real.complex))\n        result.add(initLine(c1.p + (uu -\
    \ vv) * c1.r.complex, c2.p - (uu - vv) * c2.r.complex * s.Real.complex))\n"
  dependsOn:
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/floatutils.nim
  isVerificationFile: false
  path: atcoder/extra/geometry/tangent.nim
  requiredBy: []
  timestamp: '2022-08-25 23:07:00+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/geometry/aoj_cgl_7_f_tangent_to_a_circle_test.nim
  - verify/extra/geometry/aoj_cgl_7_f_tangent_to_a_circle_test.nim
  - verify/extra/geometry/aoj_cgl_7_g_common_tangent_test.nim
  - verify/extra/geometry/aoj_cgl_7_g_common_tangent_test.nim
documentation_of: atcoder/extra/geometry/tangent.nim
layout: document
redirect_from:
- /library/atcoder/extra/geometry/tangent.nim
- /library/atcoder/extra/geometry/tangent.nim.html
title: atcoder/extra/geometry/tangent.nim
---
