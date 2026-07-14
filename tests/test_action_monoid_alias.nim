import atcoder/extra/monoid/monoid


proc addInt(a, b: int): int =
  a + b


proc zeroInt(): int =
  0


proc mappingAdd(f, x: int): int =
  f + x


useMonoid(
  AliasValueMonoidProbe,
  int,
  addInt,
  zeroInt,
)

useMonoid(
  AliasActionMonoidProbe,
  int,
  addInt,
  zeroInt,
)

useActedMonoid(
  AliasOldOrderProbe,
  AliasValueMonoidProbe,
  AliasActionMonoidProbe,
  mappingAdd,
)

useActionMonoid(
  AliasNewOrderProbe,
  AliasActionMonoidProbe,
  AliasValueMonoidProbe,
  mappingAdd,
)


echo "USE_ACTION_MONOID_DIRECT_IMPORT_OK"
echo "PUBLIC_F_BEFORE_S_OK"
echo "LEGACY_S_BEFORE_F_OK"
