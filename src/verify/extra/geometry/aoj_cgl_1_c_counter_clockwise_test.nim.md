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
    path: atcoder/extra/geometry/geometry_template.nim
    title: atcoder/extra/geometry/geometry_template.nim
  - icon: ':question:'
    path: atcoder/extra/geometry/geometry_template.nim
    title: atcoder/extra/geometry/geometry_template.nim
  - icon: ':question:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':question:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':question:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':question:'
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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_1_C
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_1_C
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_1_C\n\
    \ninclude atcoder/header\nimport atcoder/extra/geometry/geometry_template\n\n\
    block main:\n  let\n    xp0, yp0, xp1, yp1 = nextFloat()\n    p0 = initPoint(xp0,\
    \ yp0)\n    p1 = initPoint(xp1, yp1)\n  let q = nextInt()\n  for i in 0..<q:\n\
    \    let\n      xp2, yp2 = nextFloat()\n      p2 = initPoint(xp2, yp2)\n     \
    \ c = ccw(p0, p1, p2)\n    if c == CCWState.COUNTER_CLOCKWISE:    echo \"COUNTER_CLOCKWISE\"\
    \n    elif c == CCWState.CLOCKWISE: echo \"CLOCKWISE\"\n    elif c == CCWState.ONLINE_BACK:\
    \ echo \"ONLINE_BACK\"\n    elif c == CCWState.ONLINE_FRONT: echo \"ONLINE_FRONT\"\
    \n    else: echo \"ON_SEGMENT\"\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/header.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/element_concepts.nim
  isVerificationFile: true
  path: verify/extra/geometry/aoj_cgl_1_c_counter_clockwise_test.nim
  requiredBy: []
  timestamp: '2022-08-08 21:23:55+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/geometry/aoj_cgl_1_c_counter_clockwise_test.nim
layout: document
redirect_from:
- /verify/verify/extra/geometry/aoj_cgl_1_c_counter_clockwise_test.nim
- /verify/verify/extra/geometry/aoj_cgl_1_c_counter_clockwise_test.nim.html
title: verify/extra/geometry/aoj_cgl_1_c_counter_clockwise_test.nim
---
