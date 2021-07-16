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
  code: "import std/random\n\nvar rnd = initRand(2020)\n\n# random choise from [a,\
    \ b]\nproc randint*[T](a, b:T):T =\n  rnd.rand(a..b)\n\nproc randbool*():bool\
    \ = randint(0, 1) == 0\n\n# random choice 2 disjoint elements from [lower, upper]\n\
    proc randpair*[T](lower, upper:T):(T, T) =\n  assert upper - lower >= 1.T\n  var\
    \ a, b:T\n  while true:\n    a = randint(lower, upper)\n    b = randint(lower,\
    \ upper)\n    if a != b: break\n  if a > b: swap(a, b)\n  return (a, b)\n"
  dependsOn: []
  isVerificationFile: false
  path: test/utils/random.nim
  requiredBy: []
  timestamp: '2020-09-25 22:39:15+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/utils/random.nim
layout: document
redirect_from:
- /library/test/utils/random.nim
- /library/test/utils/random.nim.html
title: test/utils/random.nim
---
