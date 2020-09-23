---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: cpp
  _verificationStatusIcon: ':warning:'
  attributes: {}
  bundledCode: "#line 1 \"test/unittest/type_traits_test.cpp\"\n#include <gtest/gtest.h>\n\
    \n#include <atcoder/internal_type_traits>\n#include <type_traits>\n\nusing namespace\
    \ atcoder;\nusing namespace std;\nusing ll = long long;\nusing ull = unsigned\
    \ long long;\n\nstruct A {};\n\nstatic_assert(internal::is_integral<bool>::value,\
    \ \"\");\nstatic_assert(internal::is_integral<int>::value, \"\");\nstatic_assert(!internal::is_integral<A>::value,\
    \ \"\");\n\nstatic_assert(internal::is_signed_int<signed char>::value, \"\");\n\
    static_assert(internal::is_signed_int<short>::value, \"\");\nstatic_assert(internal::is_signed_int<int>::value,\
    \ \"\");\nstatic_assert(internal::is_signed_int<long>::value, \"\");\nstatic_assert(internal::is_signed_int<long\
    \ long>::value, \"\");\n\nstatic_assert(!internal::is_signed_int<unsigned char>::value,\
    \ \"\");\nstatic_assert(!internal::is_signed_int<unsigned short>::value, \"\"\
    );\nstatic_assert(!internal::is_signed_int<unsigned int>::value, \"\");\nstatic_assert(!internal::is_signed_int<unsigned\
    \ long>::value, \"\");\nstatic_assert(!internal::is_signed_int<unsigned long long>::value,\
    \ \"\");\n\nstatic_assert(!internal::is_unsigned_int<signed char>::value, \"\"\
    );\nstatic_assert(!internal::is_unsigned_int<short>::value, \"\");\nstatic_assert(!internal::is_unsigned_int<int>::value,\
    \ \"\");\nstatic_assert(!internal::is_unsigned_int<long>::value, \"\");\nstatic_assert(!internal::is_unsigned_int<long\
    \ long>::value, \"\");\n\nstatic_assert(internal::is_unsigned_int<unsigned char>::value,\
    \ \"\");\nstatic_assert(internal::is_unsigned_int<unsigned short>::value, \"\"\
    );\nstatic_assert(internal::is_unsigned_int<unsigned int>::value, \"\");\nstatic_assert(internal::is_unsigned_int<unsigned\
    \ long>::value, \"\");\nstatic_assert(internal::is_unsigned_int<unsigned long\
    \ long>::value, \"\");\n\nstatic_assert(!internal::is_signed_int<A>::value, \"\
    \");\nstatic_assert(!internal::is_unsigned_int<A>::value, \"\");\n\nstatic_assert(is_same<unsigned\
    \ char, internal::to_unsigned_t<char>>::value, \"\");\nstatic_assert(\n    is_same<unsigned\
    \ char, internal::to_unsigned_t<signed char>>::value,\n    \"\");\nstatic_assert(\n\
    \    is_same<unsigned char, internal::to_unsigned_t<unsigned char>>::value,\n\
    \    \"\");\n\nstatic_assert(is_same<unsigned short, internal::to_unsigned_t<short>>::value,\n\
    \              \"\");\nstatic_assert(\n    is_same<unsigned short, internal::to_unsigned_t<unsigned\
    \ short>>::value,\n    \"\");\n\nstatic_assert(is_same<unsigned int, internal::to_unsigned_t<int>>::value,\
    \ \"\");\nstatic_assert(\n    is_same<unsigned int, internal::to_unsigned_t<unsigned\
    \ int>>::value,\n    \"\");\n\nstatic_assert(is_same<unsigned long, internal::to_unsigned_t<long>>::value,\
    \ \"\");\nstatic_assert(\n    is_same<unsigned long, internal::to_unsigned_t<unsigned\
    \ long>>::value,\n    \"\");\n\nstatic_assert(\n    is_same<unsigned long long,\
    \ internal::to_unsigned_t<long long>>::value,\n    \"\");\nstatic_assert(is_same<unsigned\
    \ long long,\n                      internal::to_unsigned_t<unsigned long long>>::value,\n\
    \              \"\");\n\nstatic_assert(is_same<A, internal::to_unsigned_t<A>>::value,\
    \ \"\");\n\n#ifndef _MSC_VER\n\nstatic_assert(internal::is_integral<__int128_t>::value,\
    \ \"\");\nstatic_assert(internal::is_integral<__uint128_t>::value, \"\");\nstatic_assert(internal::is_integral<__int128>::value,\
    \ \"\");\nstatic_assert(internal::is_integral<unsigned __int128>::value, \"\"\
    );\n\nstatic_assert(internal::is_signed_int<__int128_t>::value, \"\");\nstatic_assert(!internal::is_signed_int<__uint128_t>::value,\
    \ \"\");\nstatic_assert(internal::is_signed_int<__int128>::value, \"\");\nstatic_assert(!internal::is_signed_int<unsigned\
    \ __int128>::value, \"\");\n\nstatic_assert(!internal::is_unsigned_int<__int128_t>::value,\
    \ \"\");\nstatic_assert(internal::is_unsigned_int<__uint128_t>::value, \"\");\n\
    static_assert(!internal::is_unsigned_int<__int128>::value, \"\");\nstatic_assert(internal::is_unsigned_int<unsigned\
    \ __int128>::value, \"\");\n\nstatic_assert(std::is_same<__uint128_t,\n      \
    \                     internal::make_unsigned_int128<__int128_t>::type>::value,\n\
    \              \"\");\nstatic_assert(std::is_same<unsigned __int128,\n       \
    \                    internal::make_unsigned_int128<__int128>::type>::value,\n\
    \              \"\");\n\n#endif\n"
  code: "#include <gtest/gtest.h>\n\n#include <atcoder/internal_type_traits>\n#include\
    \ <type_traits>\n\nusing namespace atcoder;\nusing namespace std;\nusing ll =\
    \ long long;\nusing ull = unsigned long long;\n\nstruct A {};\n\nstatic_assert(internal::is_integral<bool>::value,\
    \ \"\");\nstatic_assert(internal::is_integral<int>::value, \"\");\nstatic_assert(!internal::is_integral<A>::value,\
    \ \"\");\n\nstatic_assert(internal::is_signed_int<signed char>::value, \"\");\n\
    static_assert(internal::is_signed_int<short>::value, \"\");\nstatic_assert(internal::is_signed_int<int>::value,\
    \ \"\");\nstatic_assert(internal::is_signed_int<long>::value, \"\");\nstatic_assert(internal::is_signed_int<long\
    \ long>::value, \"\");\n\nstatic_assert(!internal::is_signed_int<unsigned char>::value,\
    \ \"\");\nstatic_assert(!internal::is_signed_int<unsigned short>::value, \"\"\
    );\nstatic_assert(!internal::is_signed_int<unsigned int>::value, \"\");\nstatic_assert(!internal::is_signed_int<unsigned\
    \ long>::value, \"\");\nstatic_assert(!internal::is_signed_int<unsigned long long>::value,\
    \ \"\");\n\nstatic_assert(!internal::is_unsigned_int<signed char>::value, \"\"\
    );\nstatic_assert(!internal::is_unsigned_int<short>::value, \"\");\nstatic_assert(!internal::is_unsigned_int<int>::value,\
    \ \"\");\nstatic_assert(!internal::is_unsigned_int<long>::value, \"\");\nstatic_assert(!internal::is_unsigned_int<long\
    \ long>::value, \"\");\n\nstatic_assert(internal::is_unsigned_int<unsigned char>::value,\
    \ \"\");\nstatic_assert(internal::is_unsigned_int<unsigned short>::value, \"\"\
    );\nstatic_assert(internal::is_unsigned_int<unsigned int>::value, \"\");\nstatic_assert(internal::is_unsigned_int<unsigned\
    \ long>::value, \"\");\nstatic_assert(internal::is_unsigned_int<unsigned long\
    \ long>::value, \"\");\n\nstatic_assert(!internal::is_signed_int<A>::value, \"\
    \");\nstatic_assert(!internal::is_unsigned_int<A>::value, \"\");\n\nstatic_assert(is_same<unsigned\
    \ char, internal::to_unsigned_t<char>>::value, \"\");\nstatic_assert(\n    is_same<unsigned\
    \ char, internal::to_unsigned_t<signed char>>::value,\n    \"\");\nstatic_assert(\n\
    \    is_same<unsigned char, internal::to_unsigned_t<unsigned char>>::value,\n\
    \    \"\");\n\nstatic_assert(is_same<unsigned short, internal::to_unsigned_t<short>>::value,\n\
    \              \"\");\nstatic_assert(\n    is_same<unsigned short, internal::to_unsigned_t<unsigned\
    \ short>>::value,\n    \"\");\n\nstatic_assert(is_same<unsigned int, internal::to_unsigned_t<int>>::value,\
    \ \"\");\nstatic_assert(\n    is_same<unsigned int, internal::to_unsigned_t<unsigned\
    \ int>>::value,\n    \"\");\n\nstatic_assert(is_same<unsigned long, internal::to_unsigned_t<long>>::value,\
    \ \"\");\nstatic_assert(\n    is_same<unsigned long, internal::to_unsigned_t<unsigned\
    \ long>>::value,\n    \"\");\n\nstatic_assert(\n    is_same<unsigned long long,\
    \ internal::to_unsigned_t<long long>>::value,\n    \"\");\nstatic_assert(is_same<unsigned\
    \ long long,\n                      internal::to_unsigned_t<unsigned long long>>::value,\n\
    \              \"\");\n\nstatic_assert(is_same<A, internal::to_unsigned_t<A>>::value,\
    \ \"\");\n\n#ifndef _MSC_VER\n\nstatic_assert(internal::is_integral<__int128_t>::value,\
    \ \"\");\nstatic_assert(internal::is_integral<__uint128_t>::value, \"\");\nstatic_assert(internal::is_integral<__int128>::value,\
    \ \"\");\nstatic_assert(internal::is_integral<unsigned __int128>::value, \"\"\
    );\n\nstatic_assert(internal::is_signed_int<__int128_t>::value, \"\");\nstatic_assert(!internal::is_signed_int<__uint128_t>::value,\
    \ \"\");\nstatic_assert(internal::is_signed_int<__int128>::value, \"\");\nstatic_assert(!internal::is_signed_int<unsigned\
    \ __int128>::value, \"\");\n\nstatic_assert(!internal::is_unsigned_int<__int128_t>::value,\
    \ \"\");\nstatic_assert(internal::is_unsigned_int<__uint128_t>::value, \"\");\n\
    static_assert(!internal::is_unsigned_int<__int128>::value, \"\");\nstatic_assert(internal::is_unsigned_int<unsigned\
    \ __int128>::value, \"\");\n\nstatic_assert(std::is_same<__uint128_t,\n      \
    \                     internal::make_unsigned_int128<__int128_t>::type>::value,\n\
    \              \"\");\nstatic_assert(std::is_same<unsigned __int128,\n       \
    \                    internal::make_unsigned_int128<__int128>::type>::value,\n\
    \              \"\");\n\n#endif\n"
  dependsOn: []
  isVerificationFile: false
  path: test/unittest/type_traits_test.cpp
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: test/unittest/type_traits_test.cpp
layout: document
redirect_from:
- /library/test/unittest/type_traits_test.cpp
- /library/test/unittest/type_traits_test.cpp.html
title: test/unittest/type_traits_test.cpp
---
