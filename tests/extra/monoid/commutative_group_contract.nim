import atcoder/extra/monoid/monoid

proc addInt(
    a,
    b: int
): int =
  a + b

proc zeroInt(): int =
  0

proc negateInt(
    value: int
): int =
  -value

type
  SumMonoid =
    MonoidOf(
      int,
      addInt,
      zeroInt,
    )

  AddGroup =
    GroupOf(
      int,
      addInt,
      zeroInt,
      negateInt,
    )

  TaggedAddGroup =
    CommutativeGroupType(
      AddGroup
    )

  AliasAddGroup =
    CommutativeGroupOf(
      int,
      addInt,
      zeroInt,
      negateInt,
    )

  PlainCommutativeSum =
    CommutativeMonoidOf(
      int,
      addInt,
      zeroInt,
    )

useCommutativeGroup(
  NamedAddGroup,
  int,
  addInt,
  zeroInt,
  negateInt,
)

static:
  doAssert TaggedAddGroup is CommutativeGroup
  doAssert TaggedAddGroup is CommutativeMonoid
  doAssert TaggedAddGroup is InversibleMonoid

  doAssert AliasAddGroup is CommutativeGroup
  doAssert NamedAddGroup is CommutativeGroup

  doAssert PlainCommutativeSum is CommutativeMonoid

  doAssert not (
    PlainCommutativeSum is CommutativeGroup
  )

  doAssert not compiles(
    CommutativeGroupType(
      SumMonoid
    )
  )

doAssert TaggedAddGroup.op(
  10,
  TaggedAddGroup.inv(7),
) == 3

doAssert AliasAddGroup.op(
  5,
  AliasAddGroup.inv(5),
) == AliasAddGroup.e()

doAssert NamedAddGroup.op(
  20,
  NamedAddGroup.inv(8),
) == 12

doAssert not compiles(
  PlainCommutativeSum.inv(
    1
  )
)

echo "COMMUTATIVE_GROUP_CONTRACT_OK"
