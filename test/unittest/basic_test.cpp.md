---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/basic_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/all>\n#include <type_traits>\n\nusing namespace atcoder;\n\
    using uint = unsigned int;\nusing ll = long long;\nusing ull = unsigned long long;\n\
    \n#ifndef _MSC_VER\n\nint mul100(int a) { return a * 100; }\n\nTEST(BasicTest,\
    \ UBSanitize) {\n    int a = 1 << 30;\n    ASSERT_DEATH(mul100(a), \".*\");\n\
    }\n\n#endif\n\n#ifdef _MSC_VER\n\nint main() {\n    unsigned long long a = 123456789123456LL;\n\
    \    unsigned long long b = 114514123456789LL;\n    unsigned long long c;\n  \
    \  unsigned long long d = _umul128(a, b, &c);\n    ASSERT_EQ(766397903ULL, c);\n\
    \    ASSERT_EQ(15993528026429681536ULL, d);\n}\n\n#endif\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/all>\n#include <type_traits>\n\
    \nusing namespace atcoder;\nusing uint = unsigned int;\nusing ll = long long;\n\
    using ull = unsigned long long;\n\n#ifndef _MSC_VER\n\nint mul100(int a) { return\
    \ a * 100; }\n\nTEST(BasicTest, UBSanitize) {\n    int a = 1 << 30;\n    ASSERT_DEATH(mul100(a),\
    \ \".*\");\n}\n\n#endif\n\n#ifdef _MSC_VER\n\nint main() {\n    unsigned long\
    \ long a = 123456789123456LL;\n    unsigned long long b = 114514123456789LL;\n\
    \    unsigned long long c;\n    unsigned long long d = _umul128(a, b, &c);\n \
    \   ASSERT_EQ(766397903ULL, c);\n    ASSERT_EQ(15993528026429681536ULL, d);\n\
    }\n\n#endif\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/basic_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/basic_test.cpp
layout: document
redirect_from:
- /library/test/unittest/basic_test.cpp
- /library/test/unittest/basic_test.cpp.html
title: test/unittest/basic_test.cpp
---
