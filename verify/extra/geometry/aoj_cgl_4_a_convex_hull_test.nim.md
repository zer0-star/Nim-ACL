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
    path: atcoder/extra/geometry/polygon.nim
    title: atcoder/extra/geometry/polygon.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/polygon.nim
    title: atcoder/extra/geometry/polygon.nim
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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_A
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_A
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_A\n\
    \ninclude atcoder/header\nimport atcoder/extra/geometry/geometry_template\nimport\
    \ atcoder/extra/geometry/polygon\n\nblock main:\n  let\n    n = nextInt()\n  \
    \  p = newSeqWith(n, initPoint(nextFloat(), nextFloat()))\n    ch = p.convexHull()\n\
    \  let EPS = 1e-8\n  var min_p = initPoint(float.inf, float.inf)\n  var min_i:int\n\
    \  for i,p in ch:\n    if min_p.im - EPS > p.im:\n      min_p = p\n      min_i\
    \ = i\n    elif min_p.im + EPS > p.im:\n      if min_p.re - EPS > p.re:\n    \
    \    min_p = p\n        min_i = i\n  var i = min_i\n  echo ch.len\n  while true:\n\
    \    echo ch[i].re.int, \" \", ch[i].im.int\n    i.inc\n    if i == ch.len: i\
    \ = 0\n    if i == min_i: break\n"
  dependsOn:
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/geometry/polygon.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/geometry/polygon.nim
  - atcoder/element_concepts.nim
  - atcoder/header.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/header.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/static_var.nim
  isVerificationFile: true
  path: verify/extra/geometry/aoj_cgl_4_a_convex_hull_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/geometry/aoj_cgl_4_a_convex_hull_test.nim
layout: document
redirect_from:
- /verify/verify/extra/geometry/aoj_cgl_4_a_convex_hull_test.nim
- /verify/verify/extra/geometry/aoj_cgl_4_a_convex_hull_test.nim.html
title: verify/extra/geometry/aoj_cgl_4_a_convex_hull_test.nim
---
