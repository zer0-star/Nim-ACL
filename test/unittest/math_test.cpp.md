---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/math_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/math>\n#include <numeric>\n\nusing namespace atcoder;\nusing\
    \ uint = unsigned int;\nusing ll = long long;\nusing ull = unsigned long long;\n\
    \nll gcd(ll a, ll b) {\n    assert(0 <= a && 0 <= b);\n    if (b == 0) return\
    \ a;\n    return gcd(b, a % b);\n}\n\nll pow_mod_naive(ll x, ull n, uint mod)\
    \ {\n    ull y = (x % mod + mod) % mod;\n    ull z = 1;\n    for (ull i = 0; i\
    \ < n; i++) {\n        z = (z * y) % mod;\n    }\n    return z % mod;\n}\n\nll\
    \ floor_sum_naive(ll n, ll m, ll a, ll b) {\n    ll sum = 0;\n    for (ll i =\
    \ 0; i < n; i++) {\n        sum += (a * i + b) / m;\n    }\n    return sum;\n\
    }\n\nbool is_prime_naive(ll n) {\n    assert(0 <= n && n <= std::numeric_limits<int>::max());\n\
    \    if (n == 0 || n == 1) return false;\n    for (ll i = 2; i * i <= n; i++)\
    \ {\n        if (n % i == 0) return false;\n    }\n    return true;\n}\n\nTEST(MathTest,\
    \ PowMod) {\n    auto naive = [&](ll x, ll n, int mod) {\n        ll y = internal::safe_mod(x,\
    \ mod);\n        ull z = 1 % mod;\n        for (ll i = 0; i < n; i++) {\n    \
    \        z = (z * y) % mod;\n        }\n        return z;\n    };\n    for (int\
    \ a = -100; a <= 100; a++) {\n        for (int b = 0; b <= 100; b++) {\n     \
    \       for (int c = 1; c <= 100; c++) {\n                ASSERT_EQ(naive(a, b,\
    \ c), pow_mod(a, b, c));\n            }\n        }\n    }\n}\n\nTEST(MathTest,\
    \ InvBoundHand) {\n    const ll minll = std::numeric_limits<ll>::min();\n    const\
    \ ll maxll = std::numeric_limits<ll>::max();\n    ASSERT_EQ(inv_mod(-1, maxll),\
    \ inv_mod(minll, maxll));\n    ASSERT_EQ(1, inv_mod(maxll, maxll - 1));\n    ASSERT_EQ(maxll\
    \ - 1, inv_mod(maxll - 1, maxll));\n    ASSERT_EQ(2, inv_mod(maxll / 2 + 1, maxll));\n\
    }\n\nTEST(MathTest, InvMod) {\n    for (int a = -100; a <= 100; a++) {\n     \
    \   for (int b = 1; b <= 1000; b++) {            \n            if (gcd(internal::safe_mod(a,\
    \ b), b) != 1) continue;\n            ll c = inv_mod(a, b);\n            ASSERT_LE(0,\
    \ c);\n            ASSERT_LT(c, b);\n            ASSERT_EQ(1 % b, ((a * c) % b\
    \ + b) % b);\n        }\n    }\n}\n\nTEST(MathTest, InvModZero) {\n    ASSERT_EQ(0,\
    \ inv_mod(0, 1));\n    for (int i = 0; i < 10; i++) {\n        ASSERT_EQ(0, inv_mod(i,\
    \ 1));\n        ASSERT_EQ(0, inv_mod(-i, 1));\n        ASSERT_EQ(0, inv_mod(std::numeric_limits<ll>::min()\
    \ + i, 1));\n        ASSERT_EQ(0, inv_mod(std::numeric_limits<ll>::max() - i,\
    \ 1));\n    }\n}\n\nTEST(MathTest, FloorSum) {\n    for (int n = 0; n < 20; n++)\
    \ {\n        for (int m = 1; m < 20; m++) {\n            for (int a = 0; a < 20;\
    \ a++) {\n                for (int b = 0; b < 20; b++) {\n                   \
    \ ASSERT_EQ(floor_sum_naive(n, m, a, b),\n                              floor_sum(n,\
    \ m, a, b));\n                }\n            }\n        }\n    }\n}\n\nTEST(MathTest,\
    \ CRTHand) {\n    auto res = crt({1, 2, 1}, {2, 3, 2});\n    ASSERT_EQ(5, res.first);\n\
    \    ASSERT_EQ(6, res.second);\n}\n\nTEST(MathTest, CRT2) {\n    for (int a =\
    \ 1; a <= 20; a++) {\n        for (int b = 1; b <= 20; b++) {\n            for\
    \ (int c = -10; c <= 10; c++) {\n                for (int d = -10; d <= 10; d++)\
    \ {\n                    auto res = crt({c, d}, {a, b});\n                   \
    \ if (res.second == 0) {\n                        for (int x = 0; x < a * b /\
    \ gcd(a, b); x++) {\n                            ASSERT_TRUE(x % a != c || x %\
    \ b != d);\n                        }\n                        continue;\n   \
    \                 }\n                    ASSERT_EQ(a * b / gcd(a, b), res.second);\n\
    \                    ASSERT_EQ(internal::safe_mod(c, a), res.first % a);\n   \
    \                 ASSERT_EQ(internal::safe_mod(d, b), res.first % b);\n      \
    \          }\n            }\n        }\n    }\n}\n\nTEST(MathTest, CRT3) {\n \
    \   for (int a = 1; a <= 5; a++) {\n        for (int b = 1; b <= 5; b++) {\n \
    \           for (int c = 1; c <= 5; c++) {\n                for (int d = -5; d\
    \ <= 5; d++) {\n                    for (int e = -5; e <= 5; e++) {\n        \
    \                for (int f = -5; f <= 5; f++) {\n                           \
    \ auto res = crt({d, e, f}, {a, b, c});\n                            ll lcm =\
    \ a * b / gcd(a, b);\n                            lcm = lcm * c / gcd(lcm, c);\n\
    \                            if (res.second == 0) {\n                        \
    \        for (int x = 0; x < lcm; x++) {\n                                   \
    \ ASSERT_TRUE(x % a != d || x % b != e ||\n                                  \
    \              x % c != f);\n                                }\n             \
    \                   continue;\n                            }\n               \
    \             ASSERT_EQ(lcm, res.second);\n                            ASSERT_EQ(internal::safe_mod(d,\
    \ a), res.first % a);\n                            ASSERT_EQ(internal::safe_mod(e,\
    \ b), res.first % b);\n                            ASSERT_EQ(internal::safe_mod(f,\
    \ c), res.first % c);\n                        }\n                    }\n    \
    \            }\n            }\n        }\n    }\n}\n\nTEST(MathTest, CRTOverflow)\
    \ {\n    long long r0 = 0;\n    long long r1 = 1'000'000'000'000LL - 2;\n    long\
    \ long m0 = 900577;\n    long long m1 = 1'000'000'000'000LL;\n    auto res = crt({r0,\
    \ r1}, {m0, m1});\n    ASSERT_EQ(m0 * m1, res.second);\n    ASSERT_EQ(r0, res.first\
    \ % m0);\n    ASSERT_EQ(r1, res.first % m1);\n}\n\nTEST(MathTest, CRTBound) {\n\
    \    const ll INF = std::numeric_limits<ll>::max();\n    std::vector<ll> pred;\n\
    \    for (int i = 1; i <= 10; i++) {\n        pred.push_back(i);\n        pred.push_back(INF\
    \ - (i - 1));\n    }\n    pred.push_back(998244353);\n    pred.push_back(1'000'000'007);\n\
    \    pred.push_back(1'000'000'009);\n\n    for (auto ab : std::vector<std::pair<ll,\
    \ ll>>{{INF, INF},\n                                                  {1, INF},\n\
    \                                                  {INF, 1},\n               \
    \                                   {7, INF},\n                              \
    \                    {INF / 337, 337},\n                                     \
    \             {2, (INF - 1) / 2}}) {\n        ll a = ab.first;\n        ll b =\
    \ ab.second;\n        for (int ph = 0; ph < 2; ph++) {\n            for (ll ans\
    \ : pred) {\n                auto res = crt({ans % a, ans % b}, {a, b});\n   \
    \             ll lcm = a / gcd(a, b) * b;\n                ASSERT_EQ(lcm, res.second);\n\
    \                ASSERT_EQ(ans % lcm, res.first);\n            }\n           \
    \ std::swap(a, b);\n        }\n    }\n    std::vector<ll> factor_inf = {49, 73,\
    \ 127, 337, 92737, 649657};\n    do {\n        for (ll ans : pred) {\n       \
    \     std::vector<ll> r, m;\n            for (ll f : factor_inf) {\n         \
    \       r.push_back(ans % f);\n                m.push_back(f);\n            }\n\
    \            auto res = crt(r, m);\n            ASSERT_EQ(ans % INF, res.first);\n\
    \            ASSERT_EQ(INF, res.second);\n        }\n    } while (next_permutation(factor_inf.begin(),\
    \ factor_inf.end()));\n    std::vector<ll> factor_infn1 = {2, 3, 715827883, 2147483647};\n\
    \    do {\n        for (ll ans : pred) {\n            std::vector<ll> r, m;\n\
    \            for (ll f : factor_infn1) {\n                r.push_back(ans % f);\n\
    \                m.push_back(f);\n            }\n            auto res = crt(r,\
    \ m);\n            ASSERT_EQ(ans % (INF - 1), res.first);\n            ASSERT_EQ(INF\
    \ - 1, res.second);\n        }\n    } while (next_permutation(factor_infn1.begin(),\
    \ factor_infn1.end()));\n}\n\nstd::vector<int> factors(int m) {\n    std::vector<int>\
    \ result;\n    for (int i = 2; (ll)(i)*i <= m; i++) {\n        if (m % i == 0)\
    \ {\n            result.push_back(i);\n            while (m % i == 0) {\n    \
    \            m /= i;\n            }\n        }\n    }\n    if (m > 1) result.push_back(m);\n\
    \    return result;\n}\n\nbool is_primitive_root(int m, int g) {\n    assert(1\
    \ <= g && g < m);\n    auto prs = factors(m - 1);\n    for (int x : factors(m\
    \ - 1)) {\n        if (internal::pow_mod_constexpr(g, (m - 1) / x, m) == 1) return\
    \ false;\n    }\n    return true;\n}\n\nbool is_primitive_root_naive(int m, int\
    \ g) {\n    assert(1 <= g && g < m);\n    auto prs = factors(m - 1);\n    int\
    \ x = 1;\n    for (int i = 1; i <= m - 2; i++) {\n        x = (int)((long long)(x)*g\
    \ % m);\n        // x == n^i\n        if (x == 1) return false;\n    }\n    x\
    \ = (int)((long long)(x)*g % m);\n    assert(x == 1);\n    return true;\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/math>\n#include <numeric>\n\
    \nusing namespace atcoder;\nusing uint = unsigned int;\nusing ll = long long;\n\
    using ull = unsigned long long;\n\nll gcd(ll a, ll b) {\n    assert(0 <= a &&\
    \ 0 <= b);\n    if (b == 0) return a;\n    return gcd(b, a % b);\n}\n\nll pow_mod_naive(ll\
    \ x, ull n, uint mod) {\n    ull y = (x % mod + mod) % mod;\n    ull z = 1;\n\
    \    for (ull i = 0; i < n; i++) {\n        z = (z * y) % mod;\n    }\n    return\
    \ z % mod;\n}\n\nll floor_sum_naive(ll n, ll m, ll a, ll b) {\n    ll sum = 0;\n\
    \    for (ll i = 0; i < n; i++) {\n        sum += (a * i + b) / m;\n    }\n  \
    \  return sum;\n}\n\nbool is_prime_naive(ll n) {\n    assert(0 <= n && n <= std::numeric_limits<int>::max());\n\
    \    if (n == 0 || n == 1) return false;\n    for (ll i = 2; i * i <= n; i++)\
    \ {\n        if (n % i == 0) return false;\n    }\n    return true;\n}\n\nTEST(MathTest,\
    \ PowMod) {\n    auto naive = [&](ll x, ll n, int mod) {\n        ll y = internal::safe_mod(x,\
    \ mod);\n        ull z = 1 % mod;\n        for (ll i = 0; i < n; i++) {\n    \
    \        z = (z * y) % mod;\n        }\n        return z;\n    };\n    for (int\
    \ a = -100; a <= 100; a++) {\n        for (int b = 0; b <= 100; b++) {\n     \
    \       for (int c = 1; c <= 100; c++) {\n                ASSERT_EQ(naive(a, b,\
    \ c), pow_mod(a, b, c));\n            }\n        }\n    }\n}\n\nTEST(MathTest,\
    \ InvBoundHand) {\n    const ll minll = std::numeric_limits<ll>::min();\n    const\
    \ ll maxll = std::numeric_limits<ll>::max();\n    ASSERT_EQ(inv_mod(-1, maxll),\
    \ inv_mod(minll, maxll));\n    ASSERT_EQ(1, inv_mod(maxll, maxll - 1));\n    ASSERT_EQ(maxll\
    \ - 1, inv_mod(maxll - 1, maxll));\n    ASSERT_EQ(2, inv_mod(maxll / 2 + 1, maxll));\n\
    }\n\nTEST(MathTest, InvMod) {\n    for (int a = -100; a <= 100; a++) {\n     \
    \   for (int b = 1; b <= 1000; b++) {            \n            if (gcd(internal::safe_mod(a,\
    \ b), b) != 1) continue;\n            ll c = inv_mod(a, b);\n            ASSERT_LE(0,\
    \ c);\n            ASSERT_LT(c, b);\n            ASSERT_EQ(1 % b, ((a * c) % b\
    \ + b) % b);\n        }\n    }\n}\n\nTEST(MathTest, InvModZero) {\n    ASSERT_EQ(0,\
    \ inv_mod(0, 1));\n    for (int i = 0; i < 10; i++) {\n        ASSERT_EQ(0, inv_mod(i,\
    \ 1));\n        ASSERT_EQ(0, inv_mod(-i, 1));\n        ASSERT_EQ(0, inv_mod(std::numeric_limits<ll>::min()\
    \ + i, 1));\n        ASSERT_EQ(0, inv_mod(std::numeric_limits<ll>::max() - i,\
    \ 1));\n    }\n}\n\nTEST(MathTest, FloorSum) {\n    for (int n = 0; n < 20; n++)\
    \ {\n        for (int m = 1; m < 20; m++) {\n            for (int a = 0; a < 20;\
    \ a++) {\n                for (int b = 0; b < 20; b++) {\n                   \
    \ ASSERT_EQ(floor_sum_naive(n, m, a, b),\n                              floor_sum(n,\
    \ m, a, b));\n                }\n            }\n        }\n    }\n}\n\nTEST(MathTest,\
    \ CRTHand) {\n    auto res = crt({1, 2, 1}, {2, 3, 2});\n    ASSERT_EQ(5, res.first);\n\
    \    ASSERT_EQ(6, res.second);\n}\n\nTEST(MathTest, CRT2) {\n    for (int a =\
    \ 1; a <= 20; a++) {\n        for (int b = 1; b <= 20; b++) {\n            for\
    \ (int c = -10; c <= 10; c++) {\n                for (int d = -10; d <= 10; d++)\
    \ {\n                    auto res = crt({c, d}, {a, b});\n                   \
    \ if (res.second == 0) {\n                        for (int x = 0; x < a * b /\
    \ gcd(a, b); x++) {\n                            ASSERT_TRUE(x % a != c || x %\
    \ b != d);\n                        }\n                        continue;\n   \
    \                 }\n                    ASSERT_EQ(a * b / gcd(a, b), res.second);\n\
    \                    ASSERT_EQ(internal::safe_mod(c, a), res.first % a);\n   \
    \                 ASSERT_EQ(internal::safe_mod(d, b), res.first % b);\n      \
    \          }\n            }\n        }\n    }\n}\n\nTEST(MathTest, CRT3) {\n \
    \   for (int a = 1; a <= 5; a++) {\n        for (int b = 1; b <= 5; b++) {\n \
    \           for (int c = 1; c <= 5; c++) {\n                for (int d = -5; d\
    \ <= 5; d++) {\n                    for (int e = -5; e <= 5; e++) {\n        \
    \                for (int f = -5; f <= 5; f++) {\n                           \
    \ auto res = crt({d, e, f}, {a, b, c});\n                            ll lcm =\
    \ a * b / gcd(a, b);\n                            lcm = lcm * c / gcd(lcm, c);\n\
    \                            if (res.second == 0) {\n                        \
    \        for (int x = 0; x < lcm; x++) {\n                                   \
    \ ASSERT_TRUE(x % a != d || x % b != e ||\n                                  \
    \              x % c != f);\n                                }\n             \
    \                   continue;\n                            }\n               \
    \             ASSERT_EQ(lcm, res.second);\n                            ASSERT_EQ(internal::safe_mod(d,\
    \ a), res.first % a);\n                            ASSERT_EQ(internal::safe_mod(e,\
    \ b), res.first % b);\n                            ASSERT_EQ(internal::safe_mod(f,\
    \ c), res.first % c);\n                        }\n                    }\n    \
    \            }\n            }\n        }\n    }\n}\n\nTEST(MathTest, CRTOverflow)\
    \ {\n    long long r0 = 0;\n    long long r1 = 1'000'000'000'000LL - 2;\n    long\
    \ long m0 = 900577;\n    long long m1 = 1'000'000'000'000LL;\n    auto res = crt({r0,\
    \ r1}, {m0, m1});\n    ASSERT_EQ(m0 * m1, res.second);\n    ASSERT_EQ(r0, res.first\
    \ % m0);\n    ASSERT_EQ(r1, res.first % m1);\n}\n\nTEST(MathTest, CRTBound) {\n\
    \    const ll INF = std::numeric_limits<ll>::max();\n    std::vector<ll> pred;\n\
    \    for (int i = 1; i <= 10; i++) {\n        pred.push_back(i);\n        pred.push_back(INF\
    \ - (i - 1));\n    }\n    pred.push_back(998244353);\n    pred.push_back(1'000'000'007);\n\
    \    pred.push_back(1'000'000'009);\n\n    for (auto ab : std::vector<std::pair<ll,\
    \ ll>>{{INF, INF},\n                                                  {1, INF},\n\
    \                                                  {INF, 1},\n               \
    \                                   {7, INF},\n                              \
    \                    {INF / 337, 337},\n                                     \
    \             {2, (INF - 1) / 2}}) {\n        ll a = ab.first;\n        ll b =\
    \ ab.second;\n        for (int ph = 0; ph < 2; ph++) {\n            for (ll ans\
    \ : pred) {\n                auto res = crt({ans % a, ans % b}, {a, b});\n   \
    \             ll lcm = a / gcd(a, b) * b;\n                ASSERT_EQ(lcm, res.second);\n\
    \                ASSERT_EQ(ans % lcm, res.first);\n            }\n           \
    \ std::swap(a, b);\n        }\n    }\n    std::vector<ll> factor_inf = {49, 73,\
    \ 127, 337, 92737, 649657};\n    do {\n        for (ll ans : pred) {\n       \
    \     std::vector<ll> r, m;\n            for (ll f : factor_inf) {\n         \
    \       r.push_back(ans % f);\n                m.push_back(f);\n            }\n\
    \            auto res = crt(r, m);\n            ASSERT_EQ(ans % INF, res.first);\n\
    \            ASSERT_EQ(INF, res.second);\n        }\n    } while (next_permutation(factor_inf.begin(),\
    \ factor_inf.end()));\n    std::vector<ll> factor_infn1 = {2, 3, 715827883, 2147483647};\n\
    \    do {\n        for (ll ans : pred) {\n            std::vector<ll> r, m;\n\
    \            for (ll f : factor_infn1) {\n                r.push_back(ans % f);\n\
    \                m.push_back(f);\n            }\n            auto res = crt(r,\
    \ m);\n            ASSERT_EQ(ans % (INF - 1), res.first);\n            ASSERT_EQ(INF\
    \ - 1, res.second);\n        }\n    } while (next_permutation(factor_infn1.begin(),\
    \ factor_infn1.end()));\n}\n\nstd::vector<int> factors(int m) {\n    std::vector<int>\
    \ result;\n    for (int i = 2; (ll)(i)*i <= m; i++) {\n        if (m % i == 0)\
    \ {\n            result.push_back(i);\n            while (m % i == 0) {\n    \
    \            m /= i;\n            }\n        }\n    }\n    if (m > 1) result.push_back(m);\n\
    \    return result;\n}\n\nbool is_primitive_root(int m, int g) {\n    assert(1\
    \ <= g && g < m);\n    auto prs = factors(m - 1);\n    for (int x : factors(m\
    \ - 1)) {\n        if (internal::pow_mod_constexpr(g, (m - 1) / x, m) == 1) return\
    \ false;\n    }\n    return true;\n}\n\nbool is_primitive_root_naive(int m, int\
    \ g) {\n    assert(1 <= g && g < m);\n    auto prs = factors(m - 1);\n    int\
    \ x = 1;\n    for (int i = 1; i <= m - 2; i++) {\n        x = (int)((long long)(x)*g\
    \ % m);\n        // x == n^i\n        if (x == 1) return false;\n    }\n    x\
    \ = (int)((long long)(x)*g % m);\n    assert(x == 1);\n    return true;\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/math_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/math_test.cpp
layout: document
redirect_from:
- /library/test/unittest/math_test.cpp
- /library/test/unittest/math_test.cpp.html
title: test/unittest/math_test.cpp
---
