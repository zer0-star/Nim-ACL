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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_G
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_G
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.7/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_G\n\
    # verify-helper: ERROR 1e-5\n\ninclude atcoder/header\nimport atcoder/extra/other/floatutils\n\
    import atcoder/extra/geometry/geometry_template\nimport atcoder/extra/geometry/tangent\n\
    \nblock main:\n  let\n    c1, c2 = initCircle(initPoint(nextFloat(), nextFloat()),\
    \ nextFloat())\n    q = tangent(c1, c2)\n  var ans = newSeq[Point[float]]()\n\
    \  for l in q:\n    if distance(l.a, c1.p) =~ c1.r:\n      ans.add l.a\n    else:\n\
    \      ans.add l.b\n  ans.sort() do (x, y:Point[float]) -> int:\n    if x <~ y:\
    \ -1\n    elif x >~ y: 1\n    else: 0\n  for a in ans:\n    echo a.toString()\n"
  dependsOn:
  - atcoder/extra/geometry/tangent.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/geometry/tangent.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/header.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/geometry/aoj_cgl_7_g_common_tangent_test.nim
  requiredBy: []
  timestamp: '2022-08-25 23:07:00+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/geometry/aoj_cgl_7_g_common_tangent_test.nim
layout: document
redirect_from:
- /verify/verify/extra/geometry/aoj_cgl_7_g_common_tangent_test.nim
- /verify/verify/extra/geometry/aoj_cgl_7_g_common_tangent_test.nim.html
title: verify/extra/geometry/aoj_cgl_7_g_common_tangent_test.nim
---
