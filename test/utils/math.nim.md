---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
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
  code: "import atcoder/internal_math\n#include <atcoder/internal_math>\n#include\
    \ <atcoder/math>\n#include <vector>\n\nproc factors*(m:int):seq[int] =\n  var\
    \ m = m\n  result = newSeq[int]()\n  var i = 2\n  while i * i <= m:\n    if m\
    \ mod i == 0:\n      result.add(i)\n      while m mod i == 0:\n        m = m div\
    \ i\n    i.inc\n  if m > 1: result.add(m)\n\nproc is_primitive_root*(m, g:int):bool\
    \ =\n  assert 1 <= g and g < m\n  for x in factors(m - 1):\n    if pow_mod_constexpr(g,\
    \ (m - 1) div x, m) == 1: return false\n  return true\n"
  dependsOn:
  - atcoder/internal_math.nim
  - atcoder/internal_math.nim
  isVerificationFile: false
  path: test/utils/math.nim
  requiredBy: []
  timestamp: '2020-09-25 22:39:15+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/utils/math.nim
layout: document
redirect_from:
- /library/test/utils/math.nim
- /library/test/utils/math.nim.html
title: test/utils/math.nim
---
