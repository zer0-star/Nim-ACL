---
data:
  _extendedDependsOn:
  - icon: ':heavy_check_mark:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/string.nim
    title: atcoder/string.nim
  _extendedRequiredBy: []
  _extendedVerifiedWith:
  - icon: ':heavy_check_mark:'
    path: verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
    title: verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
  - icon: ':heavy_check_mark:'
    path: verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
    title: verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':heavy_check_mark:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_SUFFIX_ARRAY_UTILS:\n  const ATCODER_SUFFIX_ARRAY_UTILS*\
    \ = 1\n  import atcoder/string\n  type SuffixArray = object\n    s:string\n  \
    \  SA:seq[int]\n  \n  proc lt_substr*(self: SuffixArray, t:string, si = 0, ti\
    \ = 0):bool =\n    let\n      sn = self.s.len\n      tn = t.len\n    var\n   \
    \   si = si\n      ti = ti\n    while si < sn and ti < tn:\n      if self.s[si]\
    \ < t[ti]: return true\n      if self.s[si] > t[ti]: return false\n      si +=\
    \ 1;ti += 1\n    return si >= sn and ti < tn\n  \n  proc initSuffixArray*(s:string):SuffixArray\
    \ = \n    return SuffixArray(s:s, SA:s.suffixArray)\n  \n  proc `[]`*(self:SuffixArray,\
    \ k:int):int =\n    return self.SA[k]\n  \n  proc size*(self:SuffixArray):int\
    \ =\n    return self.s.len\n  \n  proc lowerBound*(self:SuffixArray, t:string):int\
    \ =\n    var\n      low = -1\n      high = self.size\n    while high - low > 1:\n\
    \      var mid = (low + high) div 2\n      if self.lt_substr(t, self.SA[mid]):\
    \ low = mid\n      else: high = mid\n    return high\n  \n  proc lowerUpperBound*(self:SuffixArray,\
    \ t:string):(int,int) =\n    var\n      idx = self.lowerBound(t)\n      low =\
    \ idx - 1\n      high = self.size\n      t = t\n    t[^1] = chr(ord(t[^1]) + 1)\n\
    \    while high - low > 1:\n      var mid = (low + high) div 2\n      if self.lt_substr(t,\
    \ self.SA[mid]): low = mid\n      else: high = mid\n    t[^1] = chr(ord(t[^1])\
    \ - 1)\n    return (idx, high)\n  \n  proc output*(self:SuffixArray):void =\n\
    \    for i in 0..<self.s.len:\n      echo i, \": \", self.s.substr[self.SA[i]..<self.s.len]\n\
    \  \n"
  dependsOn:
  - atcoder/string.nim
  - atcoder/string.nim
  - atcoder/string.nim
  - atcoder/string.nim
  isVerificationFile: false
  path: atcoder/extra/string/suffix_array_utils.nim
  requiredBy: []
  timestamp: '2022-07-03 22:20:00+09:00'
  verificationStatus: LIBRARY_ALL_AC
  verifiedWith:
  - verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
  - verify/extra/string/aoj_alds_1_14_d_suffix_array_test.nim
documentation_of: atcoder/extra/string/suffix_array_utils.nim
layout: document
redirect_from:
- /library/atcoder/extra/string/suffix_array_utils.nim
- /library/atcoder/extra/string/suffix_array_utils.nim.html
title: atcoder/extra/string/suffix_array_utils.nim
---
