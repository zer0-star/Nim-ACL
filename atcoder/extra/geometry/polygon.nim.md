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
  _extendedRequiredBy:
  - icon: ':warning:'
    path: atcoder/extra/geometry/visualizer.nim
    title: atcoder/extra/geometry/visualizer.nim
  - icon: ':warning:'
    path: atcoder/extra/geometry/visualizer.nim
    title: atcoder/extra/geometry/visualizer.nim
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_3_a_area_test.nim
    title: verify/extra/geometry/aoj_cgl_3_a_area_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_3_a_area_test.nim
    title: verify/extra/geometry/aoj_cgl_3_a_area_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_3_b_is_convex_test.nim
    title: verify/extra/geometry/aoj_cgl_3_b_is_convex_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_3_b_is_convex_test.nim
    title: verify/extra/geometry/aoj_cgl_3_b_is_convex_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_3_c_polygon_point_containment_test.nim
    title: verify/extra/geometry/aoj_cgl_3_c_polygon_point_containment_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_3_c_polygon_point_containment_test.nim
    title: verify/extra/geometry/aoj_cgl_3_c_polygon_point_containment_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_4_a_convex_hull_test.nim
    title: verify/extra/geometry/aoj_cgl_4_a_convex_hull_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_4_a_convex_hull_test.nim
    title: verify/extra/geometry/aoj_cgl_4_a_convex_hull_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_4_b_diameter_of_a_convex_polygon_test.nim
    title: verify/extra/geometry/aoj_cgl_4_b_diameter_of_a_convex_polygon_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_4_b_diameter_of_a_convex_polygon_test.nim
    title: verify/extra/geometry/aoj_cgl_4_b_diameter_of_a_convex_polygon_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_4_c_convex_cut_test.nim
    title: verify/extra/geometry/aoj_cgl_4_c_convex_cut_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_4_c_convex_cut_test.nim
    title: verify/extra/geometry/aoj_cgl_4_c_convex_cut_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_7_h_intersection_of_circle_and_polygon_test.nim
    title: verify/extra/geometry/aoj_cgl_7_h_intersection_of_circle_and_polygon_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_cgl_7_h_intersection_of_circle_and_polygon_test.nim
    title: verify/extra/geometry/aoj_cgl_7_h_intersection_of_circle_and_polygon_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_3_A
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_3_B
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_3_C
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_A
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_B
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_C
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_H
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_POLYGON_HPP:\n  const ATCODER_POLYGON_HPP* = 1\n\
    \  import std/sugar, std/algorithm, std/math\n  import atcoder/extra/other/floatutils\n\
    \  import atcoder/extra/other/internal_complex\n  import atcoder/extra/geometry/geometry_template\n\
    \n  type Polygon*[Real] = seq[Point[Real]]\n  \n  # convex polygon {{{\n  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_3_B\n\
    \  proc isConvex*[Real](p:Polygon[Real]):bool =\n    let n = p.len\n    for i\
    \ in 0..<n:\n      if ccw(p[(i + n - 1) mod n], p[i], p[(i + 1) mod n]) == CCWState.CLOCKWISE:\
    \ return false\n    return true\n  \n  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_A\n\
    \  proc convexHull*[Real](p:Polygon[Real], strict = false): Polygon[Real] =\n\
    \    let n = p.len\n    var eps_cmp =\n      if strict: (a:Real) => a <=~ 0.Real\n\
    \      else: (a:Real) => a <~ 0.Real\n  #  let eps = if strict: EPS else: -EPS\n\
    \    var\n      k = 0\n      p = p\n    if n <= 2: return p\n    p.sort do (a,\
    \ b:Point[Real])->int:\n      if a <~ b: -1\n      elif b <~ a: 1\n      else:\
    \ 0\n    var\n      ch = newSeq[Point[Real]](2 * n)\n      i = 0\n    while i\
    \ < n:\n      while k >= 2 and cross(ch[k - 1] - ch[k - 2], p[i] - ch[k - 1]).eps_cmp:\
    \ k.dec\n      ch[k] = p[i]\n      k.inc;i.inc\n    i = n - 2\n    let t = k +\
    \ 1\n    while i >= 0:\n      while k >= t and cross(ch[k - 1] - ch[k - 2], p[i]\
    \ - ch[k - 1]).eps_cmp: k.dec\n      ch[k] = p[i]\n      k.inc;i.dec\n    ch.setLen(k\
    \ - 1)\n    return ch\n  \n  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_C\n\
    \  # cut with a straight line l and return a convex polygon on the left\n  proc\
    \ convex_cut*[Real](U: Polygon[Real], l:Line[Real]):Polygon[Real] =\n    result\
    \ = newSeq[Point[Real]]()\n    for i in 0..<U.len:\n      let\n        now = U[i]\n\
    \        nxt = U[(i + 1) mod U.len]\n      if ccw(l.a, l.b, now) != CCWState.CLOCKWISE:\
    \ result.add(now)\n      if ccw(l.a, l.b, now).int * ccw(l.a, l.b, nxt).int <\
    \ 0:\n        result.add(crosspoint(initLine(now, nxt), l))\n  \n  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_4_B\n\
    \  proc convex_diameter*[Real](p: Polygon[Real]):Real =\n    let N = p.len\n \
    \   var\n      it = 0\n      jt = 0\n    for i in 1..<N:\n      if p[i].im >~\
    \ p[it].im: it = i\n      if p[i].im <~ p[jt].im: jt = i\n    var maxdis = norm(p[it]\
    \ - p[jt])\n  \n    var\n      i, maxi = it\n      j, maxj = jt\n    while true:\n\
    \      if cross(p[(i + 1) mod N] - p[i], p[(j + 1) mod N] - p[j]) >=~ 0.Real:\n\
    \        j = (j + 1) mod N\n      else:\n        i = (i + 1) mod N\n      if norm(p[i]\
    \ - p[j]) >~ maxdis:\n        maxdis = norm(p[i] - p[j])\n        maxi = i\n \
    \       maxj = j\n      if not (i != it or j != jt): break\n    return sqrt(maxdis)\n\
    \  \n  # }}}\n  \n  # polygon {{{\n  # contains {{{\n  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_3_C\n\
    \  type State* = enum\n    OUT, ON, IN\n  \n  proc contains*[Real](Q: Polygon[Real],\
    \ p:Point[Real]):State =\n    var inside = false;\n    for i in 0..<Q.len:\n \
    \     var\n        a = Q[i] - p\n        b = Q[(i + 1) mod Q.len] - p\n      if\
    \ a.im >~ b.im: swap(a, b)\n      if a.im <=~ 0.Real and 0.Real <~ b.im and cross(a,\
    \ b) <~ 0.Real: inside = not inside\n      if cross(a, b) =~ 0.Real and dot(a,\
    \ b) <=~ 0.Real: return ON\n    return if inside: IN else: OUT\n  # }}}\n  \n\
    \  # area {{{\n  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_3_A\n\
    \  proc area*[Real](p: Polygon[Real]):Real =\n    var A = 0.Real\n    for i in\
    \ 0..<p.len:\n      A += cross(p[i], p[(i + 1) mod p.len])\n    return A / Real(2)\n\
    \  \n  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=CGL_7_H\n  proc\
    \ area*[Real](p:Polygon[Real], c:Circle[Real]):Real =\n    if p.len < 3: return\
    \ Real(0)\n    proc cross_area(c: Circle[Real], a,b: Point[Real]):Real =\n   \
    \   let\n        va = c.p - a\n        vb = c.p - b\n        f = cross(va, vb)\n\
    \      result = Real(0)\n      if f =~ Real(0): return\n      if max(abs(va),\
    \ abs(vb)) <=~ c.r: return f\n      if c.r <=~ distance(initSegment(a, b), c.p):\n\
    \        return c.r * c.r * phase(vb * conjugate(va))\n      let u = crosspoint(c,\
    \ initSegment(a, b))\n      let tot = @[a, u[0], u[1], b]\n      for i in 0..<tot.len:\n\
    \        result += cross_area(c, tot[i], tot[i + 1])\n    var A = 0.Real\n   \
    \ for i in 0..<p.len:\n      A += cross_area(c, p[i], p[(i + 1) mod p.len]) /\
    \ Real(2)\n    return A\n  # }}}\n  # }}}\n"
  dependsOn:
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  isVerificationFile: false
  path: atcoder/extra/geometry/polygon.nim
  requiredBy:
  - atcoder/extra/geometry/visualizer.nim
  - atcoder/extra/geometry/visualizer.nim
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/geometry/aoj_cgl_7_h_intersection_of_circle_and_polygon_test.nim
  - verify/extra/geometry/aoj_cgl_7_h_intersection_of_circle_and_polygon_test.nim
  - verify/extra/geometry/aoj_cgl_3_c_polygon_point_containment_test.nim
  - verify/extra/geometry/aoj_cgl_3_c_polygon_point_containment_test.nim
  - verify/extra/geometry/aoj_cgl_4_b_diameter_of_a_convex_polygon_test.nim
  - verify/extra/geometry/aoj_cgl_4_b_diameter_of_a_convex_polygon_test.nim
  - verify/extra/geometry/aoj_cgl_4_c_convex_cut_test.nim
  - verify/extra/geometry/aoj_cgl_4_c_convex_cut_test.nim
  - verify/extra/geometry/aoj_cgl_3_a_area_test.nim
  - verify/extra/geometry/aoj_cgl_3_a_area_test.nim
  - verify/extra/geometry/aoj_cgl_3_b_is_convex_test.nim
  - verify/extra/geometry/aoj_cgl_3_b_is_convex_test.nim
  - verify/extra/geometry/aoj_cgl_4_a_convex_hull_test.nim
  - verify/extra/geometry/aoj_cgl_4_a_convex_hull_test.nim
documentation_of: atcoder/extra/geometry/polygon.nim
layout: document
redirect_from:
- /library/atcoder/extra/geometry/polygon.nim
- /library/atcoder/extra/geometry/polygon.nim.html
title: atcoder/extra/geometry/polygon.nim
---
