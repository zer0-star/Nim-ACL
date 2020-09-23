---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/fenwicktree_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/fenwicktree>\n#include <atcoder/modint>\n#include <numeric>\n\
    \nusing namespace atcoder;\nusing ll = long long;\nusing ull = unsigned long long;\n\
    \nTEST(FenwickTreeTest, Empty) {\n    fenwick_tree<ll> fw_ll;\n    ASSERT_EQ(0,\
    \ fw_ll.sum(0, 0));\n\n    fenwick_tree<modint> fw_modint;\n    ASSERT_EQ(0, fw_modint.sum(0,\
    \ 0).val());\n}\n\nTEST(FenwickTreeTest, Assign) {\n    fenwick_tree<ll> fw;\n\
    \    fw = fenwick_tree<ll>(10);\n}\n\nTEST(FenwickTreeTest, Zero) {\n    fenwick_tree<ll>\
    \ fw_ll(0);\n    ASSERT_EQ(0, fw_ll.sum(0, 0));\n\n    fenwick_tree<modint> fw_modint(0);\n\
    \    ASSERT_EQ(0, fw_modint.sum(0, 0).val());\n}\n\nTEST(FenwickTreeTest, OverFlowULL)\
    \ {\n    fenwick_tree<ull> fw(10);\n    for (int i = 0; i < 10; i++) {\n     \
    \   fw.add(i, (1ULL << 63) + i);\n    }\n    for (int i = 0; i <= 10; i++) {\n\
    \        for (int j = i; j <= 10; j++) {\n            ull sum = 0;\n         \
    \   for (int k = i; k < j; k++) {\n                sum += k;\n            }\n\
    \            ASSERT_EQ(((j - i) % 2) ? (1ULL << 63) + sum : sum, fw.sum(i, j));\n\
    \        }\n    }\n}\n\nTEST(FenwickTreeTest, NaiveTest) {\n    for (int n = 0;\
    \ n <= 50; n++) {\n        fenwick_tree<ll> fw(n);\n        for (int i = 0; i\
    \ < n; i++) {\n            fw.add(i, i * i);\n        }\n        for (int l =\
    \ 0; l <= n; l++) {\n            for (int r = l; r <= n; r++) {\n            \
    \    ll sum = 0;\n                for (int i = l; i < r; i++) {\n            \
    \        sum += i * i;\n                }\n                ASSERT_EQ(sum, fw.sum(l,\
    \ r));\n            }\n        }\n    }\n}\n\nTEST(FenwickTreeTest, SMintTest)\
    \ {\n    using mint = static_modint<11>;\n    for (int n = 0; n <= 50; n++) {\n\
    \        fenwick_tree<mint> fw(n);\n        for (int i = 0; i < n; i++) {\n  \
    \          fw.add(i, i * i);\n        }\n        for (int l = 0; l <= n; l++)\
    \ {\n            for (int r = l; r <= n; r++) {\n                mint sum = 0;\n\
    \                for (int i = l; i < r; i++) {\n                    sum += i *\
    \ i;\n                }\n                ASSERT_EQ(sum, fw.sum(l, r));\n     \
    \       }\n        }\n    }\n}\n\nTEST(FenwickTreeTest, MintTest) {\n    using\
    \ mint = modint;\n    mint::set_mod(11);\n    for (int n = 0; n <= 50; n++) {\n\
    \        fenwick_tree<mint> fw(n);\n        for (int i = 0; i < n; i++) {\n  \
    \          fw.add(i, i * i);\n        }\n        for (int l = 0; l <= n; l++)\
    \ {\n            for (int r = l; r <= n; r++) {\n                mint sum = 0;\n\
    \                for (int i = l; i < r; i++) {\n                    sum += i *\
    \ i;\n                }\n                ASSERT_EQ(sum, fw.sum(l, r));\n     \
    \       }\n        }\n    }\n}\n\nTEST(FenwickTreeTest, Invalid) {\n    EXPECT_THROW(auto\
    \ s = fenwick_tree<int>(-1), std::exception);\n    fenwick_tree<int> s(10);\n\n\
    \    EXPECT_DEATH(s.add(-1, 0), \".*\");\n    EXPECT_DEATH(s.add(10, 0), \".*\"\
    );\n\n    EXPECT_DEATH(s.sum(-1, 3), \".*\");\n    EXPECT_DEATH(s.sum(3, 11),\
    \ \".*\");\n    EXPECT_DEATH(s.sum(5, 3), \".*\");\n}\n\nTEST(FenwickTreeTest,\
    \ Bound) {\n    fenwick_tree<int> fw(10);\n    fw.add(3, std::numeric_limits<int>::max());\n\
    \    fw.add(5, std::numeric_limits<int>::min());\n    ASSERT_EQ(-1, fw.sum(0,\
    \ 10));\n    ASSERT_EQ(-1, fw.sum(3, 6));\n    ASSERT_EQ(std::numeric_limits<int>::max(),\
    \ fw.sum(3, 4));\n    ASSERT_EQ(std::numeric_limits<int>::min(), fw.sum(4, 10));\n\
    }\n\nTEST(FenwickTreeTest, Boundll) {\n    fenwick_tree<ll> fw(10);\n    fw.add(3,\
    \ std::numeric_limits<ll>::max());\n    fw.add(5, std::numeric_limits<ll>::min());\n\
    \    ASSERT_EQ(-1, fw.sum(0, 10));\n    ASSERT_EQ(-1, fw.sum(3, 6));\n    ASSERT_EQ(std::numeric_limits<ll>::max(),\
    \ fw.sum(3, 4));\n    ASSERT_EQ(std::numeric_limits<ll>::min(), fw.sum(4, 10));\n\
    }\n\nTEST(FenwickTreeTest, OverFlow) {\n    fenwick_tree<int> fw(20);\n    std::vector<ll>\
    \ a(20);\n    for (int i = 0; i < 10; i++) {\n        int x = std::numeric_limits<int>::max();\n\
    \        a[i] += x;\n        fw.add(i, x);\n    }\n    for (int i = 10; i < 20;\
    \ i++) {\n        int x = std::numeric_limits<int>::min();\n        a[i] += x;\n\
    \        fw.add(i, x);\n    }\n    a[5] += 11111;\n    fw.add(5, 11111);\n\n \
    \   for (int l = 0; l <= 20; l++) {\n        for (int r = l; r <= 20; r++) {\n\
    \            ll sum = 0;\n            for (int i = l; i < r; i++) {\n        \
    \        sum += a[i];\n            }\n            ll dif = sum - fw.sum(l, r);\n\
    \            ASSERT_EQ(0, dif % (1LL << 32));\n        }\n    }\n}\n\n#ifndef\
    \ _MSC_VER\n\nTEST(FenwickTreeTest, Int128) {\n    fenwick_tree<__int128> fw(20);\n\
    \    for (int i = 0; i < 20; i++) {\n        fw.add(i, i);\n    }\n\n    for (int\
    \ l = 0; l <= 20; l++) {\n        for (int r = l; r <= 20; r++) {\n          \
    \  ll sum = 0;\n            for (int i = l; i < r; i++) {\n                sum\
    \ += i;\n            }\n            ASSERT_EQ(sum, fw.sum(l, r));\n        }\n\
    \    }\n}\n\n#endif\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/fenwicktree>\n#include <atcoder/modint>\n\
    #include <numeric>\n\nusing namespace atcoder;\nusing ll = long long;\nusing ull\
    \ = unsigned long long;\n\nTEST(FenwickTreeTest, Empty) {\n    fenwick_tree<ll>\
    \ fw_ll;\n    ASSERT_EQ(0, fw_ll.sum(0, 0));\n\n    fenwick_tree<modint> fw_modint;\n\
    \    ASSERT_EQ(0, fw_modint.sum(0, 0).val());\n}\n\nTEST(FenwickTreeTest, Assign)\
    \ {\n    fenwick_tree<ll> fw;\n    fw = fenwick_tree<ll>(10);\n}\n\nTEST(FenwickTreeTest,\
    \ Zero) {\n    fenwick_tree<ll> fw_ll(0);\n    ASSERT_EQ(0, fw_ll.sum(0, 0));\n\
    \n    fenwick_tree<modint> fw_modint(0);\n    ASSERT_EQ(0, fw_modint.sum(0, 0).val());\n\
    }\n\nTEST(FenwickTreeTest, OverFlowULL) {\n    fenwick_tree<ull> fw(10);\n   \
    \ for (int i = 0; i < 10; i++) {\n        fw.add(i, (1ULL << 63) + i);\n    }\n\
    \    for (int i = 0; i <= 10; i++) {\n        for (int j = i; j <= 10; j++) {\n\
    \            ull sum = 0;\n            for (int k = i; k < j; k++) {\n       \
    \         sum += k;\n            }\n            ASSERT_EQ(((j - i) % 2) ? (1ULL\
    \ << 63) + sum : sum, fw.sum(i, j));\n        }\n    }\n}\n\nTEST(FenwickTreeTest,\
    \ NaiveTest) {\n    for (int n = 0; n <= 50; n++) {\n        fenwick_tree<ll>\
    \ fw(n);\n        for (int i = 0; i < n; i++) {\n            fw.add(i, i * i);\n\
    \        }\n        for (int l = 0; l <= n; l++) {\n            for (int r = l;\
    \ r <= n; r++) {\n                ll sum = 0;\n                for (int i = l;\
    \ i < r; i++) {\n                    sum += i * i;\n                }\n      \
    \          ASSERT_EQ(sum, fw.sum(l, r));\n            }\n        }\n    }\n}\n\
    \nTEST(FenwickTreeTest, SMintTest) {\n    using mint = static_modint<11>;\n  \
    \  for (int n = 0; n <= 50; n++) {\n        fenwick_tree<mint> fw(n);\n      \
    \  for (int i = 0; i < n; i++) {\n            fw.add(i, i * i);\n        }\n \
    \       for (int l = 0; l <= n; l++) {\n            for (int r = l; r <= n; r++)\
    \ {\n                mint sum = 0;\n                for (int i = l; i < r; i++)\
    \ {\n                    sum += i * i;\n                }\n                ASSERT_EQ(sum,\
    \ fw.sum(l, r));\n            }\n        }\n    }\n}\n\nTEST(FenwickTreeTest,\
    \ MintTest) {\n    using mint = modint;\n    mint::set_mod(11);\n    for (int\
    \ n = 0; n <= 50; n++) {\n        fenwick_tree<mint> fw(n);\n        for (int\
    \ i = 0; i < n; i++) {\n            fw.add(i, i * i);\n        }\n        for\
    \ (int l = 0; l <= n; l++) {\n            for (int r = l; r <= n; r++) {\n   \
    \             mint sum = 0;\n                for (int i = l; i < r; i++) {\n \
    \                   sum += i * i;\n                }\n                ASSERT_EQ(sum,\
    \ fw.sum(l, r));\n            }\n        }\n    }\n}\n\nTEST(FenwickTreeTest,\
    \ Invalid) {\n    EXPECT_THROW(auto s = fenwick_tree<int>(-1), std::exception);\n\
    \    fenwick_tree<int> s(10);\n\n    EXPECT_DEATH(s.add(-1, 0), \".*\");\n   \
    \ EXPECT_DEATH(s.add(10, 0), \".*\");\n\n    EXPECT_DEATH(s.sum(-1, 3), \".*\"\
    );\n    EXPECT_DEATH(s.sum(3, 11), \".*\");\n    EXPECT_DEATH(s.sum(5, 3), \"\
    .*\");\n}\n\nTEST(FenwickTreeTest, Bound) {\n    fenwick_tree<int> fw(10);\n \
    \   fw.add(3, std::numeric_limits<int>::max());\n    fw.add(5, std::numeric_limits<int>::min());\n\
    \    ASSERT_EQ(-1, fw.sum(0, 10));\n    ASSERT_EQ(-1, fw.sum(3, 6));\n    ASSERT_EQ(std::numeric_limits<int>::max(),\
    \ fw.sum(3, 4));\n    ASSERT_EQ(std::numeric_limits<int>::min(), fw.sum(4, 10));\n\
    }\n\nTEST(FenwickTreeTest, Boundll) {\n    fenwick_tree<ll> fw(10);\n    fw.add(3,\
    \ std::numeric_limits<ll>::max());\n    fw.add(5, std::numeric_limits<ll>::min());\n\
    \    ASSERT_EQ(-1, fw.sum(0, 10));\n    ASSERT_EQ(-1, fw.sum(3, 6));\n    ASSERT_EQ(std::numeric_limits<ll>::max(),\
    \ fw.sum(3, 4));\n    ASSERT_EQ(std::numeric_limits<ll>::min(), fw.sum(4, 10));\n\
    }\n\nTEST(FenwickTreeTest, OverFlow) {\n    fenwick_tree<int> fw(20);\n    std::vector<ll>\
    \ a(20);\n    for (int i = 0; i < 10; i++) {\n        int x = std::numeric_limits<int>::max();\n\
    \        a[i] += x;\n        fw.add(i, x);\n    }\n    for (int i = 10; i < 20;\
    \ i++) {\n        int x = std::numeric_limits<int>::min();\n        a[i] += x;\n\
    \        fw.add(i, x);\n    }\n    a[5] += 11111;\n    fw.add(5, 11111);\n\n \
    \   for (int l = 0; l <= 20; l++) {\n        for (int r = l; r <= 20; r++) {\n\
    \            ll sum = 0;\n            for (int i = l; i < r; i++) {\n        \
    \        sum += a[i];\n            }\n            ll dif = sum - fw.sum(l, r);\n\
    \            ASSERT_EQ(0, dif % (1LL << 32));\n        }\n    }\n}\n\n#ifndef\
    \ _MSC_VER\n\nTEST(FenwickTreeTest, Int128) {\n    fenwick_tree<__int128> fw(20);\n\
    \    for (int i = 0; i < 20; i++) {\n        fw.add(i, i);\n    }\n\n    for (int\
    \ l = 0; l <= 20; l++) {\n        for (int r = l; r <= 20; r++) {\n          \
    \  ll sum = 0;\n            for (int i = l; i < r; i++) {\n                sum\
    \ += i;\n            }\n            ASSERT_EQ(sum, fw.sum(l, r));\n        }\n\
    \    }\n}\n\n#endif"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/fenwicktree_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/fenwicktree_test.cpp
layout: document
redirect_from:
- /library/test/unittest/fenwicktree_test.cpp
- /library/test/unittest/fenwicktree_test.cpp.html
title: test/unittest/fenwicktree_test.cpp
---
