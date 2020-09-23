---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/bit_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/internal_bit>\n#include <numeric>\n\nusing namespace atcoder;\n\
    using ll = long long;\nusing ull = unsigned long long;\n\nTEST(BitTest, CeilPow2)\
    \ {\n    ASSERT_EQ(0, internal::ceil_pow2(0));\n    ASSERT_EQ(0, internal::ceil_pow2(1));\n\
    \    ASSERT_EQ(1, internal::ceil_pow2(2));\n    ASSERT_EQ(2, internal::ceil_pow2(3));\n\
    \    ASSERT_EQ(2, internal::ceil_pow2(4));\n    ASSERT_EQ(3, internal::ceil_pow2(5));\n\
    \    ASSERT_EQ(3, internal::ceil_pow2(6));\n    ASSERT_EQ(3, internal::ceil_pow2(7));\n\
    \    ASSERT_EQ(3, internal::ceil_pow2(8));\n    ASSERT_EQ(4, internal::ceil_pow2(9));\n\
    \    ASSERT_EQ(30, internal::ceil_pow2(1 << 30));\n    ASSERT_EQ(31, internal::ceil_pow2((1\
    \ << 30) + 1));\n    ASSERT_EQ(31, internal::ceil_pow2(std::numeric_limits<int>::max()));\n\
    }\n\nTEST(BitTest, BSF) {\n    ASSERT_EQ(0, internal::bsf(1));\n    ASSERT_EQ(1,\
    \ internal::bsf(2));\n    ASSERT_EQ(0, internal::bsf(3));\n    ASSERT_EQ(2, internal::bsf(4));\n\
    \    ASSERT_EQ(0, internal::bsf(5));\n    ASSERT_EQ(1, internal::bsf(6));\n  \
    \  ASSERT_EQ(0, internal::bsf(7));\n    ASSERT_EQ(3, internal::bsf(8));\n    ASSERT_EQ(0,\
    \ internal::bsf(9));\n    ASSERT_EQ(30, internal::bsf(1U << 30));\n    ASSERT_EQ(0,\
    \ internal::bsf((1U << 31) - 1));\n    ASSERT_EQ(31, internal::bsf(1U << 31));\n\
    \    ASSERT_EQ(0, internal::bsf(std::numeric_limits<unsigned int>::max()));\n\
    }\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/internal_bit>\n#include <numeric>\n\
    \nusing namespace atcoder;\nusing ll = long long;\nusing ull = unsigned long long;\n\
    \nTEST(BitTest, CeilPow2) {\n    ASSERT_EQ(0, internal::ceil_pow2(0));\n    ASSERT_EQ(0,\
    \ internal::ceil_pow2(1));\n    ASSERT_EQ(1, internal::ceil_pow2(2));\n    ASSERT_EQ(2,\
    \ internal::ceil_pow2(3));\n    ASSERT_EQ(2, internal::ceil_pow2(4));\n    ASSERT_EQ(3,\
    \ internal::ceil_pow2(5));\n    ASSERT_EQ(3, internal::ceil_pow2(6));\n    ASSERT_EQ(3,\
    \ internal::ceil_pow2(7));\n    ASSERT_EQ(3, internal::ceil_pow2(8));\n    ASSERT_EQ(4,\
    \ internal::ceil_pow2(9));\n    ASSERT_EQ(30, internal::ceil_pow2(1 << 30));\n\
    \    ASSERT_EQ(31, internal::ceil_pow2((1 << 30) + 1));\n    ASSERT_EQ(31, internal::ceil_pow2(std::numeric_limits<int>::max()));\n\
    }\n\nTEST(BitTest, BSF) {\n    ASSERT_EQ(0, internal::bsf(1));\n    ASSERT_EQ(1,\
    \ internal::bsf(2));\n    ASSERT_EQ(0, internal::bsf(3));\n    ASSERT_EQ(2, internal::bsf(4));\n\
    \    ASSERT_EQ(0, internal::bsf(5));\n    ASSERT_EQ(1, internal::bsf(6));\n  \
    \  ASSERT_EQ(0, internal::bsf(7));\n    ASSERT_EQ(3, internal::bsf(8));\n    ASSERT_EQ(0,\
    \ internal::bsf(9));\n    ASSERT_EQ(30, internal::bsf(1U << 30));\n    ASSERT_EQ(0,\
    \ internal::bsf((1U << 31) - 1));\n    ASSERT_EQ(31, internal::bsf(1U << 31));\n\
    \    ASSERT_EQ(0, internal::bsf(std::numeric_limits<unsigned int>::max()));\n\
    }\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/bit_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/bit_test.cpp
layout: document
redirect_from:
- /library/test/unittest/bit_test.cpp
- /library/test/unittest/bit_test.cpp.html
title: test/unittest/bit_test.cpp
---
