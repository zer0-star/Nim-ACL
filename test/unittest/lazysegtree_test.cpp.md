---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/lazysegtree_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <algorithm>\n#include <atcoder/lazysegtree>\n#include <string>\n#include\
    \ <vector>\n\nusing namespace atcoder;\nstruct starry {\n    static int op_ss(int\
    \ a, int b) { return std::max(a, b); }\n    static int op_ts(int a, int b) { return\
    \ a + b; }\n    static int op_tt(int a, int b) { return a + b; }\n    static int\
    \ e_s() { return -1'000'000'000; }\n    static int e_t() { return 0; }\n};\n\n\
    using starry_seg = lazy_segtree<int,\n                                starry::op_ss,\n\
    \                                starry::e_s,\n                              \
    \  int,\n                                starry::op_ts,\n                    \
    \            starry::op_tt,\n                                starry::e_t>;\n\n\
    TEST(LazySegtreeTest, Zero) {\n    {\n        starry_seg s(0);\n        ASSERT_EQ(-1'000'000'000,\
    \ s.all_prod());\n    }\n    {\n        starry_seg s;\n        ASSERT_EQ(-1'000'000'000,\
    \ s.all_prod());\n    }\n    {\n        starry_seg s(10);\n        ASSERT_EQ(-1'000'000'000,\
    \ s.all_prod());\n    }\n}\n\nTEST(LazySegtreeTest, Assign) {\n    starry_seg\
    \ seg0;\n    seg0 = starry_seg(10);\n}\n\nTEST(LazySegtreeTest, Invalid) {\n \
    \   EXPECT_THROW(auto s = starry_seg(-1), std::exception);\n    starry_seg s(10);\n\
    \n    EXPECT_DEATH(s.get(-1), \".*\");\n    EXPECT_DEATH(s.get(10), \".*\");\n\
    \n    EXPECT_DEATH(s.prod(-1, -1), \".*\");\n    EXPECT_DEATH(s.prod(3, 2), \"\
    .*\");\n    EXPECT_DEATH(s.prod(0, 11), \".*\");\n    EXPECT_DEATH(s.prod(-1,\
    \ 11), \".*\");\n}\n\nTEST(LazySegtreeTest, NaiveProd) {\n    for (int n = 0;\
    \ n <= 50; n++) {\n        starry_seg seg(n);\n        std::vector<int> p(n);\n\
    \        for (int i = 0; i < n; i++) {\n            p[i] = (i * i + 100) % 31;\n\
    \            seg.set(i, p[i]);\n        }\n        for (int l = 0; l <= n; l++)\
    \ {\n            for (int r = l; r <= n; r++) {\n                int e = -1'000'000'000;\n\
    \                for (int i = l; i < r; i++) {\n                    e = std::max(e,\
    \ p[i]);\n                }\n                ASSERT_EQ(e, seg.prod(l, r));\n \
    \           }\n        }\n    }\n}\n\nTEST(LazySegtreeTest, Usage) {\n    starry_seg\
    \ seg(std::vector<int>(10, 0));\n    ASSERT_EQ(0, seg.all_prod());\n    seg.apply(0,\
    \ 3, 5);\n    ASSERT_EQ(5, seg.all_prod());\n    seg.apply(2, -10);\n    ASSERT_EQ(-5,\
    \ seg.prod(2, 3));\n    ASSERT_EQ(0, seg.prod(2, 4));\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <algorithm>\n#include <atcoder/lazysegtree>\n\
    #include <string>\n#include <vector>\n\nusing namespace atcoder;\nstruct starry\
    \ {\n    static int op_ss(int a, int b) { return std::max(a, b); }\n    static\
    \ int op_ts(int a, int b) { return a + b; }\n    static int op_tt(int a, int b)\
    \ { return a + b; }\n    static int e_s() { return -1'000'000'000; }\n    static\
    \ int e_t() { return 0; }\n};\n\nusing starry_seg = lazy_segtree<int,\n      \
    \                          starry::op_ss,\n                                starry::e_s,\n\
    \                                int,\n                                starry::op_ts,\n\
    \                                starry::op_tt,\n                            \
    \    starry::e_t>;\n\nTEST(LazySegtreeTest, Zero) {\n    {\n        starry_seg\
    \ s(0);\n        ASSERT_EQ(-1'000'000'000, s.all_prod());\n    }\n    {\n    \
    \    starry_seg s;\n        ASSERT_EQ(-1'000'000'000, s.all_prod());\n    }\n\
    \    {\n        starry_seg s(10);\n        ASSERT_EQ(-1'000'000'000, s.all_prod());\n\
    \    }\n}\n\nTEST(LazySegtreeTest, Assign) {\n    starry_seg seg0;\n    seg0 =\
    \ starry_seg(10);\n}\n\nTEST(LazySegtreeTest, Invalid) {\n    EXPECT_THROW(auto\
    \ s = starry_seg(-1), std::exception);\n    starry_seg s(10);\n\n    EXPECT_DEATH(s.get(-1),\
    \ \".*\");\n    EXPECT_DEATH(s.get(10), \".*\");\n\n    EXPECT_DEATH(s.prod(-1,\
    \ -1), \".*\");\n    EXPECT_DEATH(s.prod(3, 2), \".*\");\n    EXPECT_DEATH(s.prod(0,\
    \ 11), \".*\");\n    EXPECT_DEATH(s.prod(-1, 11), \".*\");\n}\n\nTEST(LazySegtreeTest,\
    \ NaiveProd) {\n    for (int n = 0; n <= 50; n++) {\n        starry_seg seg(n);\n\
    \        std::vector<int> p(n);\n        for (int i = 0; i < n; i++) {\n     \
    \       p[i] = (i * i + 100) % 31;\n            seg.set(i, p[i]);\n        }\n\
    \        for (int l = 0; l <= n; l++) {\n            for (int r = l; r <= n; r++)\
    \ {\n                int e = -1'000'000'000;\n                for (int i = l;\
    \ i < r; i++) {\n                    e = std::max(e, p[i]);\n                }\n\
    \                ASSERT_EQ(e, seg.prod(l, r));\n            }\n        }\n   \
    \ }\n}\n\nTEST(LazySegtreeTest, Usage) {\n    starry_seg seg(std::vector<int>(10,\
    \ 0));\n    ASSERT_EQ(0, seg.all_prod());\n    seg.apply(0, 3, 5);\n    ASSERT_EQ(5,\
    \ seg.all_prod());\n    seg.apply(2, -10);\n    ASSERT_EQ(-5, seg.prod(2, 3));\n\
    \    ASSERT_EQ(0, seg.prod(2, 4));\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/lazysegtree_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/lazysegtree_test.cpp
layout: document
redirect_from:
- /library/test/unittest/lazysegtree_test.cpp
- /library/test/unittest/lazysegtree_test.cpp.html
title: test/unittest/lazysegtree_test.cpp
---
