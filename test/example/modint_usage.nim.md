---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/internal_math.nim
    title: atcoder/internal_math.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
  - icon: ':question:'
    path: atcoder/modint.nim
    title: atcoder/modint.nim
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
  code: "import atcoder/modint\n\ntype mint = StaticModInt[11]\n\nvar\n  a = mint(10)\n\
    \  b:mint = mint(3)\n\n# equal\nassert a == 21\nassert a == -1\nassert -1 == a\n\
    \n# negative\nassert -b == 8\n\n# plus\nassert a + b == 2  # (10 + 3) mod 11\n\
    assert 1 + a == 0\n\n# minus\nassert a - b == 7  # (10 - 3) mod 11\nassert b -\
    \ a == 4\n\n# mul\nassert a * b == 8  # (10 * 3) mod 11\n\n# inv\nassert b.inv()\
    \ == 4  # (3 * 4) mod 11 == 1\n\n# div\nassert a / b == 7  # (10 * 4) mod 11\n\
    \n# +=, -=, *=, /=\na += b\nassert a == 2 and b == 3\na -= b\nassert a == 10 and\
    \ b == 3\na *= b\nassert a == 8 and b == 3\na /= b\nassert a == 10 and b == 3\n\
    \n# pow\nassert mint(2).pow(4) == 5  # 16 mod 11\n\n# print value\necho a.val()\
    \  # 10\n\n# get mod\nassert mint.mod == 11 and a.mod == 11\n\n# mint(x) \u3068\
    \u66F8\u304F\u3068mod\u3092\u53D6\u308B\u64CD\u4F5C\u304C\u767A\u751F\u3057\u307E\
    \u3059((x % mod + mod) % mod\u3092modint\u306B\u4EE3\u5165\u3057\u307E\u3059)\n\
    # mint::raw(x) \u306Fx\u3092mod\u3092\u53D6\u3089\u305A\u306B\u4EE3\u5165\u3059\
    \u308B\u306E\u3067\u9AD8\u901F\u3067\u3059(\u3082\u3061\u308D\u3093x\u304C[0,\
    \ mod)\u3067\u3042\u308B\u3053\u3068\u3092\u5229\u7528\u8005\u304C\u4FDD\u8A3C\
    \u3057\u306A\u3044\u3068\u3044\u3051\u307E\u305B\u3093)\nassert mint.raw(3) ==\
    \ 3\n"
  dependsOn:
  - atcoder/generate_definitions.nim
  - atcoder/modint.nim
  - atcoder/internal_math.nim
  - atcoder/generate_definitions.nim
  - atcoder/internal_math.nim
  - atcoder/modint.nim
  isVerificationFile: false
  path: test/example/modint_usage.nim
  requiredBy: []
  timestamp: '2020-09-22 23:58:45+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/example/modint_usage.nim
layout: document
redirect_from:
- /library/test/example/modint_usage.nim
- /library/test/example/modint_usage.nim.html
title: test/example/modint_usage.nim
---
