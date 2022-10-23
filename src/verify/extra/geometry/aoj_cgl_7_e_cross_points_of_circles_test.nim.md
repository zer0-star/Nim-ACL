---
data:
  _extendedDependsOn:
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
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    ERROR: 1e-6
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_E
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_E
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_E\n\
    # verify-helper: ERROR 1e-6\n\ninclude atcoder/header\nimport atcoder/extra/geometry/geometry_template\n\
    \nblock main:\n  let\n    c1, c2 = initCircle(initPoint(nextFloat(), nextFloat()),\
    \ nextFloat())\n  var  v = cross_point(c1, c2)\n  if v[0] >~ v[1]: swap(v[0],\
    \ v[1])\n  echo v[0].toString(), \" \", v[1].toString()\n"
  dependsOn:
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/header.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/geometry/aoj_cgl_7_e_cross_points_of_circles_test.nim
  requiredBy: []
  timestamp: '2022-08-25 23:07:00+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/geometry/aoj_cgl_7_e_cross_points_of_circles_test.nim
layout: document
redirect_from:
- /verify/verify/extra/geometry/aoj_cgl_7_e_cross_points_of_circles_test.nim
- /verify/verify/extra/geometry/aoj_cgl_7_e_cross_points_of_circles_test.nim.html
title: verify/extra/geometry/aoj_cgl_7_e_cross_points_of_circles_test.nim
---
