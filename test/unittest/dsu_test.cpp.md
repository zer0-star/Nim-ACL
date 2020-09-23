---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/dsu_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/dsu>\n#include <numeric>\n\nusing namespace atcoder;\nusing\
    \ ll = long long;\nusing ull = unsigned long long;\n\nTEST(DSUTest, Zero) {\n\
    \    dsu uf(0);\n    ASSERT_EQ(std::vector<std::vector<int>>(), uf.groups());\n\
    }\n\nTEST(DSUTest, Empty) {\n    dsu uf;\n    ASSERT_EQ(std::vector<std::vector<int>>(),\
    \ uf.groups());\n}\n\nTEST(DSUTest, Assign) {\n    dsu uf;\n    uf = dsu(10);\n\
    }\n\nTEST(DSUTest, Simple) {\n    dsu uf(2);\n    ASSERT_FALSE(uf.same(0, 1));\n\
    \    int x = uf.merge(0, 1);\n    ASSERT_EQ(x, uf.leader(0));\n    ASSERT_EQ(x,\
    \ uf.leader(1));\n    ASSERT_TRUE(uf.same(0, 1));\n    ASSERT_EQ(2, uf.size(0));\n\
    }\n\nTEST(DSUTest, Line) {\n    int n = 500000;\n    dsu uf(n);\n    for (int\
    \ i = 0; i < n - 1; i++) {\n        uf.merge(i, i + 1);\n    }\n    ASSERT_EQ(n,\
    \ uf.size(0));\n    ASSERT_EQ(1, uf.groups().size());\n}\n\nTEST(DSUTest, LineReverse)\
    \ {\n    int n = 500000;\n    dsu uf(n);\n    for (int i = n - 2; i >= 0; i--)\
    \ {\n        uf.merge(i, i + 1);\n    }\n    ASSERT_EQ(n, uf.size(0));\n    ASSERT_EQ(1,\
    \ uf.groups().size());\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/dsu>\n#include <numeric>\n\n\
    using namespace atcoder;\nusing ll = long long;\nusing ull = unsigned long long;\n\
    \nTEST(DSUTest, Zero) {\n    dsu uf(0);\n    ASSERT_EQ(std::vector<std::vector<int>>(),\
    \ uf.groups());\n}\n\nTEST(DSUTest, Empty) {\n    dsu uf;\n    ASSERT_EQ(std::vector<std::vector<int>>(),\
    \ uf.groups());\n}\n\nTEST(DSUTest, Assign) {\n    dsu uf;\n    uf = dsu(10);\n\
    }\n\nTEST(DSUTest, Simple) {\n    dsu uf(2);\n    ASSERT_FALSE(uf.same(0, 1));\n\
    \    int x = uf.merge(0, 1);\n    ASSERT_EQ(x, uf.leader(0));\n    ASSERT_EQ(x,\
    \ uf.leader(1));\n    ASSERT_TRUE(uf.same(0, 1));\n    ASSERT_EQ(2, uf.size(0));\n\
    }\n\nTEST(DSUTest, Line) {\n    int n = 500000;\n    dsu uf(n);\n    for (int\
    \ i = 0; i < n - 1; i++) {\n        uf.merge(i, i + 1);\n    }\n    ASSERT_EQ(n,\
    \ uf.size(0));\n    ASSERT_EQ(1, uf.groups().size());\n}\n\nTEST(DSUTest, LineReverse)\
    \ {\n    int n = 500000;\n    dsu uf(n);\n    for (int i = n - 2; i >= 0; i--)\
    \ {\n        uf.merge(i, i + 1);\n    }\n    ASSERT_EQ(n, uf.size(0));\n    ASSERT_EQ(1,\
    \ uf.groups().size());\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/dsu_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/dsu_test.cpp
layout: document
redirect_from:
- /library/test/unittest/dsu_test.cpp
- /library/test/unittest/dsu_test.cpp.html
title: test/unittest/dsu_test.cpp
---
