when not declared ATCODER_TEST_EXTRA_MONOID:
  const ATCODER_TEST_EXTRA_MONOID* = 1

  import std/unittest
  import atcoder/extra/monoid/monoid

  proc addInt(a, b: int): int {.inline.} = a + b
  proc zeroInt(): int {.inline.} = 0
  proc negInt(a: int): int {.inline.} = -a

  proc maxInt(a, b: int): int {.inline.} =
    if a < b: b else: a

  proc minIntValue(): int {.inline.} = low(int)

  type
    SumMonoid = MonoidType(int, addInt, zeroInt)
    AddGroup = MonoidType(int, addInt, zeroInt, negInt)
    MaxMonoid = MonoidType(int, maxInt, minIntValue)

  proc addMap(f, x: int): int {.inline.} = x + f

  type
    AddAction = ActedMonoidType(SumMonoid, SumMonoid, addMap)

  suite "extra monoid":
    test "MonoidType exposes value_type op and e":
      check SumMonoid.value_type is int
      check SumMonoid.op(2, 3) == 5
      check SumMonoid.e() == 0

    test "MonoidType can define another operation":
      check MaxMonoid.value_type is int
      check MaxMonoid.op(3, 10) == 10
      check MaxMonoid.op(-5, -2) == -2
      check MaxMonoid.e() == low(int)

    test "MonoidType with inverse":
      check AddGroup.value_type is int
      check AddGroup.op(10, AddGroup.inv(3)) == 7
      check AddGroup.op(5, AddGroup.inv(5)) == AddGroup.e()

    test "ActedMonoidType forwards monoid operations":
      check AddAction.S is int
      check AddAction.F is int
      check AddAction.op(2, 3) == 5
      check AddAction.e() == 0
      check AddAction.composition(4, 5) == 9
      check AddAction.id() == 0
      check AddAction.mapping(7, 10) == 17

    test "MonoidOf alias matches MonoidType":
      type AliasSum = MonoidOf(int, addInt, zeroInt)
      check AliasSum.value_type is int
      check AliasSum.op(20, 22) == 42
      check AliasSum.e() == 0

    test "GroupOf alias supports inverse":
      type AliasGroup = GroupOf(int, addInt, zeroInt, negInt)
      check AliasGroup.op(10, AliasGroup.inv(4)) == 6
      check AliasGroup.op(5, AliasGroup.inv(5)) == AliasGroup.e()

    test "ActedMonoidOf alias matches ActedMonoidType":
      type AliasAction = ActedMonoidOf(SumMonoid, SumMonoid, addMap)
      check AliasAction.op(1, 2) == 3
      check AliasAction.composition(4, 5) == 9
      check AliasAction.id() == 0
      check AliasAction.mapping(7, 10) == 17

