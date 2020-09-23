---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/cplusplus.py\"\
    , line 191, in bundle\n    bundler.update(path)\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/cplusplus_bundle.py\"\
    , line 399, in update\n    self.update(self._resolve(pathlib.Path(included), included_from=path))\n\
    \  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/cplusplus_bundle.py\"\
    , line 258, in _resolve\n    raise BundleErrorAt(path, -1, \"no such header\"\
    )\nonlinejudge_verify.languages.cplusplus_bundle.BundleErrorAt: ../utils/math.hpp:\
    \ line -1: no such header\n"
  code: "#include <gtest/gtest.h>\n\n#include \"../utils/math.hpp\"\n#include <numeric>\n\
    \nTEST(UtilsMathTest, FactorsTest) {\n    for (int m = 1; m <= 50000; m++) {\n\
    \        auto f = factors(m);\n        int m2 = m;\n        for (auto x : f) {\n\
    \            ASSERT_EQ(0, m % x);\n            while (m2 % x == 0) m2 /= x;\n\
    \        }\n        ASSERT_EQ(1, m2);\n    }\n}\n\nbool is_primitive_root_naive(int\
    \ m, int g) {\n    assert(1 <= g && g < m);\n    auto prs = factors(m - 1);\n\
    \    int x = 1;\n    for (int i = 1; i <= m - 2; i++) {\n        x = (int)((long\
    \ long)(x)*g % m);\n        // x == n^i\n        if (x == 1) return false;\n \
    \   }\n    x = (int)((long long)(x)*g % m);\n    assert(x == 1);\n    return true;\n\
    }\n\nTEST(UtilsMathTest, IsPrimitiveRootTest) {\n    for (int m = 2; m <= 500;\
    \ m++) {\n        if (!atcoder::internal::is_prime_constexpr(m)) continue;\n \
    \       for (int g = 1; g < m; g++) {\n            ASSERT_EQ(is_primitive_root_naive(m,\
    \ g), is_primitive_root(m, g));\n        }\n    }\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/utils/math_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/utils/math_test.cpp
layout: document
redirect_from:
- /library/test/unittest/utils/math_test.cpp
- /library/test/unittest/utils/math_test.cpp.html
title: test/unittest/utils/math_test.cpp
---
