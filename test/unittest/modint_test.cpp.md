---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/modint_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/modint>\n#include <type_traits>\n\nusing namespace atcoder;\n\
    using ll = long long;\n\nll gcd(ll a, ll b) {\n    if (b == 0) return a;\n   \
    \ return gcd(b, a % b);\n}\n\nstatic_assert(internal::is_modint<static_modint<1>>::value,\
    \ \"\");\nstatic_assert(internal::is_modint<static_modint<998244353>>::value,\
    \ \"\");\nstatic_assert(internal::is_modint<modint>::value, \"\");\nstatic_assert(internal::is_modint<dynamic_modint<0>>::value,\
    \ \"\");\nstatic_assert(!internal::is_modint<int>::value, \"\");\n\nstatic_assert(internal::is_static_modint<static_modint<1>>::value,\
    \ \"\");\nstatic_assert(internal::is_static_modint<static_modint<998244353>>::value,\
    \ \"\");\nstatic_assert(internal::is_static_modint<modint998244353>::value, \"\
    \");\nstatic_assert(internal::is_static_modint<modint1000000007>::value, \"\"\
    );\nstatic_assert(!internal::is_static_modint<modint>::value, \"\");\nstatic_assert(!internal::is_static_modint<dynamic_modint<0>>::value,\
    \ \"\");\nstatic_assert(!internal::is_static_modint<int>::value, \"\");\n\nstatic_assert(!internal::is_dynamic_modint<static_modint<1>>::value,\
    \ \"\");\nstatic_assert(!internal::is_dynamic_modint<static_modint<998244353>>::value,\n\
    \              \"\");\nstatic_assert(internal::is_dynamic_modint<modint>::value,\
    \ \"\");\nstatic_assert(internal::is_dynamic_modint<dynamic_modint<0>>::value,\
    \ \"\");\nstatic_assert(!internal::is_dynamic_modint<int>::value, \"\");\n\nstatic_assert(std::is_same<modint,\
    \ dynamic_modint<-1>>::value, \"\");\n\nstatic_assert(modint998244353::mod() ==\
    \ 998244353, \"\");\nstatic_assert(modint1000000007::mod() == 1000000007, \"\"\
    );\n\nTEST(ModintTest, DynamicBorder) {\n    using mint = modint;\n    const int\
    \ mod_upper = std::numeric_limits<int>::max();\n    for (unsigned int mod = mod_upper;\
    \ mod >= mod_upper - 20; mod--) {\n        mint::set_mod(mod);\n        std::vector<ll>\
    \ v;\n        for (int i = 0; i < 10; i++) {\n            v.push_back(i);\n  \
    \          v.push_back(mod - i);\n            v.push_back(mod / 2 + i);\n    \
    \        v.push_back(mod / 2 - i);\n        }\n        for (ll a : v) {\n    \
    \        ASSERT_EQ(((a * a) % mod * a) % mod, (mint(a).pow(3)).val());\n     \
    \       for (ll b : v) {\n                ASSERT_EQ((a + b) % mod, (mint(a) +\
    \ mint(b)).val());\n                ASSERT_EQ((a - b + mod) % mod, (mint(a) -\
    \ mint(b)).val());\n                ASSERT_EQ((a * b) % mod, (mint(a) * mint(b)).val());\n\
    \            }\n        }\n    }\n}\n\nTEST(ModintTest, ULL) {\n    modint::set_mod(998244353);\n\
    \    ASSERT_NE(modint::mod() - 1, modint((unsigned long long)(-1)).val());\n \
    \   ASSERT_NE(0, ((unsigned long long)(-1) + modint(1)).val());\n    using mint\
    \ = static_modint<998244353>;\n    ASSERT_NE(mint::mod() - 1, modint((unsigned\
    \ long long)(-1)).val());\n    ASSERT_NE(0, ((unsigned long long)(-1) + mint(1)).val());\n\
    }\n\nTEST(ModintTest, Mod1) {\n    modint::set_mod(1);\n    for (int i = 0; i\
    \ < 100; i++) {\n        for (int j = 0; j < 100; j++) {\n            ASSERT_EQ((modint(i)\
    \ * modint(j)).val(), 0);\n        }\n    }\n    ASSERT_EQ((modint(1234) + modint(5678)).val(),\
    \ 0);\n    ASSERT_EQ((modint(1234) - modint(5678)).val(), 0);\n    ASSERT_EQ((modint(1234)\
    \ * modint(5678)).val(), 0);\n    ASSERT_EQ((modint(1234).pow(5678)), 0);\n  \
    \  ASSERT_EQ(0, modint(0).inv());\n\n    ASSERT_EQ(0, modint(true).val());\n\n\
    \    using mint = static_modint<1>;\n    for (int i = 0; i < 100; i++) {\n   \
    \     for (int j = 0; j < 100; j++) {\n            ASSERT_EQ((mint(i) * mint(j)).val(),\
    \ 0);\n        }\n    }\n    ASSERT_EQ((mint(1234) + mint(5678)).val(), 0);\n\
    \    ASSERT_EQ((mint(1234) - mint(5678)).val(), 0);\n    ASSERT_EQ((mint(1234)\
    \ * mint(5678)).val(), 0);\n    ASSERT_EQ((mint(1234).pow(5678)), 0);\n    ASSERT_EQ(0,\
    \ modint(0).inv());\n\n    ASSERT_EQ(0, mint(true).val());\n}\n\n#ifndef _MSC_VER\n\
    \nTEST(ModintTest, Int128) {\n    modint::set_mod(998244353);\n    ASSERT_EQ(12345678,\
    \ modint(__int128_t(12345678)).val());\n    ASSERT_EQ(12345678, modint(__uint128_t(12345678)).val());\n\
    \    ASSERT_EQ(12345678, modint(__int128(12345678)).val());\n    ASSERT_EQ(12345678,\
    \ modint((unsigned __int128)(12345678)).val());\n    ASSERT_EQ(modint(2).pow(100).val(),\
    \ modint(__int128_t(1) << 100).val());\n    ASSERT_EQ(modint(2).pow(100).val(),\
    \ modint(__uint128_t(1) << 100).val());\n    using mint = static_modint<998244353>;\n\
    \    ASSERT_EQ(12345678, mint(__int128_t(12345678)).val());\n    ASSERT_EQ(12345678,\
    \ mint(__uint128_t(12345678)).val());\n    ASSERT_EQ(12345678, mint(__int128(12345678)).val());\n\
    \    ASSERT_EQ(12345678, mint((unsigned __int128)(12345678)).val());\n    ASSERT_EQ(mint(2).pow(100).val(),\
    \ mint(__int128_t(1) << 100).val());\n    ASSERT_EQ(mint(2).pow(100).val(), mint(__uint128_t(1)\
    \ << 100).val());\n}\n\n#endif\n\nTEST(ModintTest, Inv) {\n    for (int i = 1;\
    \ i < 10; i++) {\n        int x = static_modint<11>(i).inv().val();\n        ASSERT_EQ(1,\
    \ (x * i) % 11);\n    }\n\n    for (int i = 1; i < 11; i++) {\n        if (gcd(i,\
    \ 12) != 1) continue;\n        int x = static_modint<12>(i).inv().val();\n   \
    \     ASSERT_EQ(1, (x * i) % 12);\n    }\n\n    for (int i = 1; i < 100000; i++)\
    \ {\n        int x = static_modint<1'000'000'007>(i).inv().val();\n        ASSERT_EQ(1,\
    \ (ll(x) * i) % 1'000'000'007);\n    }\n\n    for (int i = 1; i < 100000; i++)\
    \ {\n        if (gcd(i, 1'000'000'008) != 1) continue;\n        int x = static_modint<1'000'000'008>(i).inv().val();\n\
    \        ASSERT_EQ(1, (ll(x) * i) % 1'000'000'008);\n    }\n\n    modint::set_mod(998244353);\n\
    \    for (int i = 1; i < 100000; i++) {\n        int x = modint(i).inv().val();\n\
    \        ASSERT_LE(0, x);\n        ASSERT_GE(998244353 - 1, x);\n        ASSERT_EQ(1,\
    \ (ll(x) * i) % 998244353);\n    }\n\n    modint::set_mod(1'000'000'008);\n  \
    \  for (int i = 1; i < 100000; i++) {\n        if (gcd(i, 1'000'000'008) != 1)\
    \ continue;\n        int x = modint(i).inv().val();\n        ASSERT_EQ(1, (ll(x)\
    \ * i) % 1'000'000'008);\n    }\n}\n\nTEST(ModintTest, ConstUsage) {\n    using\
    \ sint = static_modint<11>;\n    const sint a = 9;\n    ASSERT_EQ(9, a.val());\n\
    \    using dint = modint;\n    dint::set_mod(11);\n    const dint b = 9;\n   \
    \ ASSERT_EQ(9, b.val());\n}\n\nTEST(ModintTest, Increment) {\n    using sint =\
    \ static_modint<11>;\n    using dint = modint;\n    dint::set_mod(11);\n\n   \
    \ {\n        sint a;\n        a = 8;\n        ASSERT_EQ(9, (++a).val());\n   \
    \     ASSERT_EQ(10, (++a).val());\n        ASSERT_EQ(0, (++a).val());\n      \
    \  ASSERT_EQ(1, (++a).val());\n        a = 3;\n        ASSERT_EQ(2, (--a).val());\n\
    \        ASSERT_EQ(1, (--a).val());\n        ASSERT_EQ(0, (--a).val());\n    \
    \    ASSERT_EQ(10, (--a).val());\n        a = 8;\n        ASSERT_EQ(8, (a++).val());\n\
    \        ASSERT_EQ(9, (a++).val());\n        ASSERT_EQ(10, (a++).val());\n   \
    \     ASSERT_EQ(0, (a++).val());\n        ASSERT_EQ(1, a.val());\n        a =\
    \ 3;\n        ASSERT_EQ(3, (a--).val());\n        ASSERT_EQ(2, (a--).val());\n\
    \        ASSERT_EQ(1, (a--).val());\n        ASSERT_EQ(0, (a--).val());\n    \
    \    ASSERT_EQ(10, a.val());\n    }\n    {\n        dint a;\n        a = 8;\n\
    \        ASSERT_EQ(9, (++a).val());\n        ASSERT_EQ(10, (++a).val());\n   \
    \     ASSERT_EQ(0, (++a).val());\n        ASSERT_EQ(1, (++a).val());\n       \
    \ a = 3;\n        ASSERT_EQ(2, (--a).val());\n        ASSERT_EQ(1, (--a).val());\n\
    \        ASSERT_EQ(0, (--a).val());\n        ASSERT_EQ(10, (--a).val());\n   \
    \     a = 8;\n        ASSERT_EQ(8, (a++).val());\n        ASSERT_EQ(9, (a++).val());\n\
    \        ASSERT_EQ(10, (a++).val());\n        ASSERT_EQ(0, (a++).val());\n   \
    \     ASSERT_EQ(1, a.val());\n        a = 3;\n        ASSERT_EQ(3, (a--).val());\n\
    \        ASSERT_EQ(2, (a--).val());\n        ASSERT_EQ(1, (a--).val());\n    \
    \    ASSERT_EQ(0, (a--).val());\n        ASSERT_EQ(10, a.val());\n    }\n}\n\n\
    TEST(ModintTest, StaticUsage) {\n    using mint = static_modint<11>;\n    ASSERT_EQ(11,\
    \ mint::mod());\n    ASSERT_EQ(4, +mint(4));\n    ASSERT_EQ(7, -mint(4));\n\n\
    \    ASSERT_FALSE(mint(1) == mint(3));\n    ASSERT_TRUE(mint(1) != mint(3));\n\
    \    ASSERT_TRUE(mint(1) == mint(12));\n    ASSERT_FALSE(mint(1) != mint(12));\n\
    \n    EXPECT_DEATH(mint(3).pow(-1), \".*\");\n}\n\nTEST(ModintTest, DynamicUsage)\
    \ {\n    ASSERT_EQ(998244353, dynamic_modint<12345>::mod());\n    using mint =\
    \ modint;\n    mint::set_mod(998244353);\n    ASSERT_EQ(998244353, mint::mod());\n\
    \    ASSERT_EQ(3, (mint(1) + mint(2)).val());\n    ASSERT_EQ(3, (1 + mint(2)).val());\n\
    \    ASSERT_EQ(3, (mint(1) + 2).val());\n\n    mint::set_mod(3);\n    ASSERT_EQ(3,\
    \ mint::mod());\n    ASSERT_EQ(1, (mint(2) - mint(1)).val());\n    ASSERT_EQ(0,\
    \ (mint(1) + mint(2)).val());\n\n    mint::set_mod(11);\n    ASSERT_EQ(11, mint::mod());\n\
    \    ASSERT_EQ(4, (mint(3) * mint(5)).val());\n\n    ASSERT_EQ(4, +mint(4));\n\
    \    ASSERT_EQ(7, -mint(4));\n\n    ASSERT_FALSE(mint(1) == mint(3));\n    ASSERT_TRUE(mint(1)\
    \ != mint(3));\n    ASSERT_TRUE(mint(1) == mint(12));\n    ASSERT_FALSE(mint(1)\
    \ != mint(12));\n\n    EXPECT_DEATH(mint(3).pow(-1), \".*\");\n}\n\nTEST(ModintTest,\
    \ Constructor) {\n    modint::set_mod(11);\n    ASSERT_EQ(1, modint(true).val());\n\
    \    ASSERT_EQ(3, modint((char)(3)).val());\n    ASSERT_EQ(3, modint((signed char)(3)).val());\n\
    \    ASSERT_EQ(3, modint((unsigned char)(3)).val());\n    ASSERT_EQ(3, modint((short)(3)).val());\n\
    \    ASSERT_EQ(3, modint((unsigned short)(3)).val());\n    ASSERT_EQ(3, modint((int)(3)).val());\n\
    \    ASSERT_EQ(3, modint((unsigned int)(3)).val());\n    ASSERT_EQ(3, modint((long)(3)).val());\n\
    \    ASSERT_EQ(3, modint((unsigned long)(3)).val());\n    ASSERT_EQ(3, modint((long\
    \ long)(3)).val());\n    ASSERT_EQ(3, modint((unsigned long long)(3)).val());\n\
    \    ASSERT_EQ(1, modint((signed char)(-10)).val());\n    ASSERT_EQ(1, modint((short)(-10)).val());\n\
    \    ASSERT_EQ(1, modint((int)(-10)).val());\n    ASSERT_EQ(1, modint((long)(-10)).val());\n\
    \    ASSERT_EQ(1, modint((long long)(-10)).val());\n\n    ASSERT_EQ(2, (int(1)\
    \ + modint(1)).val());\n    ASSERT_EQ(2, (short(1) + modint(1)).val());\n\n  \
    \  modint m;\n    ASSERT_EQ(0, m.val());\n}\n\nTEST(ModintTest, ConstructorStatic)\
    \ {\n    using mint = static_modint<11>;\n    ASSERT_EQ(1, mint(true).val());\n\
    \    ASSERT_EQ(3, mint((char)(3)).val());\n    ASSERT_EQ(3, mint((signed char)(3)).val());\n\
    \    ASSERT_EQ(3, mint((unsigned char)(3)).val());\n    ASSERT_EQ(3, mint((short)(3)).val());\n\
    \    ASSERT_EQ(3, mint((unsigned short)(3)).val());\n    ASSERT_EQ(3, mint((int)(3)).val());\n\
    \    ASSERT_EQ(3, mint((unsigned int)(3)).val());\n    ASSERT_EQ(3, mint((long)(3)).val());\n\
    \    ASSERT_EQ(3, mint((unsigned long)(3)).val());\n    ASSERT_EQ(3, mint((long\
    \ long)(3)).val());\n    ASSERT_EQ(3, mint((unsigned long long)(3)).val());\n\
    \    ASSERT_EQ(1, mint((signed char)(-10)).val());\n    ASSERT_EQ(1, mint((short)(-10)).val());\n\
    \    ASSERT_EQ(1, mint((int)(-10)).val());\n    ASSERT_EQ(1, mint((long)(-10)).val());\n\
    \    ASSERT_EQ(1, mint((long long)(-10)).val());\n\n    ASSERT_EQ(2, (int(1) +\
    \ mint(1)).val());\n    ASSERT_EQ(2, (short(1) + mint(1)).val());\n\n    mint\
    \ m;\n    ASSERT_EQ(0, m.val());\n}\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/modint>\n#include <type_traits>\n\
    \nusing namespace atcoder;\nusing ll = long long;\n\nll gcd(ll a, ll b) {\n  \
    \  if (b == 0) return a;\n    return gcd(b, a % b);\n}\n\nstatic_assert(internal::is_modint<static_modint<1>>::value,\
    \ \"\");\nstatic_assert(internal::is_modint<static_modint<998244353>>::value,\
    \ \"\");\nstatic_assert(internal::is_modint<modint>::value, \"\");\nstatic_assert(internal::is_modint<dynamic_modint<0>>::value,\
    \ \"\");\nstatic_assert(!internal::is_modint<int>::value, \"\");\n\nstatic_assert(internal::is_static_modint<static_modint<1>>::value,\
    \ \"\");\nstatic_assert(internal::is_static_modint<static_modint<998244353>>::value,\
    \ \"\");\nstatic_assert(internal::is_static_modint<modint998244353>::value, \"\
    \");\nstatic_assert(internal::is_static_modint<modint1000000007>::value, \"\"\
    );\nstatic_assert(!internal::is_static_modint<modint>::value, \"\");\nstatic_assert(!internal::is_static_modint<dynamic_modint<0>>::value,\
    \ \"\");\nstatic_assert(!internal::is_static_modint<int>::value, \"\");\n\nstatic_assert(!internal::is_dynamic_modint<static_modint<1>>::value,\
    \ \"\");\nstatic_assert(!internal::is_dynamic_modint<static_modint<998244353>>::value,\n\
    \              \"\");\nstatic_assert(internal::is_dynamic_modint<modint>::value,\
    \ \"\");\nstatic_assert(internal::is_dynamic_modint<dynamic_modint<0>>::value,\
    \ \"\");\nstatic_assert(!internal::is_dynamic_modint<int>::value, \"\");\n\nstatic_assert(std::is_same<modint,\
    \ dynamic_modint<-1>>::value, \"\");\n\nstatic_assert(modint998244353::mod() ==\
    \ 998244353, \"\");\nstatic_assert(modint1000000007::mod() == 1000000007, \"\"\
    );\n\nTEST(ModintTest, DynamicBorder) {\n    using mint = modint;\n    const int\
    \ mod_upper = std::numeric_limits<int>::max();\n    for (unsigned int mod = mod_upper;\
    \ mod >= mod_upper - 20; mod--) {\n        mint::set_mod(mod);\n        std::vector<ll>\
    \ v;\n        for (int i = 0; i < 10; i++) {\n            v.push_back(i);\n  \
    \          v.push_back(mod - i);\n            v.push_back(mod / 2 + i);\n    \
    \        v.push_back(mod / 2 - i);\n        }\n        for (ll a : v) {\n    \
    \        ASSERT_EQ(((a * a) % mod * a) % mod, (mint(a).pow(3)).val());\n     \
    \       for (ll b : v) {\n                ASSERT_EQ((a + b) % mod, (mint(a) +\
    \ mint(b)).val());\n                ASSERT_EQ((a - b + mod) % mod, (mint(a) -\
    \ mint(b)).val());\n                ASSERT_EQ((a * b) % mod, (mint(a) * mint(b)).val());\n\
    \            }\n        }\n    }\n}\n\nTEST(ModintTest, ULL) {\n    modint::set_mod(998244353);\n\
    \    ASSERT_NE(modint::mod() - 1, modint((unsigned long long)(-1)).val());\n \
    \   ASSERT_NE(0, ((unsigned long long)(-1) + modint(1)).val());\n    using mint\
    \ = static_modint<998244353>;\n    ASSERT_NE(mint::mod() - 1, modint((unsigned\
    \ long long)(-1)).val());\n    ASSERT_NE(0, ((unsigned long long)(-1) + mint(1)).val());\n\
    }\n\nTEST(ModintTest, Mod1) {\n    modint::set_mod(1);\n    for (int i = 0; i\
    \ < 100; i++) {\n        for (int j = 0; j < 100; j++) {\n            ASSERT_EQ((modint(i)\
    \ * modint(j)).val(), 0);\n        }\n    }\n    ASSERT_EQ((modint(1234) + modint(5678)).val(),\
    \ 0);\n    ASSERT_EQ((modint(1234) - modint(5678)).val(), 0);\n    ASSERT_EQ((modint(1234)\
    \ * modint(5678)).val(), 0);\n    ASSERT_EQ((modint(1234).pow(5678)), 0);\n  \
    \  ASSERT_EQ(0, modint(0).inv());\n\n    ASSERT_EQ(0, modint(true).val());\n\n\
    \    using mint = static_modint<1>;\n    for (int i = 0; i < 100; i++) {\n   \
    \     for (int j = 0; j < 100; j++) {\n            ASSERT_EQ((mint(i) * mint(j)).val(),\
    \ 0);\n        }\n    }\n    ASSERT_EQ((mint(1234) + mint(5678)).val(), 0);\n\
    \    ASSERT_EQ((mint(1234) - mint(5678)).val(), 0);\n    ASSERT_EQ((mint(1234)\
    \ * mint(5678)).val(), 0);\n    ASSERT_EQ((mint(1234).pow(5678)), 0);\n    ASSERT_EQ(0,\
    \ modint(0).inv());\n\n    ASSERT_EQ(0, mint(true).val());\n}\n\n#ifndef _MSC_VER\n\
    \nTEST(ModintTest, Int128) {\n    modint::set_mod(998244353);\n    ASSERT_EQ(12345678,\
    \ modint(__int128_t(12345678)).val());\n    ASSERT_EQ(12345678, modint(__uint128_t(12345678)).val());\n\
    \    ASSERT_EQ(12345678, modint(__int128(12345678)).val());\n    ASSERT_EQ(12345678,\
    \ modint((unsigned __int128)(12345678)).val());\n    ASSERT_EQ(modint(2).pow(100).val(),\
    \ modint(__int128_t(1) << 100).val());\n    ASSERT_EQ(modint(2).pow(100).val(),\
    \ modint(__uint128_t(1) << 100).val());\n    using mint = static_modint<998244353>;\n\
    \    ASSERT_EQ(12345678, mint(__int128_t(12345678)).val());\n    ASSERT_EQ(12345678,\
    \ mint(__uint128_t(12345678)).val());\n    ASSERT_EQ(12345678, mint(__int128(12345678)).val());\n\
    \    ASSERT_EQ(12345678, mint((unsigned __int128)(12345678)).val());\n    ASSERT_EQ(mint(2).pow(100).val(),\
    \ mint(__int128_t(1) << 100).val());\n    ASSERT_EQ(mint(2).pow(100).val(), mint(__uint128_t(1)\
    \ << 100).val());\n}\n\n#endif\n\nTEST(ModintTest, Inv) {\n    for (int i = 1;\
    \ i < 10; i++) {\n        int x = static_modint<11>(i).inv().val();\n        ASSERT_EQ(1,\
    \ (x * i) % 11);\n    }\n\n    for (int i = 1; i < 11; i++) {\n        if (gcd(i,\
    \ 12) != 1) continue;\n        int x = static_modint<12>(i).inv().val();\n   \
    \     ASSERT_EQ(1, (x * i) % 12);\n    }\n\n    for (int i = 1; i < 100000; i++)\
    \ {\n        int x = static_modint<1'000'000'007>(i).inv().val();\n        ASSERT_EQ(1,\
    \ (ll(x) * i) % 1'000'000'007);\n    }\n\n    for (int i = 1; i < 100000; i++)\
    \ {\n        if (gcd(i, 1'000'000'008) != 1) continue;\n        int x = static_modint<1'000'000'008>(i).inv().val();\n\
    \        ASSERT_EQ(1, (ll(x) * i) % 1'000'000'008);\n    }\n\n    modint::set_mod(998244353);\n\
    \    for (int i = 1; i < 100000; i++) {\n        int x = modint(i).inv().val();\n\
    \        ASSERT_LE(0, x);\n        ASSERT_GE(998244353 - 1, x);\n        ASSERT_EQ(1,\
    \ (ll(x) * i) % 998244353);\n    }\n\n    modint::set_mod(1'000'000'008);\n  \
    \  for (int i = 1; i < 100000; i++) {\n        if (gcd(i, 1'000'000'008) != 1)\
    \ continue;\n        int x = modint(i).inv().val();\n        ASSERT_EQ(1, (ll(x)\
    \ * i) % 1'000'000'008);\n    }\n}\n\nTEST(ModintTest, ConstUsage) {\n    using\
    \ sint = static_modint<11>;\n    const sint a = 9;\n    ASSERT_EQ(9, a.val());\n\
    \    using dint = modint;\n    dint::set_mod(11);\n    const dint b = 9;\n   \
    \ ASSERT_EQ(9, b.val());\n}\n\nTEST(ModintTest, Increment) {\n    using sint =\
    \ static_modint<11>;\n    using dint = modint;\n    dint::set_mod(11);\n\n   \
    \ {\n        sint a;\n        a = 8;\n        ASSERT_EQ(9, (++a).val());\n   \
    \     ASSERT_EQ(10, (++a).val());\n        ASSERT_EQ(0, (++a).val());\n      \
    \  ASSERT_EQ(1, (++a).val());\n        a = 3;\n        ASSERT_EQ(2, (--a).val());\n\
    \        ASSERT_EQ(1, (--a).val());\n        ASSERT_EQ(0, (--a).val());\n    \
    \    ASSERT_EQ(10, (--a).val());\n        a = 8;\n        ASSERT_EQ(8, (a++).val());\n\
    \        ASSERT_EQ(9, (a++).val());\n        ASSERT_EQ(10, (a++).val());\n   \
    \     ASSERT_EQ(0, (a++).val());\n        ASSERT_EQ(1, a.val());\n        a =\
    \ 3;\n        ASSERT_EQ(3, (a--).val());\n        ASSERT_EQ(2, (a--).val());\n\
    \        ASSERT_EQ(1, (a--).val());\n        ASSERT_EQ(0, (a--).val());\n    \
    \    ASSERT_EQ(10, a.val());\n    }\n    {\n        dint a;\n        a = 8;\n\
    \        ASSERT_EQ(9, (++a).val());\n        ASSERT_EQ(10, (++a).val());\n   \
    \     ASSERT_EQ(0, (++a).val());\n        ASSERT_EQ(1, (++a).val());\n       \
    \ a = 3;\n        ASSERT_EQ(2, (--a).val());\n        ASSERT_EQ(1, (--a).val());\n\
    \        ASSERT_EQ(0, (--a).val());\n        ASSERT_EQ(10, (--a).val());\n   \
    \     a = 8;\n        ASSERT_EQ(8, (a++).val());\n        ASSERT_EQ(9, (a++).val());\n\
    \        ASSERT_EQ(10, (a++).val());\n        ASSERT_EQ(0, (a++).val());\n   \
    \     ASSERT_EQ(1, a.val());\n        a = 3;\n        ASSERT_EQ(3, (a--).val());\n\
    \        ASSERT_EQ(2, (a--).val());\n        ASSERT_EQ(1, (a--).val());\n    \
    \    ASSERT_EQ(0, (a--).val());\n        ASSERT_EQ(10, a.val());\n    }\n}\n\n\
    TEST(ModintTest, StaticUsage) {\n    using mint = static_modint<11>;\n    ASSERT_EQ(11,\
    \ mint::mod());\n    ASSERT_EQ(4, +mint(4));\n    ASSERT_EQ(7, -mint(4));\n\n\
    \    ASSERT_FALSE(mint(1) == mint(3));\n    ASSERT_TRUE(mint(1) != mint(3));\n\
    \    ASSERT_TRUE(mint(1) == mint(12));\n    ASSERT_FALSE(mint(1) != mint(12));\n\
    \n    EXPECT_DEATH(mint(3).pow(-1), \".*\");\n}\n\nTEST(ModintTest, DynamicUsage)\
    \ {\n    ASSERT_EQ(998244353, dynamic_modint<12345>::mod());\n    using mint =\
    \ modint;\n    mint::set_mod(998244353);\n    ASSERT_EQ(998244353, mint::mod());\n\
    \    ASSERT_EQ(3, (mint(1) + mint(2)).val());\n    ASSERT_EQ(3, (1 + mint(2)).val());\n\
    \    ASSERT_EQ(3, (mint(1) + 2).val());\n\n    mint::set_mod(3);\n    ASSERT_EQ(3,\
    \ mint::mod());\n    ASSERT_EQ(1, (mint(2) - mint(1)).val());\n    ASSERT_EQ(0,\
    \ (mint(1) + mint(2)).val());\n\n    mint::set_mod(11);\n    ASSERT_EQ(11, mint::mod());\n\
    \    ASSERT_EQ(4, (mint(3) * mint(5)).val());\n\n    ASSERT_EQ(4, +mint(4));\n\
    \    ASSERT_EQ(7, -mint(4));\n\n    ASSERT_FALSE(mint(1) == mint(3));\n    ASSERT_TRUE(mint(1)\
    \ != mint(3));\n    ASSERT_TRUE(mint(1) == mint(12));\n    ASSERT_FALSE(mint(1)\
    \ != mint(12));\n\n    EXPECT_DEATH(mint(3).pow(-1), \".*\");\n}\n\nTEST(ModintTest,\
    \ Constructor) {\n    modint::set_mod(11);\n    ASSERT_EQ(1, modint(true).val());\n\
    \    ASSERT_EQ(3, modint((char)(3)).val());\n    ASSERT_EQ(3, modint((signed char)(3)).val());\n\
    \    ASSERT_EQ(3, modint((unsigned char)(3)).val());\n    ASSERT_EQ(3, modint((short)(3)).val());\n\
    \    ASSERT_EQ(3, modint((unsigned short)(3)).val());\n    ASSERT_EQ(3, modint((int)(3)).val());\n\
    \    ASSERT_EQ(3, modint((unsigned int)(3)).val());\n    ASSERT_EQ(3, modint((long)(3)).val());\n\
    \    ASSERT_EQ(3, modint((unsigned long)(3)).val());\n    ASSERT_EQ(3, modint((long\
    \ long)(3)).val());\n    ASSERT_EQ(3, modint((unsigned long long)(3)).val());\n\
    \    ASSERT_EQ(1, modint((signed char)(-10)).val());\n    ASSERT_EQ(1, modint((short)(-10)).val());\n\
    \    ASSERT_EQ(1, modint((int)(-10)).val());\n    ASSERT_EQ(1, modint((long)(-10)).val());\n\
    \    ASSERT_EQ(1, modint((long long)(-10)).val());\n\n    ASSERT_EQ(2, (int(1)\
    \ + modint(1)).val());\n    ASSERT_EQ(2, (short(1) + modint(1)).val());\n\n  \
    \  modint m;\n    ASSERT_EQ(0, m.val());\n}\n\nTEST(ModintTest, ConstructorStatic)\
    \ {\n    using mint = static_modint<11>;\n    ASSERT_EQ(1, mint(true).val());\n\
    \    ASSERT_EQ(3, mint((char)(3)).val());\n    ASSERT_EQ(3, mint((signed char)(3)).val());\n\
    \    ASSERT_EQ(3, mint((unsigned char)(3)).val());\n    ASSERT_EQ(3, mint((short)(3)).val());\n\
    \    ASSERT_EQ(3, mint((unsigned short)(3)).val());\n    ASSERT_EQ(3, mint((int)(3)).val());\n\
    \    ASSERT_EQ(3, mint((unsigned int)(3)).val());\n    ASSERT_EQ(3, mint((long)(3)).val());\n\
    \    ASSERT_EQ(3, mint((unsigned long)(3)).val());\n    ASSERT_EQ(3, mint((long\
    \ long)(3)).val());\n    ASSERT_EQ(3, mint((unsigned long long)(3)).val());\n\
    \    ASSERT_EQ(1, mint((signed char)(-10)).val());\n    ASSERT_EQ(1, mint((short)(-10)).val());\n\
    \    ASSERT_EQ(1, mint((int)(-10)).val());\n    ASSERT_EQ(1, mint((long)(-10)).val());\n\
    \    ASSERT_EQ(1, mint((long long)(-10)).val());\n\n    ASSERT_EQ(2, (int(1) +\
    \ mint(1)).val());\n    ASSERT_EQ(2, (short(1) + mint(1)).val());\n\n    mint\
    \ m;\n    ASSERT_EQ(0, m.val());\n}\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/modint_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/modint_test.cpp
layout: document
redirect_from:
- /library/test/unittest/modint_test.cpp
- /library/test/unittest/modint_test.cpp.html
title: test/unittest/modint_test.cpp
---
