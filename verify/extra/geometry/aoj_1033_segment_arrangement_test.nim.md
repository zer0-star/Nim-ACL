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
    path: atcoder/extra/geometry/segment_graph.nim
    title: atcoder/extra/geometry/segment_graph.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/geometry/segment_graph.nim
    title: atcoder/extra/geometry/segment_graph.nim
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra.nim
    title: atcoder/extra/graph/dijkstra.nim
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra.nim
    title: atcoder/extra/graph/dijkstra.nim
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra_result.nim
    title: atcoder/extra/graph/dijkstra_result.nim
  - icon: ':question:'
    path: atcoder/extra/graph/dijkstra_result.nim
    title: atcoder/extra/graph/dijkstra_result.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':question:'
    path: atcoder/extra/graph/graph_template.nim
    title: atcoder/extra/graph/graph_template.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
  - icon: ':question:'
    path: atcoder/extra/other/inf.nim
    title: atcoder/extra/other/inf.nim
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
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1033
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1033
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.0/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1033\n\
    # verify-helper: ERROR 1e-5\n\ninclude atcoder/header\nimport atcoder/extra/other/internal_complex\n\
    import atcoder/extra/geometry/geometry_template\nimport atcoder/extra/geometry/segment_graph\n\
    import atcoder/extra/graph/graph_template\nimport atcoder/extra/graph/dijkstra\n\
    \nblock main:\n  while true:\n    let n = nextInt()\n    if n == 0: break\n  \
    \  var segs = newSeq[Segment[float]]()\n    for i in 0..<n:\n      let p, q =\
    \ initPoint(nextFloat(), nextFloat())\n      segs.add(initSegment(p, q))\n   \
    \ let start, goal = initPoint(nextFloat(), nextFloat())\n    var (ps, g) = segment_arrangement(segs)\n\
    \    for v in g.mitems:\n      var hs = v.toHashSet()\n      v.setlen(0)\n   \
    \   for h in hs: v.add(h)\n      v.sort()\n    var si, gi = -1\n    for i,p in\
    \ ps:\n      if start == ps[i]: si = i\n      if goal == ps[i]: gi = i\n    assert(si\
    \ >= 0 and gi >= 0)\n    proc id(a:(int, int)):int = a[0] * ps.len + a[1]\n  \
    \  var G = initGraph(ps.len^2 + 1, id, float)\n    let src = (ps.len, 0)\n   \
    \ for u in 0..<ps.len:\n      if u == si: continue\n      G.addEdge(src, (si,\
    \ u), 0.0)\n    for u in 0..<ps.len:\n      for v in g[u]:\n        for w in g[v]:\n\
    \          let d = phase((ps[w] - ps[v])/(ps[v] - ps[u]))\n          G.addEdge((u,\
    \ v), (v, w), abs(d))\n    var dist = G.dijkstra(src)\n    var ans = float.inf\n\
    \    for u in 0..<ps.len:\n      for v in g[u]:\n        if v != gi: continue\n\
    \        ans.min= dist[(u, v)]\n    if ans.classify == fcInf:\n      echo -1\n\
    \    else:\n      echo ans.radianToDegree\n"
  dependsOn:
  - atcoder/header.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/header.nim
  - atcoder/extra/geometry/segment_graph.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/inf.nim
  - atcoder/extra/other/internal_complex.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/graph/dijkstra_result.nim
  - atcoder/extra/graph/graph_template.nim
  - atcoder/extra/geometry/segment_graph.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/graph/dijkstra.nim
  - atcoder/extra/geometry/geometry_template.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/graph/dijkstra_result.nim
  isVerificationFile: true
  path: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
  requiredBy: []
  timestamp: '2021-11-18 02:47:29+09:00'
  verificationStatus: TEST_ACCEPTED
  verifiedWith: []
documentation_of: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
layout: document
redirect_from:
- /verify/verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
- /verify/verify/extra/geometry/aoj_1033_segment_arrangement_test.nim.html
title: verify/extra/geometry/aoj_1033_segment_arrangement_test.nim
---
