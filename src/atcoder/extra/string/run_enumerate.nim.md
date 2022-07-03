---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  - icon: ':x:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  - icon: ':x:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  - icon: ':x:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':x:'
    path: verify/extra/string/yosupo_run_enumerate_test.nim
    title: verify/extra/string/yosupo_run_enumerate_test.nim
  - icon: ':x:'
    path: verify/extra/string/yosupo_run_enumerate_test.nim
    title: verify/extra/string/yosupo_run_enumerate_test.nim
  _isVerificationFailed: true
  _pathExtension: nim
  _verificationStatusIcon: ':x:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.5/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_RUN_ENUMERATE_HPP:\n  const ATCODER_RUN_ENUMERATE_HPP*\
    \ = 1\n  import std/tables, std/algorithm\n  import atcoder/string\n  proc reversed*(s:string):string\
    \ =\n    for i in countdown(s.len - 1, 0):\n      result.add s[i]\n  \n  proc\
    \ RunEnumerate*(s:string):seq[(int,int,int)] =\n    var ret = newSeq[(int,int,int)]()\n\
    \    proc aux(first, second:string):auto =\n      result = newSeq[(int,int,int)]()\n\
    \  \n      let\n        a = z_algorithm(first.reversed)\n        b = z_algorithm(second\
    \ & '\\0' & first & second)\n  \n      for i in 1..<first.len:\n        let\n\
    \          l1 = if i == first.len: 0 else: a[i]\n          l2 = b[second.len +\
    \ first.len - i + 1]\n  \n        if l1 + i == first.len or l2 == second.len or\
    \ i > l1 + l2: continue\n  \n        let\n          l = first.len - i - l1\n \
    \         r = first.len + l2\n          t = i\n        result.add((t, l, r))\n\
    \  \n    proc run(s:string, left = 0) =\n      if s.len == 1: return\n  \n   \
    \   let\n        N = s.len\n        m = N div 2\n        first = s[0..<m]\n  \
    \      second = s[m..<s.len]\n    \n      block:\n        var res = aux(first,\
    \ second)\n  \n        for (t,l,r) in res:\n          ret.add((t, left + l, left\
    \ + r))\n      block:\n        var res = aux(second.reversed, first.reversed)\n\
    \  \n        for (t, l, r) in res:\n          ret.add((t, left + N - r, left +\
    \ N - l))\n  \n      run(first, left)\n      run(second, left + first.len)\n \
    \ \n    proc sub(s:string) =\n      let N = s.len\n      block:\n        let a\
    \ = z_algorithm(s)\n        for i in 1..<N:\n          if i <= a[i]:\n       \
    \     ret.add((i, 0, i + a[i]))\n      block:\n        let a = z_algorithm(s.reversed)\n\
    \        for i in 1..<N:\n          if i <= a[i]:\n            ret.add((i, N -\
    \ i - a[i], N))\n  \n    run(s)\n    sub(s)\n  \n    var m = initTable[(int,int),\
    \ int]()\n  \n    for (t,l,r) in ret:\n      let p = (l, r)\n      if p in m:\n\
    \        m[p] = min(m[p], t)\n      else:\n        m[p] = t\n  \n    ret.setLen(0)\n\
    \  \n    for p, t in m.pairs:\n      ret.add((t, p[0], p[1]))\n    ret.sort\n\
    \    return ret\n"
  dependsOn:
  - atcoder/string.nim
  - atcoder/string.nim
  - atcoder/string.nim
  - atcoder/string.nim
  isVerificationFile: false
  path: atcoder/extra/string/run_enumerate.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_ALL_WA
  verifiedWith:
  - verify/extra/string/yosupo_run_enumerate_test.nim
  - verify/extra/string/yosupo_run_enumerate_test.nim
documentation_of: atcoder/extra/string/run_enumerate.nim
layout: document
redirect_from:
- /library/atcoder/extra/string/run_enumerate.nim
- /library/atcoder/extra/string/run_enumerate.nim.html
title: atcoder/extra/string/run_enumerate.nim
---
