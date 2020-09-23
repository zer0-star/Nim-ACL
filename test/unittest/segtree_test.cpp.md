---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/segtree_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/segtree>\n#include <string>\n#include <vector>\n\nusing namespace\
    \ atcoder;\n\ntemplate <class S, S (*op)(S, S), S (*e)()> struct segtree_naive\
    \ {\n    int n;\n    std::vector<std::string> d;\n    segtree_naive(int _n) :\
    \ n(_n), d(n, e()) {}\n\n    void set(int p, S x) { d[p] = x; }\n    S get(int\
    \ p) { return d[p]; }\n    S prod(int l, int r) {\n        S sum = e();\n    \
    \    for (int i = l; i < r; i++) {\n            sum = op(sum, d[i]);\n       \
    \ }\n        return sum;\n    }\n    S all_prod() { return prod(0, n); }\n\n \
    \   template <bool (*f)(S)> int max_right(int l) {\n        S sum = e();\n   \
    \     assert(f(sum));\n        for (int i = l; i < n; i++) {\n            sum\
    \ = op(sum, d[i]);\n            if (!f(sum)) return i;\n        }\n        return\
    \ n;\n    }\n\n    template <bool (*f)(S)> int min_left(int r) {\n        S sum\
    \ = e();\n        assert(f(sum));\n        for (int i = r - 1; i >= 0; i--) {\n\
    \            sum = op(d[i], sum);\n            if (!f(sum)) return i + 1;\n  \
    \      }\n        return 0;\n    }\n};\n\nstd::string op(std::string a, std::string\
    \ b) {\n    assert(a == \"$\" || b == \"$\" || a <= b);\n    if (a == \"$\") return\
    \ b;\n    if (b == \"$\") return a;\n    return a + b;\n}\n\nstd::string e() {\
    \ return \"$\"; }\n\nusing seg = segtree<std::string, op, e>;\nusing seg_naive\
    \ = segtree_naive<std::string, op, e>;\n\nTEST(SegtreeTest, Zero) {\n    {\n \
    \       seg s(0);\n        ASSERT_EQ(\"$\", s.all_prod());\n    }\n    {\n   \
    \     seg s;\n        ASSERT_EQ(\"$\", s.all_prod());\n    }\n}\n\nTEST(SegtreeTest,\
    \ Invalid) {\n    EXPECT_THROW(auto s = seg(-1), std::exception);\n    seg s(10);\n\
    \n    EXPECT_DEATH(s.get(-1), \".*\");\n    EXPECT_DEATH(s.get(10), \".*\");\n\
    \n    EXPECT_DEATH(s.prod(-1, -1), \".*\");\n    EXPECT_DEATH(s.prod(3, 2), \"\
    .*\");\n    EXPECT_DEATH(s.prod(0, 11), \".*\");\n    EXPECT_DEATH(s.prod(-1,\
    \ 11), \".*\");\n\n    EXPECT_DEATH(s.max_right(11, [](std::string) { return true;\
    \ }), \".*\");\n    EXPECT_DEATH(s.min_left(-1, [](std::string) { return true;\
    \ }), \".*\");\n    EXPECT_DEATH(s.max_right(0, [](std::string) { return false;\
    \ }), \".*\");\n}\n\nTEST(SegtreeTest, One) {\n    seg s(1);\n    ASSERT_EQ(\"\
    $\", s.all_prod());\n    ASSERT_EQ(\"$\", s.get(0));\n    ASSERT_EQ(\"$\", s.prod(0,\
    \ 1));\n    s.set(0, \"dummy\");\n    ASSERT_EQ(\"dummy\", s.get(0));\n    ASSERT_EQ(\"\
    $\", s.prod(0, 0));\n    ASSERT_EQ(\"dummy\", s.prod(0, 1));\n    ASSERT_EQ(\"\
    $\", s.prod(1, 1));\n}\n\nstd::string y;\nbool leq_y(std::string x) { return x.size()\
    \ <= y.size(); }\n\nTEST(SegtreeTest, CompareNaive) {\n    for (int n = 0; n <\
    \ 30; n++) {\n        seg_naive seg0(n);\n        seg seg1(n);\n        for (int\
    \ i = 0; i < n; i++) {\n            std::string s = \"\";\n            s += char('a'\
    \ + i);\n            seg0.set(i, s);\n            seg1.set(i, s);\n        }\n\
    \n        for (int l = 0; l <= n; l++) {\n            for (int r = l; r <= n;\
    \ r++) {\n                ASSERT_EQ(seg0.prod(l, r), seg1.prod(l, r));\n     \
    \       }\n        }\n\n        for (int l = 0; l <= n; l++) {\n            for\
    \ (int r = l; r <= n; r++) {\n                y = seg1.prod(l, r);\n         \
    \       ASSERT_EQ(seg0.max_right<leq_y>(l), seg1.max_right<leq_y>(l));\n     \
    \           ASSERT_EQ(seg0.max_right<leq_y>(l),\n                          seg1.max_right(l,\
    \ [&](std::string x) {\n                              return x.size() <= y.size();\n\
    \                          }));\n            }\n        }\n\n        for (int\
    \ r = 0; r <= n; r++) {\n            for (int l = 0; l <= r; l++) {\n        \
    \        y = seg1.prod(l, r);\n                ASSERT_EQ(seg0.min_left<leq_y>(r),\
    \ seg1.min_left<leq_y>(r));\n                ASSERT_EQ(seg0.min_left<leq_y>(r),\n\
    \                          seg1.min_left(r, [&](std::string x) {\n           \
    \                   return x.size() <= y.size();\n                          }));\n\
    \            }\n        }\n    }\n}\n\nTEST(SegtreeTest, Assign) {\n    seg seg0;\n\
    \    seg0 = seg(10);\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/segtree>\n#include <string>\n\
    #include <vector>\n\nusing namespace atcoder;\n\ntemplate <class S, S (*op)(S,\
    \ S), S (*e)()> struct segtree_naive {\n    int n;\n    std::vector<std::string>\
    \ d;\n    segtree_naive(int _n) : n(_n), d(n, e()) {}\n\n    void set(int p, S\
    \ x) { d[p] = x; }\n    S get(int p) { return d[p]; }\n    S prod(int l, int r)\
    \ {\n        S sum = e();\n        for (int i = l; i < r; i++) {\n           \
    \ sum = op(sum, d[i]);\n        }\n        return sum;\n    }\n    S all_prod()\
    \ { return prod(0, n); }\n\n    template <bool (*f)(S)> int max_right(int l) {\n\
    \        S sum = e();\n        assert(f(sum));\n        for (int i = l; i < n;\
    \ i++) {\n            sum = op(sum, d[i]);\n            if (!f(sum)) return i;\n\
    \        }\n        return n;\n    }\n\n    template <bool (*f)(S)> int min_left(int\
    \ r) {\n        S sum = e();\n        assert(f(sum));\n        for (int i = r\
    \ - 1; i >= 0; i--) {\n            sum = op(d[i], sum);\n            if (!f(sum))\
    \ return i + 1;\n        }\n        return 0;\n    }\n};\n\nstd::string op(std::string\
    \ a, std::string b) {\n    assert(a == \"$\" || b == \"$\" || a <= b);\n    if\
    \ (a == \"$\") return b;\n    if (b == \"$\") return a;\n    return a + b;\n}\n\
    \nstd::string e() { return \"$\"; }\n\nusing seg = segtree<std::string, op, e>;\n\
    using seg_naive = segtree_naive<std::string, op, e>;\n\nTEST(SegtreeTest, Zero)\
    \ {\n    {\n        seg s(0);\n        ASSERT_EQ(\"$\", s.all_prod());\n    }\n\
    \    {\n        seg s;\n        ASSERT_EQ(\"$\", s.all_prod());\n    }\n}\n\n\
    TEST(SegtreeTest, Invalid) {\n    EXPECT_THROW(auto s = seg(-1), std::exception);\n\
    \    seg s(10);\n\n    EXPECT_DEATH(s.get(-1), \".*\");\n    EXPECT_DEATH(s.get(10),\
    \ \".*\");\n\n    EXPECT_DEATH(s.prod(-1, -1), \".*\");\n    EXPECT_DEATH(s.prod(3,\
    \ 2), \".*\");\n    EXPECT_DEATH(s.prod(0, 11), \".*\");\n    EXPECT_DEATH(s.prod(-1,\
    \ 11), \".*\");\n\n    EXPECT_DEATH(s.max_right(11, [](std::string) { return true;\
    \ }), \".*\");\n    EXPECT_DEATH(s.min_left(-1, [](std::string) { return true;\
    \ }), \".*\");\n    EXPECT_DEATH(s.max_right(0, [](std::string) { return false;\
    \ }), \".*\");\n}\n\nTEST(SegtreeTest, One) {\n    seg s(1);\n    ASSERT_EQ(\"\
    $\", s.all_prod());\n    ASSERT_EQ(\"$\", s.get(0));\n    ASSERT_EQ(\"$\", s.prod(0,\
    \ 1));\n    s.set(0, \"dummy\");\n    ASSERT_EQ(\"dummy\", s.get(0));\n    ASSERT_EQ(\"\
    $\", s.prod(0, 0));\n    ASSERT_EQ(\"dummy\", s.prod(0, 1));\n    ASSERT_EQ(\"\
    $\", s.prod(1, 1));\n}\n\nstd::string y;\nbool leq_y(std::string x) { return x.size()\
    \ <= y.size(); }\n\nTEST(SegtreeTest, CompareNaive) {\n    for (int n = 0; n <\
    \ 30; n++) {\n        seg_naive seg0(n);\n        seg seg1(n);\n        for (int\
    \ i = 0; i < n; i++) {\n            std::string s = \"\";\n            s += char('a'\
    \ + i);\n            seg0.set(i, s);\n            seg1.set(i, s);\n        }\n\
    \n        for (int l = 0; l <= n; l++) {\n            for (int r = l; r <= n;\
    \ r++) {\n                ASSERT_EQ(seg0.prod(l, r), seg1.prod(l, r));\n     \
    \       }\n        }\n\n        for (int l = 0; l <= n; l++) {\n            for\
    \ (int r = l; r <= n; r++) {\n                y = seg1.prod(l, r);\n         \
    \       ASSERT_EQ(seg0.max_right<leq_y>(l), seg1.max_right<leq_y>(l));\n     \
    \           ASSERT_EQ(seg0.max_right<leq_y>(l),\n                          seg1.max_right(l,\
    \ [&](std::string x) {\n                              return x.size() <= y.size();\n\
    \                          }));\n            }\n        }\n\n        for (int\
    \ r = 0; r <= n; r++) {\n            for (int l = 0; l <= r; l++) {\n        \
    \        y = seg1.prod(l, r);\n                ASSERT_EQ(seg0.min_left<leq_y>(r),\
    \ seg1.min_left<leq_y>(r));\n                ASSERT_EQ(seg0.min_left<leq_y>(r),\n\
    \                          seg1.min_left(r, [&](std::string x) {\n           \
    \                   return x.size() <= y.size();\n                          }));\n\
    \            }\n        }\n    }\n}\n\nTEST(SegtreeTest, Assign) {\n    seg seg0;\n\
    \    seg0 = seg(10);\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/segtree_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/segtree_test.cpp
layout: document
redirect_from:
- /library/test/unittest/segtree_test.cpp
- /library/test/unittest/segtree_test.cpp.html
title: test/unittest/segtree_test.cpp
---
