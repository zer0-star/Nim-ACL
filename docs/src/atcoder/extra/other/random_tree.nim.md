---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_RANDOM_TREE_HPP:\n  const ATCODER_RANDOM_TREE_HPP*\
    \ = 1\n  import heapqueue, random\n  proc pruefer_decode*(code:seq[int]):seq[(int,\
    \ int)] =\n    let n = code.len + 2\n    var degree = newSeq[int](n)\n    for\
    \ i in 0 ..< n: degree[i] = 1\n    for i in code:\n      degree[i].inc\n    var\
    \ leaves = initHeapQueue[int]()\n    for i in 0 ..< n:\n      if degree[i] ==\
    \ 1:\n        leaves.push(i)\n    for v in code:\n      let leaf = leaves.pop()\n\
    \n      result.add((leaf, v))\n      degree[v].dec\n      if degree[v] == 1:\n\
    \        leaves.push(v)\n\n    result.add((leaves.pop(), n - 1))\n  proc random_tree*(n:int):seq[(int,\
    \ int)] =\n    doAssert n >= 2\n    var code = newSeq[int](n - 2)\n    for i in\
    \ 0 ..< code.len:\n      code[i] = random.rand(0 ..< n)\n    return pruefer_decode(code)\n\
    \  iterator enumerate_tree*(n:int):seq[(int, int)] =\n    var\n      code = newSeq[int](n\
    \ - 2)\n      next = true\n    while next:\n      yield pruefer_decode(code)\n\
    \      for i in 0 ..< code.len:\n        if code[i] < n - 1:\n          code[i].inc\n\
    \          break\n        else:\n          code[i] = 0\n          if i == code.len\
    \ - 1: next = false\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/other/random_tree.nim
  requiredBy: []
  timestamp: '2022-07-30 23:50:20+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/random_tree.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/random_tree.nim
- /library/atcoder/extra/other/random_tree.nim.html
title: atcoder/extra/other/random_tree.nim
---
