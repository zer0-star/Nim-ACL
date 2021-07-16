---
data:
  _extendedDependsOn:
  - icon: ':x:'
    path: atcoder/extra/math/modint_montgomery.nim
    title: atcoder/extra/math/modint_montgomery.nim
  - icon: ':x:'
    path: atcoder/extra/math/modint_montgomery.nim
    title: atcoder/extra/math/modint_montgomery.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
  - icon: ':question:'
    path: atcoder/generate_definitions.nim
    title: atcoder/generate_definitions.nim
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
  code: "import atcoder/extra/math/modint_montgomery\nimport std/unittest\n\nstatic:\n\
    #  assert StaticModInt[1].isModInt\n#  assert StaticModInt[998244353].isModInt\n\
    #  assert modint.isModInt\n#  assert not int.isModInt\n#\n#  assert StaticModInt[1].is_static_modint\n\
    #  assert StaticModInt[998244353].is_static_modint\n#  assert modint998244353.is_static_modint\n\
    #  assert modint1000000007.is_static_modint\n#  assert not modint.is_static_modint\n\
    #  assert not int.is_static_modint\n#\n#  assert not StaticModInt[1].is_dynamic_modint\n\
    #  assert not StaticModInt[998244353].is_dynamic_modint\n#\n#  assert modint.is_dynamic_modint\n\
    #  assert not int.is_dynamic_modint\n#\n\n  assert modint998244353.mod() == 998244353\n\
    \  assert modint1000000007.mod() == 1000000007\n\ntest \"ModintTest, ULL\":\n\
    \  let m1 = cast[uint](-1)\n  type mint = modint998244353\n  check 0 != (m1 +\
    \ mint.init(1)).val()\n\n#test \"ModintTest, Mod1\":\n#  modint.set_mod(1)\n#\
    \  for i in 0..<100:\n#    for j in 0..<100:\n#      check (modint.init(i) * modint.init(j)).val()\
    \ == 0\n#  check (modint.init(1234) + modint.init(5678)).val() == 0\n#  check\
    \ (modint.init(1234) - modint.init(5678)).val() == 0\n#  check (modint.init(1234)\
    \ * modint.init(5678)).val() == 0\n#  check (modint.init(1234).pow(5678)) == 0\n\
    #  check 0 == modint.init(0).inv()\n#\n#  check 0 == modint.init(true.int).val()\n\
    #\n#  type mint = StaticModInt[1]\n#  for i in 0..<100:\n#    for j in 0..<100:\n\
    #      check (mint(i) * mint(j)).val() == 0\n#  check (mint.init(1234) + mint.init(5678)).val()\
    \ == 0\n#  check (mint.init(1234) - mint.init(5678)).val() == 0\n#  check (mint.init(1234)\
    \ * mint.init(5678)).val() == 0\n#  check (mint.init(1234).pow(5678)) == 0\n#\
    \  check 0 == modint(0).inv()\n#\n#  check 0 == mint.init(true.int).val()\n\n\
    ##ifndef _MSC_VER\n#\nuseStaticMontgomery(modint11, 11)\n\ntest \"ModintTest,\
    \ Inv\":\n  for i in 1..<10:\n    let x = modint11.init(i).inv().val()\n    check\
    \ 1 == (x * i) mod 11\n\n  for i in 1 ..< 100000:\n    let x = modint1000000007.init(i).inv().val()\n\
    \    check 1 == (x * i) mod 1_000_000_007\n\ntest \"ModintTest, ConstUsage\":\n\
    \  type sint = modint11\n#  type sint = StaticModInt[11]\n  const a = sint.init(9)\n\
    \  check 9 == a.val()\n  type dint = modint\n  dint.set_mod(11)\n  let b = dint.init(9)\n\
    \  check 9 == b.val()\n\ntest \"ModintTest, Increment\":\n  type sint = modint11\n\
    \  type dint = modint\n  dint.set_mod(11)\n\n  block:\n    var a = sint.init(8)\n\
    \    a.inc\n    check 9 == a.val()\n    a.inc\n    check 10 == a.val()\n    a.inc\n\
    \    check 0 == a.val()\n    a.inc\n    check 1 == a.val()\n    a = sint.init(3)\n\
    \    a.dec\n    check 2 == a.val()\n    a.dec\n    check 1 == a.val()\n    a.dec\n\
    \    check 0 == a.val()\n    a.dec\n    check 10 == a.val()\n# TODO: ++\u3068\
    inc\u306E\u4ED5\u69D8\u3092\n#    a = 8\n#    check 8 == (a.inc).val()\n#    check\
    \ 9 == (a.inc).val()\n#    check 10 == (a.inc).val()\n#    check 0 == (a.inc).val()\n\
    #    check 1 == a.val()\n#    a = 3;\n#    check 3 == (a.dec).val()\n#    check\
    \ 2 == (a.dec).val()\n#    check 1 == (a.dec).val()\n#    check 0 == (a.dec).val()\n\
    #    check 10 == a.val()\n\n  block:\n    var a = dint.init(8)\n    a.inc\n  \
    \  check 9 == a.val()\n    a.inc\n    check 10 == a.val()\n    a.inc\n    check\
    \ 0 == a.val()\n    a.inc\n    check 1 == a.val()\n    a = dint.init(3)\n    a.dec\n\
    \    check 2 == a.val()\n    a.dec\n    check 1 == a.val()\n    a.dec\n    check\
    \ 0 == a.val()\n    a.dec\n    check 10 == a.val()\n# TODO: ++\u3068inc\u306E\u4ED5\
    \u69D8\u3092\n#    a = 8\n#    check 8 == (a.inc).val()\n#    check 9 == (a.inc).val()\n\
    #    check 10 == (a.inc).val()\n#    check 0 == (a.inc).val()\n#    check 1 ==\
    \ a.val()\n#    a = 3\n#    check 3 == (a.dec).val()\n#    check 2 == (a.dec).val()\n\
    #    check 1 == (a.dec).val()\n#    check 0 == (a.dec).val()\n#    check 10 ==\
    \ a.val()\n\n# TODO: == \u6F14\u7B97\u5B50\u304C\u88AB\u308B\uFF1F\n\n\ntest \"\
    ModintTest, StaticUsage\":\n  type mint = modint11\n  check 11 == mint.mod()\n\
    # TODO: \u30D7\u30E9\u30B9\u7B26\u53F7\u304C\u306A\u3044\uFF1F\n#  check 4 ==\
    \ + mint.init(4)\n  check 7 == - mint(4)\n\n#  ASSERT_FALSE(mint(1) == mint(3));\n\
    #  ASSERT_TRUE(mint(1) != mint(3));\n#  ASSERT_TRUE(mint(1) == mint(12));\n# \
    \ ASSERT_FALSE(mint(1) != mint(12));\n  check mint(1) != mint(3)\n  check mint(1)\
    \ == mint(12)\n\n#  expect AssertionError:\n#    discard mint(3).pow(-1)\n\ntest\
    \ \"ModintTest, DynamicUsage\":\n  type mint = modint\n  mint.set_mod(3)\n  check\
    \ 3 == mint.mod()\n  check 1 == (mint.init(2) - mint.init(1)).val()\n  check 0\
    \ == (mint.init(1) + mint.init(2)).val()\n\n  mint.set_mod(11)\n  check 11 ==\
    \ mint.mod()\n  check 4 == (mint.init(3) * mint.init(5)).val()\n\n  #  # TODO:\
    \ \u30D7\u30E9\u30B9\u7B26\u53F7\u304C\u306A\u3044\uFF1F\n  ##  check 4 == +mint.init(4)\n\
    \  check 7 == -mint.init(4)\n  #\n  ##  ASSERT_FALSE(mint(1) == mint(3));\n  ##\
    \  ASSERT_TRUE(mint(1) != mint(3));\n  ##  ASSERT_TRUE(mint(1) == mint(12));\n\
    \  ##  ASSERT_FALSE(mint(1) != mint(12));\n  check mint.init(1) != mint.init(3)\n\
    \  check mint.init(1) == mint.init(12)\n\n#  expect AssertionError:\n#    discard\
    \ mint.init(3).pow(-1)\n\ntest \"ModintTest, Constructor\":\n  modint.set_mod(11)\n\
    \  check 1 == modint(true.int).val()\n  check 3 == modint((3.chr).int).val()\n\
    \  check 3 == modint.init((3).int8).val()\n  check 3 == modint.init((3).uint8).val()\n\
    \  check 3 == modint.init((3).int16).val()\n  check 3 == modint.init((3).uint16).val()\n\
    \  check 3 == modint.init((3).int32).val()\n  check 3 == modint.init((3).uint32).val()\n\
    \  check 3 == modint.init((3).int64).val()\n  check 3 == modint.init((3).uint64).val()\n\
    \  check 3 == modint.init((3).int).val()\n  check 3 == modint.init((3).uint).val()\n\
    \  check 1 == modint.init((-10).int8).val()\n  check 1 == modint.init((-10).int16).val()\n\
    \  check 1 == modint.init((-10).int32).val()\n  check 1 == modint.init((-10).int64).val()\n\
    \  check 1 == modint.init((-10).int).val()\n\n  check 2 == ((1).int32 + modint(1)).val()\n\
    \  check 2 == ((1).int16 + modint(1)).val()\n\n  var m:modint\n  check 0 == m.val()\n\
    \ntest \"ModintTest, ConstructorStatic\":\n  type mint = modint11\n\n  check 1\
    \ == mint.init(true.int).val()\n  check 3 == mint.init((3.chr).int).val()\n  check\
    \ 3 == mint.init((3).int8).val()\n  check 3 == mint.init((3).uint8).val()\n  check\
    \ 3 == mint.init((3).int16).val()\n  check 3 == mint.init((3).uint16).val()\n\
    \  check 3 == mint.init((3).int32).val()\n  check 3 == mint.init((3).uint32).val()\n\
    \  check 3 == mint.init((3).int64).val()\n  check 3 == mint.init((3).uint64).val()\n\
    \  check 3 == mint.init((3).int).val()\n  check 3 == mint.init((3).uint).val()\n\
    \  check 1 == mint.init((-10).int8).val()\n  check 1 == mint.init((-10).int16).val()\n\
    \  check 1 == mint.init((-10).int32).val()\n  check 1 == mint.init((-10).int64).val()\n\
    \  check 1 == mint.init((-10).int).val()\n\n  check 2 == ((1).int32 + mint(1)).val()\n\
    \  check 2 == ((1).int16 + mint(1)).val()\n\n  var m:mint\n  check 0 == m.val()\n\
    \n"
  dependsOn:
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/modint_montgomery.nim
  - atcoder/generate_definitions.nim
  - atcoder/extra/math/modint_montgomery.nim
  isVerificationFile: false
  path: tests/test_extra_montgomery_modint.nim
  requiredBy: []
  timestamp: '2021-07-16 23:11:44+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: tests/test_extra_montgomery_modint.nim
layout: document
redirect_from:
- /library/tests/test_extra_montgomery_modint.nim
- /library/tests/test_extra_montgomery_modint.nim.html
title: tests/test_extra_montgomery_modint.nim
---
