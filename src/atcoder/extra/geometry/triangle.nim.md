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
  code: "when not declared ATCODER_TRIANGLE_HPP:\n  const ATCODER_TRIANGLE_HPP* =\
    \ 1\n  import atcoder/extra/geometry/geometry_template\n\n  proc centroid*[Real](a,b,c:Point[Real]):Point[Real]\
    \ =\n    result = a + b + c\n    result /= Real(3)\n  \n  proc incircle*[Real](a,b,c:Point[Real]):Circle[Real]\
    \ =\n    let\n      (x, y, z) = (abs(b - c), abs(c - a), abs(a - b))\n      p\
    \ = (a * x + b * y + c * z)/(x + y + z)\n    return initCircle(p, initLine(a,\
    \ b).distance(p))\n  proc incenter*[Real](a, b, c:Point[Real]):Point[Real] =\n\
    \    incircle(a, b, c).p\n  \n  proc excircle*[Real](a,b,c:Point[Real]):array[3,\
    \ Circle[Real]] =\n    let\n      (x, y, z) = (abs(b - c), abs(c - a), abs(a -\
    \ b))\n      pa = (- a * x + b * y + c * z)/(- x + y + z)\n      pb = (a * x -\
    \ b * y + c * z)/(x - y + z)\n      pc = (a * x + b * y - c * z)/(x + y - z)\n\
    \    return [initCircle(pa, initLine(b, c).distance(pa)), \n            initCircle(pb,\
    \ initLine(c, a).distance(pb)), \n            initCircle(pc, initLine(a, b).distance(pc))]\n\
    \  proc excenter*[Real](a, b, c:Point[Real]):array[3, Point[Real]] =\n    let\
    \ c = excircle(a, b, c)\n    return [c[0].p, c[1].p, c[2].p]\n  proc circumcircle*[Real](a,b,c:Point[Real]):Circle[Real]\
    \ =\n    initCircle(a, b, c)\n  proc circumcenter*[Real](a,b,c:Point[Real]):Point[Real]\
    \ =\n    initCircle(a, b, c).p\n  proc orthocenter*[Real](a,b,c:Point[Real]):Point[Real]\
    \ =\n    return crossPoint(\n             initLine(a, a.projection(initLine(b,\
    \ c))), \n             initLine(b, b.projection(initLine(a, b))))\n"
  dependsOn:
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/internal_complex.nim
  isVerificationFile: false
  path: atcoder/extra/geometry/triangle.nim
  requiredBy: []
  timestamp: '2022-08-25 23:07:00+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/geometry/triangle.nim
layout: document
redirect_from:
- /library/atcoder/extra/geometry/triangle.nim
- /library/atcoder/extra/geometry/triangle.nim.html
title: atcoder/extra/geometry/triangle.nim
---
