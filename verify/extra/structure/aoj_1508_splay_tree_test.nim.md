---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/splay_tree.nim
    title: atcoder/extra/structure/splay_tree.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':question:'
    path: atcoder/header.nim
    title: atcoder/header.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  - icon: ':x:'
    path: atcoder/rangeutils.nim
    title: atcoder/rangeutils.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    PROBLEM: http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1508
    links:
    - http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1508
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM http://judge.u-aizu.ac.jp/onlinejudge/description.jsp?id=1508\n\
    \ninclude atcoder/header\n\nimport atcoder/extra/structure/splay_tree\nimport\
    \ sugar\n\nblock:\n  let n, q = nextInt()\n\n  var st = initSplayTree((a:int,\
    \ b:int)=>min(a, b), 0)\n  type Node = st.Node\n\n  st.build(newSeqWith(n, nextInt()))\n\
    \n  for i in 0..<q:\n    let x, y, z = nextInt()\n#    echo st.count(root)\n \
    \   case x:\n      of 0:\n        var (p, q, r) = st.split3(st.root, y, z + 1)\n\
    \        let d = z + 1 - y\n        var (q0, q1) = st.split(q, d - 1)\n#     \
    \   doAssert st.count(q) == d\n        st.root = st.merge(p, q1, q0, r)\n    \
    \  of 1:\n        echo st.prod(y..z)\n      else:\n        # type 1\n#       \
    \ st.set_element(root, y, z)\n        st[y] = z\n        # type 2\n#        var\
    \ (p, q, r) = st.split3(root, y, y + 1)\n#        root = st.merge(p, st.initNode(z),\
    \ r)\n        # type 3\n#        st.erase(st.get_node(y))\n#        st.insert(y,\
    \ z)\n"
  dependsOn:
  - atcoder/rangeutils.nim
  - atcoder/header.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/header.nim
  isVerificationFile: true
  path: verify/extra/structure/aoj_1508_splay_tree_test.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/aoj_1508_splay_tree_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/aoj_1508_splay_tree_test.nim
- /verify/verify/extra/structure/aoj_1508_splay_tree_test.nim.html
title: verify/extra/structure/aoj_1508_splay_tree_test.nim
---
