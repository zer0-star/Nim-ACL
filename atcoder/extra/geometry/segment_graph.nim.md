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
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
    title: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
    title: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1033
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SEGMENT_GRAPH_HPP:\n  const ATCODER_SEGMENT_GRAPH_HPP*\
    \ = 1\n  import atcoder/extra/other/floatutils\n  import atcoder/extra/geometry/geometry_template\n\
    \  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1033\n  # deduplication\
    \ of line segments\n  proc merge_segments*[Real](segs: var seq[Segment[Real]])\
    \ =\n    proc merge_if_able(s1: var Segment[Real], s2: Segment[Real]):bool =\n\
    \      if abs(cross(s1.b - s1.a, s2.b - s2.a)) >~ 0.Real: return false\n     \
    \ if ccw(s1.a, s2.a, s1.b) == 1 or ccw(s1.a, s2.a, s1.b) == -1: return false\n\
    \      if ccw(s1.a, s1.b, s2.a) == -2 or ccw(s2.a, s2.b, s1.a) == -2: return false\n\
    \      s1 = initSegment(min(s1.a, s2.a), max(s1.b, s2.b))\n      return true\n\
    \  \n    for i in 0..<segs.len:\n      if segs[i].b <~ segs[i].a: swap(segs[i].a,\
    \ segs[i].b)\n    for i in 0..<segs.len:\n      var j = i + 1\n      while j <\
    \ segs.len:\n        if merge_if_able(segs[i], segs[j]):\n          segs[j] =\
    \ segs.pop()\n          j.dec\n        j.inc\n  # http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1033\n\
    \  # construct a graph with the vertex of the intersection of any two line segments\n\
    \  proc segment_arrangement*[Real](segs: seq[Segment[Real]]):(seq[Point[Real]],\
    \ seq[seq[int]]) =\n    var ps = newSeq[Point[Real]]()\n    let N = segs.len\n\
    \    for i in 0..<N:\n      ps.add(segs[i].a)\n      ps.add(segs[i].b)\n     \
    \ for j in i+1..<N:\n        let \n          p1 = segs[i].b - segs[i].a\n    \
    \      p2 = segs[j].b - segs[j].a\n        if cross(p1, p2) == 0: continue\n \
    \       if intersect(segs[i], segs[j]):\n          ps.add(crosspoint(segs[i],\
    \ segs[j]))\n  # ps\u3092deduplicate\u3057\u305F\u3044\u3002\u3002\u3002\n#  \
    \  ps.sort(cmp[Point])\n    ps.sort() do (a, b:Point[Real])->int:\n      if a.re\
    \ <~ b.re: return -1\n      elif a.re >~ b.re: return 1\n      elif a.im <~ b.im:\
    \ return -1\n      elif a.im >~ b.im: return 1\n      else: return 0\n    block:\n\
    \      var h, i = 0\n      while i < ps.len:\n        var j = i\n        while\
    \ j < ps.len and ps[i] == ps[j]: j.inc\n        swap(ps[h], ps[i])\n        i\
    \ = j\n        h.inc\n      ps.setLen(h)\n  \n    let M = ps.len\n    var g =\
    \ newSeq[seq[int]](M)\n    for i in 0..<N:\n      var vec = newSeq[int]()\n  \
    \    for j in 0..<M:\n        if intersect(segs[i], ps[j]):\n          vec.add(j)\n\
    \      for j in 1..<vec.len:\n        g[vec[j - 1]].add(vec[j])\n        g[vec[j]].add(vec[j\
    \ - 1])\n    return (ps, g)\n"
  dependsOn:
  - atcoder/element_concepts.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  isVerificationFile: false
  path: atcoder/extra/geometry/segment_graph.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  - verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
documentation_of: atcoder/extra/geometry/segment_graph.nim
layout: document
redirect_from:
- /library/atcoder/extra/geometry/segment_graph.nim
- /library/atcoder/extra/geometry/segment_graph.nim.html
title: atcoder/extra/geometry/segment_graph.nim
---
