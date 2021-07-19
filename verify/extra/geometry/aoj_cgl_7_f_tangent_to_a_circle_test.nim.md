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
    path: atcoder/extra/geometry/tangent.nim
    title: atcoder/extra/geometry/tangent.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/tangent.nim
    title: atcoder/extra/geometry/tangent.nim
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
    ERROR: 1e-5
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_F
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_F
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_F\n\
    \n# verify-helper: ERROR 1e-5\n\ninclude atcoder/header\nimport atcoder/extra/geometry/geometry_template\n\
    import atcoder/extra/geometry/tangent\n\nblock main:\n  let\n    p = initPoint(nextFloat(),\
    \ nextFloat())\n    c = initCircle(initPoint(nextFloat(), nextFloat()), nextFloat())\n\
    \  var q = tangent(c, p)\n  if q[0] >~ q[1]: swap(q[0], q[1])\n  echo q[0].toString()\n\
    \  echo q[1].toString()\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/geometry/tangent.nim
  - atcoder/header.nim
  - atcoder/extra/geometry/tangent.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/element_concepts.nim
  isVerificationFile: true
  path: verify/extra/geometry/aoj_cgl_7_f_tangent_to_a_circle_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/geometry/aoj_cgl_7_f_tangent_to_a_circle_test.nim
layout: document
redirect_from:
- /verify/verify/extra/geometry/aoj_cgl_7_f_tangent_to_a_circle_test.nim
- /verify/verify/extra/geometry/aoj_cgl_7_f_tangent_to_a_circle_test.nim.html
title: verify/extra/geometry/aoj_cgl_7_f_tangent_to_a_circle_test.nim
---