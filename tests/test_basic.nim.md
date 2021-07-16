---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: '#include <gtest/gtest.h>


    #include <atcoder/all>

    #include <type_traits>

    import std/unittest


    ##ifndef _MSC_VER

    #

    #int mul100(int a) { return a * 100; }

    #

    #TEST(BasicTest, UBSanitize) {

    #    int a = 1 << 30;

    #    ASSERT_DEATH(mul100(a), ".*");

    #}

    #

    ##endif

    #

    ##ifdef _MSC_VER

    #

    #int main() {

    #    unsigned long long a = 123456789123456LL;

    #    unsigned long long b = 114514123456789LL;

    #    unsigned long long c;

    #    unsigned long long d = _umul128(a, b, &c);

    #    ASSERT_EQ(766397903ULL, c);

    #    ASSERT_EQ(15993528026429681536ULL, d);

    #}

    #

    ##endif

    '
  dependsOn: []
  isVerificationFile: false
  path: tests/test_basic.nim
  requiredBy: []
  timestamp: '2020-09-25 22:39:15+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_basic.nim
layout: document
redirect_from:
- /library/tests/test_basic.nim
- /library/tests/test_basic.nim.html
title: tests/test_basic.nim
---
