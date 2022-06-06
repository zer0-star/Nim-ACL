---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_node_utils.nim
    title: atcoder/extra/structure/binary_tree_node_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_utils.nim
    title: atcoder/extra/structure/binary_tree_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/binary_tree_utils.nim
    title: atcoder/extra/structure/binary_tree_utils.nim
  - icon: ':x:'
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':x:'
    path: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
    title: atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - icon: ':x:'
    path: atcoder/extra/structure/red_black_tree.nim
    title: atcoder/extra/structure/red_black_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/red_black_tree.nim
    title: atcoder/extra/structure/red_black_tree.nim
  - icon: ':x:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
  - icon: ':x:'
    path: atcoder/extra/structure/set_map.nim
    title: atcoder/extra/structure/set_map.nim
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
    PROBLEM: https://judge.yosupo.jp/problem/predecessor_problem
    links:
    - https://judge.yosupo.jp/problem/predecessor_problem
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# verify-helper: PROBLEM https://judge.yosupo.jp/problem/predecessor_problem\n\
    \ninclude atcoder/header\nimport atcoder/extra/structure/set_map\n\nvar st = initSortedSet[int]()\n\
    \nlet N, Q = nextInt()\nlet T = nextString()\nfor i in 0..<N:\n  if T[i] == '1':\
    \ st.insert(i)\nfor _ in 0..<Q:\n  let c, k = nextInt()\n  if c == 0:\n    st.insert(k)\n\
    \  elif c == 1:\n    st.erase(k)\n  elif c == 2:\n    if k in st:\n      echo\
    \ 1\n    else:\n      echo 0\n  elif c == 3:\n    var it = st.lower_bound(k)\n\
    \    if it == st.end():\n      echo -1\n    else:\n      echo *it\n  elif c ==\
    \ 4:\n    var it = st.upper_bound(k)\n    if it == st.begin():\n      echo -1\n\
    \    else:\n      it.dec\n      echo *it\n"
  dependsOn:
  - atcoder/extra/structure/set_map.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  - atcoder/rangeutils.nim
  - atcoder/extra/structure/set_map.nim
  - atcoder/header.nim
  - atcoder/extra/structure/splay_tree.nim
  - atcoder/extra/structure/randomized_binary_search_tree_with_parent.nim
  - atcoder/extra/structure/binary_tree_utils.nim
  - atcoder/header.nim
  - atcoder/extra/structure/red_black_tree.nim
  - atcoder/extra/structure/binary_tree_node_utils.nim
  isVerificationFile: true
  path: verify/extra/structure/yosupo_predecessor_problem_test.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: TEST_WRONG_ANSWER
  verifiedWith: []
documentation_of: verify/extra/structure/yosupo_predecessor_problem_test.nim
layout: document
redirect_from:
- /verify/verify/extra/structure/yosupo_predecessor_problem_test.nim
- /verify/verify/extra/structure/yosupo_predecessor_problem_test.nim.html
title: verify/extra/structure/yosupo_predecessor_problem_test.nim
---
