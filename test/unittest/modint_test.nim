import atcoder/modint as modint_lib
import std/math
import std/unittest

static:
  assert StaticModInt[1].isModInt
  assert StaticModInt[998244353].isModInt
  assert modint.isModInt
  assert DynamicModInt[0].isModInt
  assert not int.isModInt

  assert StaticModInt[1].is_static_modint
  assert StaticModInt[998244353].is_static_modint
  assert modint998244353.is_static_modint
  assert modint1000000007.is_static_modint
  assert not modint.is_static_modint
  assert not DynamicModInt[0].is_static_modint
  assert not int.is_static_modint

  assert not StaticModInt[1].is_dynamic_modint
  assert not StaticModInt[998244353].is_dynamic_modint

  assert modint.is_dynamic_modint
  assert DynamicModInt[0].is_dynamic_modint
  assert not int.is_dynamic_modint

  assert modint is DynamicModInt[-1]

  assert modint998244353.mod() == 998244353
  assert modint1000000007.mod() == 1000000007

test "ModintTest, DynamicBorder":
  type mint = modint
  const mod_upper = int32.high
  for m in countdown(mod_upper, mod_upper - 20'i32):
    mint.set_mod(m)
    var v = newSeq[int]()
    for i in 0..<10: 
      v.add(i)
      v.add(m.int - i)
      v.add(m.int div 2 + i)
      v.add(m.int div 2 - i)
    for a in v:
      check ((a * a) mod m * a) mod m == (mint.init(a).pow(3)).val()
      for b in v:
        check (a + b) mod m == (mint.init(a) + mint.init(b)).val()
        check (a - b + m) mod m == (mint.init(a) - mint.init(b)).val()
        check (a * b) mod m == (mint.init(a) * mint.init(b)).val()

test "ModintTest, ULL":
  modint.set_mod(998244353)
  let m1 = 0'u - 1'u
  check modint.mod() - 1 != modint.init(m1).val()
  check 0 != (m1 + modint.init(1)).val()
  type mint = StaticModInt[998244353]
  check mint.mod() - 1 != modint.init(m1).val()
  check 0 != (m1 + mint.init(1)).val()

test "ModintTest, Mod1":
  modint.set_mod(1)
  for i in 0..<100:
    for j in 0..<100:
      check (modint.init(i) * modint.init(j)).val() == 0
  check (modint.init(1234) + modint.init(5678)).val() == 0
  check (modint.init(1234) - modint.init(5678)).val() == 0
  check (modint.init(1234) * modint.init(5678)).val() == 0
  check (modint.init(1234).pow(5678)) == 0
  check 0 == modint.init(0).inv()

  check 0 == modint.init(true.int).val()

  type mint = StaticModInt[1]
  for i in 0..<100:
    for j in 0..<100:
      check (mint(i) * mint(j)).val() == 0
  check (mint.init(1234) + mint.init(5678)).val() == 0
  check (mint.init(1234) - mint.init(5678)).val() == 0
  check (mint.init(1234) * mint.init(5678)).val() == 0
  check (mint.init(1234).pow(5678)) == 0
  check 0 == modint(0).inv()

  check 0 == mint.init(true.int).val()

##ifndef _MSC_VER
#
#TEST(ModintTest, Int128) {
#  modint.set_mod(998244353);
#  check 12345678, modint(__int128_t(12345678)).val());
#  check 12345678, modint(__uint128_t(12345678)).val());
#  check 12345678, modint(__int128(12345678)).val());
#  check 12345678, modint((unsigned __int128)(12345678)).val());
#  check modint(2).pow(100).val(), modint(__int128_t(1) << 100).val());
#  check modint(2).pow(100).val(), modint(__uint128_t(1) << 100).val());
#  type mint = static_modint<998244353>;
#  check 12345678, mint(__int128_t(12345678)).val());
#  check 12345678, mint(__uint128_t(12345678)).val());
#  check 12345678, mint(__int128(12345678)).val());
#  check 12345678, mint((unsigned __int128)(12345678)).val());
#  check mint(2).pow(100).val(), mint(__int128_t(1) << 100).val());
#  check mint(2).pow(100).val(), mint(__uint128_t(1) << 100).val());
#}
#
##endif
#
test "ModintTest, Inv":
  for i in 1..<10:
    let x = StaticModInt[11].init(i).inv().val()
    check 1 == (x * i) mod 11

  for i in 1..<11:
    if gcd(i, 12) != 1: continue
    let x = StaticModInt[12](i).inv().val()
    check 1 == (x * i) mod 12

  for i in 1 ..< 100000:
    let x = StaticModInt[1_000_000_007].init(i).inv().val()
    check 1 == (x * i) mod 1_000_000_007

  for i in 1 ..< 100000:
    if gcd(i, 1_000_000_008) != 1: continue
    let x = StaticModInt[1_000_000_008].init(i).inv().val()
    check 1 == (x * i) mod 1_000_000_008

  modint.set_mod(998244353)
  for i in 1 ..< 100000:
    let x = modint.init(i).inv().val()
    check 0 <= x
    check 998244353 - 1 >= x
    check 1 == x * i mod 998244353

  modint.set_mod(1_000_000_008)
  for i in 1 ..< 100000:
    if gcd(i, 1_000_000_008) != 1: continue
    let x = modint.init(i).inv().val()
    check 1 == (x * i) mod 1_000_000_008

test "ModintTest, ConstUsage":
  type sint = StaticModInt[11]
  const a = sint.init(9)
  check 9 == a.val()
  type dint = modint
  dint.set_mod(11)
  let b = dint.init(9)
  check 9 == b.val()

# TODO: inc, decはくせものである
#test "ModintTest, Increment":
#  type sint = StaticModInt[11]
#  type dint = modint
#  dint.set_mod(11)
#
#  block:
#    var a = sint.init(8)
#    a.inc
#    check 9 == a.val()
#    a.inc
#    check 10 == a.val()
#    a.inc
#    check 0 == a.val()
#    a.inc
#    check 1 == a.val()
#    a = sint.init(3)
#    a.dec
#    check 2 == a.val()
#    a.dec
#    check 1 == a.val()
#    a.dec
#    check 0 == a.val()
#    a.dec
#    check 10 == a.val()
## TODO:
##    a = 8
##    check 8, (a++).val());
##    check 9, (a++).val());
##    check 10, (a++).val());
##    check 0, (a++).val());
##    check 1, a.val());
##    a = 3;
##    check 3, (a--).val());
##    check 2, (a--).val());
##    check 1, (a--).val());
##    check 0, (a--).val());
##    check 10, a.val());
#
#  block:
#    var a = dint.init(8)
#    a.inc
#    check 9 == a.val()
#    a.inc
#    check 10 == a.val()
#    a.inc
#    check 0 == a.val()
#    a.inc
#    check 1 == a.val()
#    a = dint.init(3)
#    a.dec
#    check 2 == a.val()
#    a.dec
#    check 1 == a.val()
#    a.dec
#    check 0 == a.val()
#    a.dec
#    check 10 == a.val()
## TODO:
##    a = 8;
##    check 8, (a++).val());
##    check 9, (a++).val());
##    check 10, (a++).val());
##    check 0, (a++).val());
##    check 1, a.val());
##    a = 3;
##    check 3, (a--).val());
##    check 2, (a--).val());
##    check 1, (a--).val());
##    check 0, (a--).val());
##    check 10, a.val());

test "ModintTest, StaticUsage":
  type mint = StaticModInt[11]
  check 11 == mint.mod()
# TODO: プラス符号がない？
#  check 4 == + mint.init(4)
  check 7 == - mint.init(4)

#  ASSERT_FALSE(mint(1) == mint(3));
#  ASSERT_TRUE(mint(1) != mint(3));
#  ASSERT_TRUE(mint(1) == mint(12));
#  ASSERT_FALSE(mint(1) != mint(12));
  check mint.init(1) != mint.init(3)
  check mint.init(1) == mint.init(12)

  expect AssertionError:
    discard mint(3).pow(-1)

test "ModintTest, DynamicUsage":
  check 998244353 == DynamicModInt[12345].mod()
  type mint = modint
  mint.set_mod(998244353)
  check 998244353 == mint.mod()
  check 3 == (mint.init(1) + mint.init(2)).val()
  check 3 == (1 + mint.init(2)).val()
  check 3 == (mint.init(1) + 2).val()

  mint.set_mod(3)
  check 3 == mint.mod()
  check 1 == (mint.init(2) - mint.init(1)).val()
  check 0 == (mint.init(1) + mint.init(2)).val()

  mint.set_mod(11)
  check 11 == mint.mod()
  check 4 == (mint.init(3) * mint.init(5)).val()

  # TODO: プラス符号がない？
#  check 4 == +mint.init(4)
  check 7 == -mint.init(4)

#  ASSERT_FALSE(mint(1) == mint(3));
#  ASSERT_TRUE(mint(1) != mint(3));
#  ASSERT_TRUE(mint(1) == mint(12));
#  ASSERT_FALSE(mint(1) != mint(12));
  check mint.init(1) != mint.init(3)
  check mint.init(1) == mint.init(12)

  expect AssertionError:
    discard mint.init(3).pow(-1)

test "ModintTest, Constructor":
  modint.set_mod(11)
  check 1 == modint(true.int).val()
  check 3 == modint((3.chr).int).val()
  check 3 == modint.init((3).int8).val()
  check 3 == modint.init((3).uint8).val()
  check 3 == modint.init((3).int16).val()
  check 3 == modint.init((3).uint16).val()
  check 3 == modint.init((3).int32).val()
  check 3 == modint.init((3).uint32).val()
  check 3 == modint.init((3).int64).val()
  check 3 == modint.init((3).uint64).val()
  check 3 == modint.init((3).int).val()
  check 3 == modint.init((3).uint).val()
  check 1 == modint.init((-10).int8).val()
  check 1 == modint.init((-10).int16).val()
  check 1 == modint.init((-10).int32).val()
  check 1 == modint.init((-10).int64).val()
  check 1 == modint.init((-10).int).val()

  check 2 == ((1).int32 + modint(1)).val()
  check 2 == ((1).int16 + modint(1)).val()

  var m:modint
  check 0 == m.val()

test "ModintTest, ConstructorStatic":
  type mint = StaticModInt[11]

  check 1 == modint(true.int).val()
  check 3 == modint((3.chr).int).val()
  check 3 == modint.init((3).int8).val()
  check 3 == modint.init((3).uint8).val()
  check 3 == modint.init((3).int16).val()
  check 3 == modint.init((3).uint16).val()
  check 3 == modint.init((3).int32).val()
  check 3 == modint.init((3).uint32).val()
  check 3 == modint.init((3).int64).val()
  check 3 == modint.init((3).uint64).val()
  check 3 == modint.init((3).int).val()
  check 3 == modint.init((3).uint).val()
  check 1 == modint.init((-10).int8).val()
  check 1 == modint.init((-10).int16).val()
  check 1 == modint.init((-10).int32).val()
  check 1 == modint.init((-10).int64).val()
  check 1 == modint.init((-10).int).val()

  check 2 == ((1).int32 + modint(1)).val()
  check 2 == ((1).int16 + modint(1)).val()

  var m:mint
  check 0 == m.val()

