---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/convolution_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/convolution>\n#include <atcoder/modint>\n#include <random>\n\
    #line 1 \"test/utils/random.hpp\"\n\n#line 3 \"test/utils/random.hpp\"\n\nstd::mt19937\
    \ global_mt19937;\n\n// random choise from [a, b]\ntemplate <class T>\nT randint(T\
    \ a, T b) {\n    return std::uniform_int_distribution<T>(a, b)(global_mt19937);\n\
    }\n\nbool randbool() {\n    return randint(0, 1) == 0;\n}\n\n// random choice\
    \ 2 disjoint elements from [lower, upper]\ntemplate <class T> std::pair<T, T>\
    \ randpair(T lower, T upper) {\n    assert(upper - lower >= 1);\n    T a, b;\n\
    \    do {\n        a = randint(lower, upper);\n        b = randint(lower, upper);\n\
    \    } while (a == b);\n    if (a > b) std::swap(a, b);\n    return {a, b};\n\
    }\n#line 7 \"test/unittest/convolution_test.cpp\"\n\nusing namespace atcoder;\n\
    using uint = unsigned int;\nusing ll = long long;\nusing ull = unsigned long long;\n\
    \nstd::vector<ll> conv_ll_naive(std::vector<ll> a, std::vector<ll> b) {\n    int\
    \ n = int(a.size()), m = int(b.size());\n    std::vector<ll> c(n + m - 1);\n \
    \   for (int i = 0; i < n; i++) {\n        for (int j = 0; j < m; j++) {\n   \
    \         c[i + j] += a[i] * b[j];\n        }\n    }\n    return c;\n}\n\ntemplate\
    \ <class mint, internal::is_static_modint_t<mint>* = nullptr>\nstd::vector<mint>\
    \ conv_naive(std::vector<mint> a, std::vector<mint> b) {\n    int n = int(a.size()),\
    \ m = int(b.size());\n    std::vector<mint> c(n + m - 1);\n    for (int i = 0;\
    \ i < n; i++) {\n        for (int j = 0; j < m; j++) {\n            c[i + j] +=\
    \ a[i] * b[j];\n        }\n    }\n    return c;\n}\n\ntemplate <int MOD,\n   \
    \       class T,\n          std::enable_if_t<internal::is_integral<T>::value>*\
    \ = nullptr>\nstd::vector<T> conv_naive(std::vector<T> a, std::vector<T> b) {\n\
    \    int n = int(a.size()), m = int(b.size());\n    std::vector<T> c(n + m - 1);\n\
    \    for (int i = 0; i < n; i++) {\n        for (int j = 0; j < m; j++) {\n  \
    \          c[i + j] += (T)((ll)a[i] * (ll)b[j] % MOD);\n            if (c[i +\
    \ j] >= MOD) c[i + j] -= MOD;\n        }\n    }\n    return c;\n}\n\nTEST(ConvolutionTest,\
    \ Empty) {\n    ASSERT_EQ(std::vector<int>{},\n              convolution(std::vector<int>{},\
    \ std::vector<int>{}));\n    ASSERT_EQ(std::vector<int>{},\n              convolution(std::vector<int>{},\
    \ std::vector<int>{1, 2}));\n    ASSERT_EQ(std::vector<int>{},\n             \
    \ convolution(std::vector<int>{1, 2}, std::vector<int>{}));\n    ASSERT_EQ(std::vector<int>{},\n\
    \              convolution(std::vector<int>{1}, std::vector<int>{}));\n    ASSERT_EQ(std::vector<ll>{},\n\
    \              convolution(std::vector<ll>{}, std::vector<ll>{}));\n    ASSERT_EQ(std::vector<ll>{},\n\
    \              convolution(std::vector<ll>{}, std::vector<ll>{1, 2}));\n\n   \
    \ ASSERT_EQ(std::vector<modint998244353>{},\n              convolution(std::vector<modint998244353>{},\n\
    \                          std::vector<modint998244353>{}));\n    ASSERT_EQ(std::vector<modint998244353>{},\n\
    \              convolution(std::vector<modint998244353>{},\n                 \
    \         std::vector<modint998244353>{1, 2}));\n}\n\nTEST(ConvolutionTest, Mid)\
    \ {\n    std::mt19937 mt;\n    int n = 1234, m = 2345;\n    std::vector<modint998244353>\
    \ a(n), b(m);\n    \n    for (int i = 0; i < n; i++) {\n        a[i] = mt();\n\
    \    }\n    for (int i = 0; i < m; i++) {\n        b[i] = mt();\n    }\n    ASSERT_EQ(conv_naive(a,\
    \ b), convolution(a, b));\n}\n\nTEST(ConvolutionTest, SimpleSMod) {\n    const\
    \ int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n    using s_mint1 =\
    \ static_modint<MOD1>;\n    using s_mint2 = static_modint<MOD2>;\n\n    std::mt19937\
    \ mt;\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1; m < 20; m++)\
    \ {\n            std::vector<s_mint1> a(n), b(m);\n            for (int i = 0;\
    \ i < n; i++) {\n                a[i] = mt();\n            }\n            for\
    \ (int i = 0; i < m; i++) {\n                b[i] = mt();\n            }\n   \
    \         ASSERT_EQ(conv_naive(a, b), convolution(a, b));\n        }\n    }\n\
    \    for (int n = 1; n < 20; n++) {\n        for (int m = 1; m < 20; m++) {\n\
    \            std::vector<s_mint2> a(n), b(m);\n            for (int i = 0; i <\
    \ n; i++) {\n                a[i] = mt();\n            }\n            for (int\
    \ i = 0; i < m; i++) {\n                b[i] = mt();\n            }\n        \
    \    ASSERT_EQ(conv_naive(a, b), convolution(a, b));\n        }\n    }\n}\n\n\
    TEST(ConvolutionTest, SimpleInt) {\n    const int MOD1 = 998244353;\n    const\
    \ int MOD2 = 924844033;\n\n    std::mt19937 mt;\n    for (int n = 1; n < 20; n++)\
    \ {\n        for (int m = 1; m < 20; m++) {\n            std::vector<int> a(n),\
    \ b(m);\n            for (int i = 0; i < n; i++) {\n                a[i] = int(mt()\
    \ % MOD1);\n            }\n            for (int i = 0; i < m; i++) {\n       \
    \         b[i] = int(mt() % MOD1);\n            }\n            ASSERT_EQ(conv_naive<MOD1>(a,\
    \ b), convolution(a, b));\n            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<MOD1>(a,\
    \ b)));\n        }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int\
    \ m = 1; m < 20; m++) {\n            std::vector<int> a(n), b(m);\n          \
    \  for (int i = 0; i < n; i++) {\n                a[i] = int(mt() % MOD2);\n \
    \           }\n            for (int i = 0; i < m; i++) {\n                b[i]\
    \ = int(mt() % MOD2);\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a,\
    \ b), (convolution<MOD2>(a, b)));\n        }\n    }\n}\n\nTEST(ConvolutionTest,\
    \ SimpleUint) {\n    const int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n\
    \n    std::mt19937 mt;\n    for (int n = 1; n < 20; n++) {\n        for (int m\
    \ = 1; m < 20; m++) {\n            std::vector<uint> a(n), b(m);\n           \
    \ for (int i = 0; i < n; i++) {\n                a[i] = uint(mt() % MOD1);\n \
    \           }\n            for (int i = 0; i < m; i++) {\n                b[i]\
    \ = uint(mt() % MOD1);\n            }\n            ASSERT_EQ(conv_naive<MOD1>(a,\
    \ b), convolution(a, b));\n            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<MOD1>(a,\
    \ b)));\n        }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int\
    \ m = 1; m < 20; m++) {\n            std::vector<uint> a(n), b(m);\n         \
    \   for (int i = 0; i < n; i++) {\n                a[i] = uint(mt() % MOD2);\n\
    \            }\n            for (int i = 0; i < m; i++) {\n                b[i]\
    \ = uint(mt() % MOD2);\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a,\
    \ b), (convolution<MOD2>(a, b)));\n        }\n    }\n}\n\nTEST(ConvolutionTest,\
    \ SimpleLL) {\n    const int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n\
    \n    std::mt19937 mt;\n    for (int n = 1; n < 20; n++) {\n        for (int m\
    \ = 1; m < 20; m++) {\n            std::vector<ll> a(n), b(m);\n            for\
    \ (int i = 0; i < n; i++) {\n                a[i] = ll(mt() % MOD1);\n       \
    \     }\n            for (int i = 0; i < m; i++) {\n                b[i] = ll(mt()\
    \ % MOD1);\n            }\n            ASSERT_EQ(conv_naive<MOD1>(a, b), convolution(a,\
    \ b));\n            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<998244353>(a,\
    \ b)));\n        }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int\
    \ m = 1; m < 20; m++) {\n            std::vector<ll> a(n), b(m);\n           \
    \ for (int i = 0; i < n; i++) {\n                a[i] = ll(mt() % MOD2);\n   \
    \         }\n            for (int i = 0; i < m; i++) {\n                b[i] =\
    \ ll(mt() % MOD2);\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a, b),\
    \ (convolution<MOD2>(a, b)));\n        }\n    }\n}\n\nTEST(ConvolutionTest, SimpleULL)\
    \ {\n    const int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n\n    std::mt19937\
    \ mt;\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1; m < 20; m++)\
    \ {\n            std::vector<ull> a(n), b(m);\n            for (int i = 0; i <\
    \ n; i++) {\n                a[i] = ull(mt() % MOD1);\n            }\n       \
    \     for (int i = 0; i < m; i++) {\n                b[i] = ull(mt() % MOD1);\n\
    \            }\n            ASSERT_EQ(conv_naive<MOD1>(a, b), convolution(a, b));\n\
    \            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<MOD1>(a, b)));\n \
    \       }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1;\
    \ m < 20; m++) {\n            std::vector<ull> a(n), b(m);\n            for (int\
    \ i = 0; i < n; i++) {\n                a[i] = ull(mt() % MOD2);\n           \
    \ }\n            for (int i = 0; i < m; i++) {\n                b[i] = ull(mt()\
    \ % MOD2);\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a, b), (convolution<MOD2>(a,\
    \ b)));\n        }\n    }\n}\n\n#ifndef _MSC_VER\nTEST(ConvolutionTest, SimpleInt128)\
    \ {\n    const int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n\n    std::mt19937\
    \ mt;\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1; m < 20; m++)\
    \ {\n            std::vector<__int128> a(n), b(m);\n            for (int i = 0;\
    \ i < n; i++) {\n                a[i] = mt() % MOD1;\n            }\n        \
    \    for (int i = 0; i < m; i++) {\n                b[i] = mt() % MOD1;\n    \
    \        }\n            ASSERT_EQ(conv_naive<MOD1>(a, b), convolution(a, b));\n\
    \            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<MOD1>(a, b)));\n \
    \       }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1;\
    \ m < 20; m++) {\n            std::vector<__int128> a(n), b(m);\n            for\
    \ (int i = 0; i < n; i++) {\n                a[i] = mt() % MOD2;\n           \
    \ }\n            for (int i = 0; i < m; i++) {\n                b[i] = mt() %\
    \ MOD2;\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a, b), (convolution<MOD2>(a,\
    \ b)));\n        }\n    }\n}\n\nTEST(ConvolutionTest, SimpleUInt128) {\n    const\
    \ int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n\n    std::mt19937 mt;\n\
    \    for (int n = 1; n < 20; n++) {\n        for (int m = 1; m < 20; m++) {\n\
    \            std::vector<unsigned __int128> a(n), b(m);\n            for (int\
    \ i = 0; i < n; i++) {\n                a[i] = mt() % MOD1;\n            }\n \
    \           for (int i = 0; i < m; i++) {\n                b[i] = mt() % MOD1;\n\
    \            }\n            ASSERT_EQ(conv_naive<MOD1>(a, b), convolution(a, b));\n\
    \            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<998244353>(a, b)));\n\
    \        }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1;\
    \ m < 20; m++) {\n            std::vector<unsigned __int128> a(n), b(m);\n   \
    \         for (int i = 0; i < n; i++) {\n                a[i] = mt() % MOD2;\n\
    \            }\n            for (int i = 0; i < m; i++) {\n                b[i]\
    \ = mt() % MOD2;\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a, b),\
    \ (convolution<MOD2>(a, b)));\n        }\n    }\n}\n\n#endif\n\nTEST(ConvolutionTest,\
    \ ConvLL) {\n    std::mt19937 mt;\n    for (int n = 1; n < 20; n++) {\n      \
    \  for (int m = 1; m < 20; m++) {\n            std::vector<ll> a(n), b(m);\n \
    \           for (int i = 0; i < n; i++) {\n                a[i] = ll(mt() % 1'000'000)\
    \ - 500'000;\n            }\n            for (int i = 0; i < m; i++) {\n     \
    \           b[i] = ll(mt() % 1'000'000) - 500'000;\n            }\n          \
    \  ASSERT_EQ(conv_ll_naive(a, b), convolution_ll(a, b));\n        }\n    }\n}\n\
    \nTEST(ConvolutionTest, ConvLLBound) {\n    static constexpr unsigned long long\
    \ MOD1 = 469762049;  // 2^26\n    static constexpr unsigned long long MOD2 = 167772161;\
    \  // 2^25\n    static constexpr unsigned long long MOD3 = 754974721;  // 2^24\n\
    \    static constexpr unsigned long long M2M3 = MOD2 * MOD3;\n    static constexpr\
    \ unsigned long long M1M3 = MOD1 * MOD3;\n    static constexpr unsigned long long\
    \ M1M2 = MOD1 * MOD2;\n    for (int i = -1000; i <= 1000; i++) {\n        std::vector<ll>\
    \ a = {(long long)(0ULL - M1M2 - M1M3 - M2M3 + i)};\n        std::vector<ll> b\
    \ = {1};\n\n        ASSERT_EQ(a, convolution_ll(a, b));\n    }\n    for (int i\
    \ = 0; i < 1000; i++) {\n        std::vector<ll> a = {std::numeric_limits<ll>::min()\
    \ + i};\n        std::vector<ll> b = {1};\n\n        ASSERT_EQ(a, convolution_ll(a,\
    \ b));\n    }\n    for (int i = 0; i < 1000; i++) {\n        std::vector<ll> a\
    \ = {std::numeric_limits<ll>::max() - i};\n        std::vector<ll> b = {1};\n\n\
    \        ASSERT_EQ(a, convolution_ll(a, b));\n    }\n}\n\n// https://github.com/atcoder/ac-library/issues/30\n\
    TEST(ConvolutionTest, Conv641) {\n    // 641 = 128 * 5 + 1\n    const int MOD\
    \ = 641;\n    std::vector<ll> a(64), b(65);\n    for (int i = 0; i < 64; i++)\
    \ {\n        a[i] = randint(0, MOD - 1);\n    }\n    for (int i = 0; i < 65; i++)\
    \ {\n        b[i] = randint(0, MOD - 1);\n    }\n\n    ASSERT_EQ(conv_naive<MOD>(a,\
    \ b), convolution<MOD>(a, b));\n}\n\n// https://github.com/atcoder/ac-library/issues/30\n\
    TEST(ConvolutionTest, Conv18433) {\n    // 18433 = 2048 * 9 + 1\n    const int\
    \ MOD = 18433;\n    std::vector<ll> a(1024), b(1025);\n    for (int i = 0; i <\
    \ 1024; i++) {\n        a[i] = randint(0, MOD - 1);\n    }\n    for (int i = 0;\
    \ i < 1025; i++) {\n        b[i] = randint(0, MOD - 1);\n    }\n\n    ASSERT_EQ(conv_naive<MOD>(a,\
    \ b), convolution<MOD>(a, b));\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/convolution>\n#include <atcoder/modint>\n\
    #include <random>\n#include \"../utils/random.hpp\"\n\nusing namespace atcoder;\n\
    using uint = unsigned int;\nusing ll = long long;\nusing ull = unsigned long long;\n\
    \nstd::vector<ll> conv_ll_naive(std::vector<ll> a, std::vector<ll> b) {\n    int\
    \ n = int(a.size()), m = int(b.size());\n    std::vector<ll> c(n + m - 1);\n \
    \   for (int i = 0; i < n; i++) {\n        for (int j = 0; j < m; j++) {\n   \
    \         c[i + j] += a[i] * b[j];\n        }\n    }\n    return c;\n}\n\ntemplate\
    \ <class mint, internal::is_static_modint_t<mint>* = nullptr>\nstd::vector<mint>\
    \ conv_naive(std::vector<mint> a, std::vector<mint> b) {\n    int n = int(a.size()),\
    \ m = int(b.size());\n    std::vector<mint> c(n + m - 1);\n    for (int i = 0;\
    \ i < n; i++) {\n        for (int j = 0; j < m; j++) {\n            c[i + j] +=\
    \ a[i] * b[j];\n        }\n    }\n    return c;\n}\n\ntemplate <int MOD,\n   \
    \       class T,\n          std::enable_if_t<internal::is_integral<T>::value>*\
    \ = nullptr>\nstd::vector<T> conv_naive(std::vector<T> a, std::vector<T> b) {\n\
    \    int n = int(a.size()), m = int(b.size());\n    std::vector<T> c(n + m - 1);\n\
    \    for (int i = 0; i < n; i++) {\n        for (int j = 0; j < m; j++) {\n  \
    \          c[i + j] += (T)((ll)a[i] * (ll)b[j] % MOD);\n            if (c[i +\
    \ j] >= MOD) c[i + j] -= MOD;\n        }\n    }\n    return c;\n}\n\nTEST(ConvolutionTest,\
    \ Empty) {\n    ASSERT_EQ(std::vector<int>{},\n              convolution(std::vector<int>{},\
    \ std::vector<int>{}));\n    ASSERT_EQ(std::vector<int>{},\n              convolution(std::vector<int>{},\
    \ std::vector<int>{1, 2}));\n    ASSERT_EQ(std::vector<int>{},\n             \
    \ convolution(std::vector<int>{1, 2}, std::vector<int>{}));\n    ASSERT_EQ(std::vector<int>{},\n\
    \              convolution(std::vector<int>{1}, std::vector<int>{}));\n    ASSERT_EQ(std::vector<ll>{},\n\
    \              convolution(std::vector<ll>{}, std::vector<ll>{}));\n    ASSERT_EQ(std::vector<ll>{},\n\
    \              convolution(std::vector<ll>{}, std::vector<ll>{1, 2}));\n\n   \
    \ ASSERT_EQ(std::vector<modint998244353>{},\n              convolution(std::vector<modint998244353>{},\n\
    \                          std::vector<modint998244353>{}));\n    ASSERT_EQ(std::vector<modint998244353>{},\n\
    \              convolution(std::vector<modint998244353>{},\n                 \
    \         std::vector<modint998244353>{1, 2}));\n}\n\nTEST(ConvolutionTest, Mid)\
    \ {\n    std::mt19937 mt;\n    int n = 1234, m = 2345;\n    std::vector<modint998244353>\
    \ a(n), b(m);\n    \n    for (int i = 0; i < n; i++) {\n        a[i] = mt();\n\
    \    }\n    for (int i = 0; i < m; i++) {\n        b[i] = mt();\n    }\n    ASSERT_EQ(conv_naive(a,\
    \ b), convolution(a, b));\n}\n\nTEST(ConvolutionTest, SimpleSMod) {\n    const\
    \ int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n    using s_mint1 =\
    \ static_modint<MOD1>;\n    using s_mint2 = static_modint<MOD2>;\n\n    std::mt19937\
    \ mt;\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1; m < 20; m++)\
    \ {\n            std::vector<s_mint1> a(n), b(m);\n            for (int i = 0;\
    \ i < n; i++) {\n                a[i] = mt();\n            }\n            for\
    \ (int i = 0; i < m; i++) {\n                b[i] = mt();\n            }\n   \
    \         ASSERT_EQ(conv_naive(a, b), convolution(a, b));\n        }\n    }\n\
    \    for (int n = 1; n < 20; n++) {\n        for (int m = 1; m < 20; m++) {\n\
    \            std::vector<s_mint2> a(n), b(m);\n            for (int i = 0; i <\
    \ n; i++) {\n                a[i] = mt();\n            }\n            for (int\
    \ i = 0; i < m; i++) {\n                b[i] = mt();\n            }\n        \
    \    ASSERT_EQ(conv_naive(a, b), convolution(a, b));\n        }\n    }\n}\n\n\
    TEST(ConvolutionTest, SimpleInt) {\n    const int MOD1 = 998244353;\n    const\
    \ int MOD2 = 924844033;\n\n    std::mt19937 mt;\n    for (int n = 1; n < 20; n++)\
    \ {\n        for (int m = 1; m < 20; m++) {\n            std::vector<int> a(n),\
    \ b(m);\n            for (int i = 0; i < n; i++) {\n                a[i] = int(mt()\
    \ % MOD1);\n            }\n            for (int i = 0; i < m; i++) {\n       \
    \         b[i] = int(mt() % MOD1);\n            }\n            ASSERT_EQ(conv_naive<MOD1>(a,\
    \ b), convolution(a, b));\n            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<MOD1>(a,\
    \ b)));\n        }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int\
    \ m = 1; m < 20; m++) {\n            std::vector<int> a(n), b(m);\n          \
    \  for (int i = 0; i < n; i++) {\n                a[i] = int(mt() % MOD2);\n \
    \           }\n            for (int i = 0; i < m; i++) {\n                b[i]\
    \ = int(mt() % MOD2);\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a,\
    \ b), (convolution<MOD2>(a, b)));\n        }\n    }\n}\n\nTEST(ConvolutionTest,\
    \ SimpleUint) {\n    const int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n\
    \n    std::mt19937 mt;\n    for (int n = 1; n < 20; n++) {\n        for (int m\
    \ = 1; m < 20; m++) {\n            std::vector<uint> a(n), b(m);\n           \
    \ for (int i = 0; i < n; i++) {\n                a[i] = uint(mt() % MOD1);\n \
    \           }\n            for (int i = 0; i < m; i++) {\n                b[i]\
    \ = uint(mt() % MOD1);\n            }\n            ASSERT_EQ(conv_naive<MOD1>(a,\
    \ b), convolution(a, b));\n            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<MOD1>(a,\
    \ b)));\n        }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int\
    \ m = 1; m < 20; m++) {\n            std::vector<uint> a(n), b(m);\n         \
    \   for (int i = 0; i < n; i++) {\n                a[i] = uint(mt() % MOD2);\n\
    \            }\n            for (int i = 0; i < m; i++) {\n                b[i]\
    \ = uint(mt() % MOD2);\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a,\
    \ b), (convolution<MOD2>(a, b)));\n        }\n    }\n}\n\nTEST(ConvolutionTest,\
    \ SimpleLL) {\n    const int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n\
    \n    std::mt19937 mt;\n    for (int n = 1; n < 20; n++) {\n        for (int m\
    \ = 1; m < 20; m++) {\n            std::vector<ll> a(n), b(m);\n            for\
    \ (int i = 0; i < n; i++) {\n                a[i] = ll(mt() % MOD1);\n       \
    \     }\n            for (int i = 0; i < m; i++) {\n                b[i] = ll(mt()\
    \ % MOD1);\n            }\n            ASSERT_EQ(conv_naive<MOD1>(a, b), convolution(a,\
    \ b));\n            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<998244353>(a,\
    \ b)));\n        }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int\
    \ m = 1; m < 20; m++) {\n            std::vector<ll> a(n), b(m);\n           \
    \ for (int i = 0; i < n; i++) {\n                a[i] = ll(mt() % MOD2);\n   \
    \         }\n            for (int i = 0; i < m; i++) {\n                b[i] =\
    \ ll(mt() % MOD2);\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a, b),\
    \ (convolution<MOD2>(a, b)));\n        }\n    }\n}\n\nTEST(ConvolutionTest, SimpleULL)\
    \ {\n    const int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n\n    std::mt19937\
    \ mt;\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1; m < 20; m++)\
    \ {\n            std::vector<ull> a(n), b(m);\n            for (int i = 0; i <\
    \ n; i++) {\n                a[i] = ull(mt() % MOD1);\n            }\n       \
    \     for (int i = 0; i < m; i++) {\n                b[i] = ull(mt() % MOD1);\n\
    \            }\n            ASSERT_EQ(conv_naive<MOD1>(a, b), convolution(a, b));\n\
    \            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<MOD1>(a, b)));\n \
    \       }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1;\
    \ m < 20; m++) {\n            std::vector<ull> a(n), b(m);\n            for (int\
    \ i = 0; i < n; i++) {\n                a[i] = ull(mt() % MOD2);\n           \
    \ }\n            for (int i = 0; i < m; i++) {\n                b[i] = ull(mt()\
    \ % MOD2);\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a, b), (convolution<MOD2>(a,\
    \ b)));\n        }\n    }\n}\n\n#ifndef _MSC_VER\nTEST(ConvolutionTest, SimpleInt128)\
    \ {\n    const int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n\n    std::mt19937\
    \ mt;\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1; m < 20; m++)\
    \ {\n            std::vector<__int128> a(n), b(m);\n            for (int i = 0;\
    \ i < n; i++) {\n                a[i] = mt() % MOD1;\n            }\n        \
    \    for (int i = 0; i < m; i++) {\n                b[i] = mt() % MOD1;\n    \
    \        }\n            ASSERT_EQ(conv_naive<MOD1>(a, b), convolution(a, b));\n\
    \            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<MOD1>(a, b)));\n \
    \       }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1;\
    \ m < 20; m++) {\n            std::vector<__int128> a(n), b(m);\n            for\
    \ (int i = 0; i < n; i++) {\n                a[i] = mt() % MOD2;\n           \
    \ }\n            for (int i = 0; i < m; i++) {\n                b[i] = mt() %\
    \ MOD2;\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a, b), (convolution<MOD2>(a,\
    \ b)));\n        }\n    }\n}\n\nTEST(ConvolutionTest, SimpleUInt128) {\n    const\
    \ int MOD1 = 998244353;\n    const int MOD2 = 924844033;\n\n    std::mt19937 mt;\n\
    \    for (int n = 1; n < 20; n++) {\n        for (int m = 1; m < 20; m++) {\n\
    \            std::vector<unsigned __int128> a(n), b(m);\n            for (int\
    \ i = 0; i < n; i++) {\n                a[i] = mt() % MOD1;\n            }\n \
    \           for (int i = 0; i < m; i++) {\n                b[i] = mt() % MOD1;\n\
    \            }\n            ASSERT_EQ(conv_naive<MOD1>(a, b), convolution(a, b));\n\
    \            ASSERT_EQ(conv_naive<MOD1>(a, b), (convolution<998244353>(a, b)));\n\
    \        }\n    }\n    for (int n = 1; n < 20; n++) {\n        for (int m = 1;\
    \ m < 20; m++) {\n            std::vector<unsigned __int128> a(n), b(m);\n   \
    \         for (int i = 0; i < n; i++) {\n                a[i] = mt() % MOD2;\n\
    \            }\n            for (int i = 0; i < m; i++) {\n                b[i]\
    \ = mt() % MOD2;\n            }\n            ASSERT_EQ(conv_naive<MOD2>(a, b),\
    \ (convolution<MOD2>(a, b)));\n        }\n    }\n}\n\n#endif\n\nTEST(ConvolutionTest,\
    \ ConvLL) {\n    std::mt19937 mt;\n    for (int n = 1; n < 20; n++) {\n      \
    \  for (int m = 1; m < 20; m++) {\n            std::vector<ll> a(n), b(m);\n \
    \           for (int i = 0; i < n; i++) {\n                a[i] = ll(mt() % 1'000'000)\
    \ - 500'000;\n            }\n            for (int i = 0; i < m; i++) {\n     \
    \           b[i] = ll(mt() % 1'000'000) - 500'000;\n            }\n          \
    \  ASSERT_EQ(conv_ll_naive(a, b), convolution_ll(a, b));\n        }\n    }\n}\n\
    \nTEST(ConvolutionTest, ConvLLBound) {\n    static constexpr unsigned long long\
    \ MOD1 = 469762049;  // 2^26\n    static constexpr unsigned long long MOD2 = 167772161;\
    \  // 2^25\n    static constexpr unsigned long long MOD3 = 754974721;  // 2^24\n\
    \    static constexpr unsigned long long M2M3 = MOD2 * MOD3;\n    static constexpr\
    \ unsigned long long M1M3 = MOD1 * MOD3;\n    static constexpr unsigned long long\
    \ M1M2 = MOD1 * MOD2;\n    for (int i = -1000; i <= 1000; i++) {\n        std::vector<ll>\
    \ a = {(long long)(0ULL - M1M2 - M1M3 - M2M3 + i)};\n        std::vector<ll> b\
    \ = {1};\n\n        ASSERT_EQ(a, convolution_ll(a, b));\n    }\n    for (int i\
    \ = 0; i < 1000; i++) {\n        std::vector<ll> a = {std::numeric_limits<ll>::min()\
    \ + i};\n        std::vector<ll> b = {1};\n\n        ASSERT_EQ(a, convolution_ll(a,\
    \ b));\n    }\n    for (int i = 0; i < 1000; i++) {\n        std::vector<ll> a\
    \ = {std::numeric_limits<ll>::max() - i};\n        std::vector<ll> b = {1};\n\n\
    \        ASSERT_EQ(a, convolution_ll(a, b));\n    }\n}\n\n// https://github.com/atcoder/ac-library/issues/30\n\
    TEST(ConvolutionTest, Conv641) {\n    // 641 = 128 * 5 + 1\n    const int MOD\
    \ = 641;\n    std::vector<ll> a(64), b(65);\n    for (int i = 0; i < 64; i++)\
    \ {\n        a[i] = randint(0, MOD - 1);\n    }\n    for (int i = 0; i < 65; i++)\
    \ {\n        b[i] = randint(0, MOD - 1);\n    }\n\n    ASSERT_EQ(conv_naive<MOD>(a,\
    \ b), convolution<MOD>(a, b));\n}\n\n// https://github.com/atcoder/ac-library/issues/30\n\
    TEST(ConvolutionTest, Conv18433) {\n    // 18433 = 2048 * 9 + 1\n    const int\
    \ MOD = 18433;\n    std::vector<ll> a(1024), b(1025);\n    for (int i = 0; i <\
    \ 1024; i++) {\n        a[i] = randint(0, MOD - 1);\n    }\n    for (int i = 0;\
    \ i < 1025; i++) {\n        b[i] = randint(0, MOD - 1);\n    }\n\n    ASSERT_EQ(conv_naive<MOD>(a,\
    \ b), convolution<MOD>(a, b));\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/convolution_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/convolution_test.cpp
layout: document
redirect_from:
- /library/test/unittest/convolution_test.cpp
- /library/test/unittest/convolution_test.cpp.html
title: test/unittest/convolution_test.cpp
---
