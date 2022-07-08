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
    ERROR: 1e-8
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_1_A
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_1_A
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_1_A\n\
    \n# verify-helper: ERROR 1e-8\n\ninclude atcoder/header\nimport atcoder/extra/geometry/geometry_template\n\
    \nblock main:\n  let\n    xp1, yp1, xp2, yp2 = nextFloat()\n    p1 = initPoint(xp1,\
    \ yp1)\n    p2 = initPoint(xp2, yp2)\n  let q = nextInt()\n  for i in 0..<q:\n\
    \    let\n      xp, yp = nextFloat()\n      p = initPoint(xp, yp)\n    echo p.projection(initLine(p1,\
    \ p2)).toString()\n"
  dependsOn:
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/header.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/element_concepts.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/geometry/aoj_cgl_1_a_projection_test.nim
  requiredBy: []
  timestamp: '2022-02-05 00:42:13+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/geometry/aoj_cgl_1_a_projection_test.nim
layout: document
redirect_from:
- /verify/verify/extra/geometry/aoj_cgl_1_a_projection_test.nim
- /verify/verify/extra/geometry/aoj_cgl_1_a_projection_test.nim.html
title: verify/extra/geometry/aoj_cgl_1_a_projection_test.nim
---
