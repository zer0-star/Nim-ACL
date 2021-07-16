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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_CHROMATIC_NUMBER_HPP:\n  const ATCODER_CHROMATIC_NUMBER_HPP*\
    \ = 1\n  import sequtils, bitops, math\n  \n  proc chromatic_number*(g:seq[seq[bool]]):int\
    \ =\n    let N = g.len\n    var es = newSeq[int](N)\n    for i in 0..<N:\n   \
    \   for j in 0..<N:\n        if g[i][j]: es[i] = es[i] or (1 shl j)\n    result\
    \ = N\n    for d in [7, 11, 21]:\n      let MOD = 10^9 + d\n      var\n      \
    \  ind = newSeq[int](2^N)\n        aux = newSeqWith(2^N, 1)\n      ind[0] = 1\n\
    \      for S in 1 ..< 2^N:\n        let u = countTrailingZeroBits(S)\n       \
    \ ind[S] = ind[S xor (1 shl u)] + ind[(S xor (1 shr u)) and not es[u]]\n     \
    \ for i in 1 ..< result:\n        var all = 0\n        for j in 0 ..< 2^N:\n \
    \         let S = j xor (j shr 1)\n          aux[S] = (aux[S] * ind[S]) mod MOD\n\
    \          all += (if (j and 1) != 0: aux[S] else: MOD - aux[S])\n        if all\
    \ mod MOD != 0: result = i\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/graph/chromatic_number.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/graph/chromatic_number.nim
layout: document
redirect_from:
- /library/atcoder/extra/graph/chromatic_number.nim
- /library/atcoder/extra/graph/chromatic_number.nim.html
title: atcoder/extra/graph/chromatic_number.nim
---
