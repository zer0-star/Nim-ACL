---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/internal_math_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/internal_math>\n#include <numeric>\n#line 2 \"test/utils/math.hpp\"\
    \n#include <atcoder/math>\n#include <vector>\n\nstd::vector<int> factors(int m)\
    \ {\n    std::vector<int> result;\n    for (int i = 2; (long long)(i)*i <= m;\
    \ i++) {\n        if (m % i == 0) {\n            result.push_back(i);\n      \
    \      while (m % i == 0) {\n                m /= i;\n            }\n        }\n\
    \    }\n    if (m > 1) result.push_back(m);\n    return result;\n}\n\nbool is_primitive_root(int\
    \ m, int g) {\n    assert(1 <= g && g < m);\n    auto prs = factors(m - 1);\n\
    \    for (int x : factors(m - 1)) {\n        if (atcoder::internal::pow_mod_constexpr(g,\
    \ (m - 1) / x, m) == 1) return false;\n    }\n    return true;\n}\n#line 6 \"\
    test/unittest/internal_math_test.cpp\"\n\nusing namespace atcoder;\nusing uint\
    \ = unsigned int;\nusing ll = long long;\nusing ull = unsigned long long;\n\n\
    ll gcd(ll a, ll b) {\n    assert(0 <= a && 0 <= b);\n    if (b == 0) return a;\n\
    \    return gcd(b, a % b);\n}\n\nll pow_mod_naive(ll x, ull n, uint mod) {\n \
    \   ull y = (x % mod + mod) % mod;\n    ull z = 1;\n    for (ull i = 0; i < n;\
    \ i++) {\n        z = (z * y) % mod;\n    }\n    return z % mod;\n}\n\nll floor_sum_naive(ll\
    \ n, ll m, ll a, ll b) {\n    ll sum = 0;\n    for (ll i = 0; i < n; i++) {\n\
    \        sum += (a * i + b) / m;\n    }\n    return sum;\n}\n\nbool is_prime_naive(ll\
    \ n) {\n    assert(0 <= n && n <= std::numeric_limits<int>::max());\n    if (n\
    \ == 0 || n == 1) return false;\n    for (ll i = 2; i * i <= n; i++) {\n     \
    \   if (n % i == 0) return false;\n    }\n    return true;\n}\n\nTEST(InternalMathTest,\
    \ Barrett) {\n    for (int m = 1; m <= 100; m++) {\n        internal::barrett\
    \ bt(m);\n        for (int a = 0; a < m; a++) {\n            for (int b = 0; b\
    \ < m; b++) {\n                ASSERT_EQ((a * b) % m, bt.mul(a, b));\n       \
    \     }\n        }\n    }\n\n    internal::barrett bt(1);\n    ASSERT_EQ(0, bt.mul(0,\
    \ 0));\n}\n\nTEST(InternalMathTest, BarrettBorder) {\n    const int mod_upper\
    \ = std::numeric_limits<int>::max();\n    for (unsigned int mod = mod_upper; mod\
    \ >= mod_upper - 20; mod--) {\n        internal::barrett bt(mod);\n        std::vector<unsigned\
    \ int> v;\n        for (int i = 0; i < 10; i++) {\n            v.push_back(i);\n\
    \            v.push_back(mod - i);\n            v.push_back(mod / 2 + i);\n  \
    \          v.push_back(mod / 2 - i);\n        }\n        for (auto a : v) {\n\
    \            ll a2 = a;\n            ASSERT_EQ(((a2 * a2) % mod * a2) % mod, bt.mul(a,\
    \ bt.mul(a, a)));\n            for (auto b : v) {\n                ll b2 = b;\n\
    \                ASSERT_EQ((a2 * b2) % mod, bt.mul(a, b));\n            }\n  \
    \      }\n    }\n}\n\nTEST(InternalMathTest, IsPrime) {\n    ASSERT_FALSE(internal::is_prime<121>);\n\
    \    ASSERT_FALSE(internal::is_prime<11 * 13>);\n    ASSERT_TRUE(internal::is_prime<1'000'000'007>);\n\
    \    ASSERT_FALSE(internal::is_prime<1'000'000'008>);\n    ASSERT_TRUE(internal::is_prime<1'000'000'009>);\n\
    \    for (int i = 0; i <= 10000; i++) {\n        ASSERT_EQ(is_prime_naive(i),\
    \ internal::is_prime_constexpr(i));\n    }\n    for (int i = 0; i <= 10000; i++)\
    \ {\n        int x = std::numeric_limits<int>::max() - i;\n        ASSERT_EQ(is_prime_naive(x),\
    \ internal::is_prime_constexpr(x));\n    }\n}\n\n#ifndef _MSC_VER\nTEST(InternalMathTest,\
    \ SafeMod) {\n    std::vector<ll> preds;\n    for (int i = 0; i <= 100; i++) {\n\
    \        preds.push_back(i);\n        preds.push_back(-i);\n        preds.push_back(i);\n\
    \        preds.push_back(std::numeric_limits<ll>::min() + i);\n        preds.push_back(std::numeric_limits<ll>::max()\
    \ - i);\n    }\n\n    for (auto a : preds) {\n        for (auto b : preds) {\n\
    \            if (b <= 0) continue;\n            ll ans = (ll)((__int128(a) % b\
    \ + b) % b);\n            ASSERT_EQ(ans, internal::safe_mod(a, b));\n        }\n\
    \    }\n}\n#endif\n\nTEST(InternalMathTest, InvGcdBound) {\n    std::vector<ll>\
    \ pred;\n    for (int i = 0; i <= 10; i++) {\n        pred.push_back(i);\n   \
    \     pred.push_back(-i);\n        pred.push_back(std::numeric_limits<ll>::min()\
    \ + i);\n        pred.push_back(std::numeric_limits<ll>::max() - i);\n\n     \
    \   pred.push_back(std::numeric_limits<ll>::min() / 2 + i);\n        pred.push_back(std::numeric_limits<ll>::min()\
    \ / 2 - i);\n        pred.push_back(std::numeric_limits<ll>::max() / 2 + i);\n\
    \        pred.push_back(std::numeric_limits<ll>::max() / 2 - i);\n\n        pred.push_back(std::numeric_limits<ll>::min()\
    \ / 3 + i);\n        pred.push_back(std::numeric_limits<ll>::min() / 3 - i);\n\
    \        pred.push_back(std::numeric_limits<ll>::max() / 3 + i);\n        pred.push_back(std::numeric_limits<ll>::max()\
    \ / 3 - i);\n    }\n    pred.push_back(998244353);\n    pred.push_back(1'000'000'007);\n\
    \    pred.push_back(1'000'000'009);\n    pred.push_back(-998244353);\n    pred.push_back(-1'000'000'007);\n\
    \    pred.push_back(-1'000'000'009);\n\n    for (auto a : pred) {\n        for\
    \ (auto b : pred) {\n            if (b <= 0) continue;\n            ll a2 = internal::safe_mod(a,\
    \ b);\n            auto eg = internal::inv_gcd(a, b);\n            auto g = gcd(a2,\
    \ b);\n            ASSERT_EQ(g, eg.first);\n            ASSERT_LE(0, eg.second);\n\
    \            ASSERT_LE(eg.second, b / eg.first);\n#ifndef _MSC_VER\n         \
    \   ASSERT_EQ(g % b, (unsigned __int128)(eg.second) * a2 % b);\n#endif\n     \
    \   }\n    }\n}\n\nTEST(InternalMathTest, PrimitiveRootTestNaive) {\n    for (int\
    \ m = 2; m <= 10000; m++) {\n        if (!internal::is_prime_constexpr(m)) continue;\n\
    \        int n = internal::primitive_root_constexpr(m);\n        ASSERT_LE(1,\
    \ n);\n        ASSERT_LT(n, m);\n        int x = 1;\n        for (int i = 1; i\
    \ <= m - 2; i++) {\n            x = (int)((long long)(x)*n % m);\n           \
    \ // x == n^i\n            ASSERT_NE(1, x);\n        }\n        x = (int)((long\
    \ long)(x)*n % m);\n        ASSERT_EQ(1, x);\n    }\n}\n\nTEST(InternalMathTest,\
    \ PrimitiveRootTemplateTest) {\n    ASSERT_TRUE(is_primitive_root(2, (internal::primitive_root<2>)));\n\
    \    ASSERT_TRUE(is_primitive_root(3, (internal::primitive_root<3>)));\n    ASSERT_TRUE(is_primitive_root(5,\
    \ (internal::primitive_root<5>)));\n    ASSERT_TRUE(is_primitive_root(7, (internal::primitive_root<7>)));\n\
    \    ASSERT_TRUE(is_primitive_root(11, (internal::primitive_root<11>)));\n   \
    \ ASSERT_TRUE(\n        is_primitive_root(998244353, (internal::primitive_root<998244353>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(1000000007, (internal::primitive_root<1000000007>)));\n\
    \n    ASSERT_TRUE(\n        is_primitive_root(469762049, (internal::primitive_root<469762049>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(167772161, (internal::primitive_root<167772161>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(754974721, (internal::primitive_root<754974721>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(324013369, (internal::primitive_root<324013369>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(831143041, (internal::primitive_root<831143041>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(1685283601, (internal::primitive_root<1685283601>)));\n\
    }\n\nTEST(InternalMathTest, PrimitiveRootTest) {\n    for (int i = 0; i < 1000;\
    \ i++) {\n        int x = std::numeric_limits<int>::max() - i;\n        if (!internal::is_prime_constexpr(x))\
    \ continue;\n        ASSERT_TRUE(\n            is_primitive_root(x, (internal::primitive_root_constexpr(x))));\n\
    \    }\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/internal_math>\n#include <numeric>\n\
    #include \"../utils/math.hpp\"\n\nusing namespace atcoder;\nusing uint = unsigned\
    \ int;\nusing ll = long long;\nusing ull = unsigned long long;\n\nll gcd(ll a,\
    \ ll b) {\n    assert(0 <= a && 0 <= b);\n    if (b == 0) return a;\n    return\
    \ gcd(b, a % b);\n}\n\nll pow_mod_naive(ll x, ull n, uint mod) {\n    ull y =\
    \ (x % mod + mod) % mod;\n    ull z = 1;\n    for (ull i = 0; i < n; i++) {\n\
    \        z = (z * y) % mod;\n    }\n    return z % mod;\n}\n\nll floor_sum_naive(ll\
    \ n, ll m, ll a, ll b) {\n    ll sum = 0;\n    for (ll i = 0; i < n; i++) {\n\
    \        sum += (a * i + b) / m;\n    }\n    return sum;\n}\n\nbool is_prime_naive(ll\
    \ n) {\n    assert(0 <= n && n <= std::numeric_limits<int>::max());\n    if (n\
    \ == 0 || n == 1) return false;\n    for (ll i = 2; i * i <= n; i++) {\n     \
    \   if (n % i == 0) return false;\n    }\n    return true;\n}\n\nTEST(InternalMathTest,\
    \ Barrett) {\n    for (int m = 1; m <= 100; m++) {\n        internal::barrett\
    \ bt(m);\n        for (int a = 0; a < m; a++) {\n            for (int b = 0; b\
    \ < m; b++) {\n                ASSERT_EQ((a * b) % m, bt.mul(a, b));\n       \
    \     }\n        }\n    }\n\n    internal::barrett bt(1);\n    ASSERT_EQ(0, bt.mul(0,\
    \ 0));\n}\n\nTEST(InternalMathTest, BarrettBorder) {\n    const int mod_upper\
    \ = std::numeric_limits<int>::max();\n    for (unsigned int mod = mod_upper; mod\
    \ >= mod_upper - 20; mod--) {\n        internal::barrett bt(mod);\n        std::vector<unsigned\
    \ int> v;\n        for (int i = 0; i < 10; i++) {\n            v.push_back(i);\n\
    \            v.push_back(mod - i);\n            v.push_back(mod / 2 + i);\n  \
    \          v.push_back(mod / 2 - i);\n        }\n        for (auto a : v) {\n\
    \            ll a2 = a;\n            ASSERT_EQ(((a2 * a2) % mod * a2) % mod, bt.mul(a,\
    \ bt.mul(a, a)));\n            for (auto b : v) {\n                ll b2 = b;\n\
    \                ASSERT_EQ((a2 * b2) % mod, bt.mul(a, b));\n            }\n  \
    \      }\n    }\n}\n\nTEST(InternalMathTest, IsPrime) {\n    ASSERT_FALSE(internal::is_prime<121>);\n\
    \    ASSERT_FALSE(internal::is_prime<11 * 13>);\n    ASSERT_TRUE(internal::is_prime<1'000'000'007>);\n\
    \    ASSERT_FALSE(internal::is_prime<1'000'000'008>);\n    ASSERT_TRUE(internal::is_prime<1'000'000'009>);\n\
    \    for (int i = 0; i <= 10000; i++) {\n        ASSERT_EQ(is_prime_naive(i),\
    \ internal::is_prime_constexpr(i));\n    }\n    for (int i = 0; i <= 10000; i++)\
    \ {\n        int x = std::numeric_limits<int>::max() - i;\n        ASSERT_EQ(is_prime_naive(x),\
    \ internal::is_prime_constexpr(x));\n    }\n}\n\n#ifndef _MSC_VER\nTEST(InternalMathTest,\
    \ SafeMod) {\n    std::vector<ll> preds;\n    for (int i = 0; i <= 100; i++) {\n\
    \        preds.push_back(i);\n        preds.push_back(-i);\n        preds.push_back(i);\n\
    \        preds.push_back(std::numeric_limits<ll>::min() + i);\n        preds.push_back(std::numeric_limits<ll>::max()\
    \ - i);\n    }\n\n    for (auto a : preds) {\n        for (auto b : preds) {\n\
    \            if (b <= 0) continue;\n            ll ans = (ll)((__int128(a) % b\
    \ + b) % b);\n            ASSERT_EQ(ans, internal::safe_mod(a, b));\n        }\n\
    \    }\n}\n#endif\n\nTEST(InternalMathTest, InvGcdBound) {\n    std::vector<ll>\
    \ pred;\n    for (int i = 0; i <= 10; i++) {\n        pred.push_back(i);\n   \
    \     pred.push_back(-i);\n        pred.push_back(std::numeric_limits<ll>::min()\
    \ + i);\n        pred.push_back(std::numeric_limits<ll>::max() - i);\n\n     \
    \   pred.push_back(std::numeric_limits<ll>::min() / 2 + i);\n        pred.push_back(std::numeric_limits<ll>::min()\
    \ / 2 - i);\n        pred.push_back(std::numeric_limits<ll>::max() / 2 + i);\n\
    \        pred.push_back(std::numeric_limits<ll>::max() / 2 - i);\n\n        pred.push_back(std::numeric_limits<ll>::min()\
    \ / 3 + i);\n        pred.push_back(std::numeric_limits<ll>::min() / 3 - i);\n\
    \        pred.push_back(std::numeric_limits<ll>::max() / 3 + i);\n        pred.push_back(std::numeric_limits<ll>::max()\
    \ / 3 - i);\n    }\n    pred.push_back(998244353);\n    pred.push_back(1'000'000'007);\n\
    \    pred.push_back(1'000'000'009);\n    pred.push_back(-998244353);\n    pred.push_back(-1'000'000'007);\n\
    \    pred.push_back(-1'000'000'009);\n\n    for (auto a : pred) {\n        for\
    \ (auto b : pred) {\n            if (b <= 0) continue;\n            ll a2 = internal::safe_mod(a,\
    \ b);\n            auto eg = internal::inv_gcd(a, b);\n            auto g = gcd(a2,\
    \ b);\n            ASSERT_EQ(g, eg.first);\n            ASSERT_LE(0, eg.second);\n\
    \            ASSERT_LE(eg.second, b / eg.first);\n#ifndef _MSC_VER\n         \
    \   ASSERT_EQ(g % b, (unsigned __int128)(eg.second) * a2 % b);\n#endif\n     \
    \   }\n    }\n}\n\nTEST(InternalMathTest, PrimitiveRootTestNaive) {\n    for (int\
    \ m = 2; m <= 10000; m++) {\n        if (!internal::is_prime_constexpr(m)) continue;\n\
    \        int n = internal::primitive_root_constexpr(m);\n        ASSERT_LE(1,\
    \ n);\n        ASSERT_LT(n, m);\n        int x = 1;\n        for (int i = 1; i\
    \ <= m - 2; i++) {\n            x = (int)((long long)(x)*n % m);\n           \
    \ // x == n^i\n            ASSERT_NE(1, x);\n        }\n        x = (int)((long\
    \ long)(x)*n % m);\n        ASSERT_EQ(1, x);\n    }\n}\n\nTEST(InternalMathTest,\
    \ PrimitiveRootTemplateTest) {\n    ASSERT_TRUE(is_primitive_root(2, (internal::primitive_root<2>)));\n\
    \    ASSERT_TRUE(is_primitive_root(3, (internal::primitive_root<3>)));\n    ASSERT_TRUE(is_primitive_root(5,\
    \ (internal::primitive_root<5>)));\n    ASSERT_TRUE(is_primitive_root(7, (internal::primitive_root<7>)));\n\
    \    ASSERT_TRUE(is_primitive_root(11, (internal::primitive_root<11>)));\n   \
    \ ASSERT_TRUE(\n        is_primitive_root(998244353, (internal::primitive_root<998244353>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(1000000007, (internal::primitive_root<1000000007>)));\n\
    \n    ASSERT_TRUE(\n        is_primitive_root(469762049, (internal::primitive_root<469762049>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(167772161, (internal::primitive_root<167772161>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(754974721, (internal::primitive_root<754974721>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(324013369, (internal::primitive_root<324013369>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(831143041, (internal::primitive_root<831143041>)));\n\
    \    ASSERT_TRUE(\n        is_primitive_root(1685283601, (internal::primitive_root<1685283601>)));\n\
    }\n\nTEST(InternalMathTest, PrimitiveRootTest) {\n    for (int i = 0; i < 1000;\
    \ i++) {\n        int x = std::numeric_limits<int>::max() - i;\n        if (!internal::is_prime_constexpr(x))\
    \ continue;\n        ASSERT_TRUE(\n            is_primitive_root(x, (internal::primitive_root_constexpr(x))));\n\
    \    }\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/internal_math_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/internal_math_test.cpp
layout: document
redirect_from:
- /library/test/unittest/internal_math_test.cpp
- /library/test/unittest/internal_math_test.cpp.html
title: test/unittest/internal_math_test.cpp
---
