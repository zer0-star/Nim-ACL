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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.4/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_KNUTH_MORRIS_PRATT_HPP:\n  const ATCODER_KNUTH_MORRIS_PRATT_HPP*\
    \ = 1\n  proc KnuthMorrisPratt*(t,p:string):seq[int] =\n    proc buildFail(p:string):seq[int]\
    \ =\n      let m = p.len\n      var fail = newSeq[int](m+1)\n      var j = -1\n\
    \      fail[0] = -1;\n      for i in 1..m:\n        while j >= 0 and p[j] != p[i\
    \ - 1]: j = fail[j]\n        j += 1\n        fail[i] = j\n      return fail\n\
    \    let\n      fail = buildFail(p)\n      n = t.len\n      m = p.len\n    result\
    \ = newSeq[int]()\n    var k = 0\n    for i in 0..<n:\n      while k >= 0 and\
    \ p[k] != t[i]: k = fail[k]\n      k += 1\n      if k >= m:\n        result.add(i\
    \ - m + 1) # match at t[i-m+1 .. i]\n        k = fail[k]\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/string/knuth_morris_pratt.nim
  requiredBy: []
  timestamp: '2022-06-06 17:51:24+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/string/knuth_morris_pratt.nim
layout: document
redirect_from:
- /library/atcoder/extra/string/knuth_morris_pratt.nim
- /library/atcoder/extra/string/knuth_morris_pratt.nim.html
title: atcoder/extra/string/knuth_morris_pratt.nim
---
