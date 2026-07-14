import atcoder/extra/structure/monoid_segtree


type Affine = tuple[
  a: int,
  b: int,
]


proc minInt(a, b: int): int =
  min(a, b)


proc minIdentity(): int =
  high(int)


proc maxInt(a, b: int): int =
  max(a, b)


proc maxIdentity(): int =
  low(int)


proc addInt(a, b: int): int =
  a + b


proc zeroInt(): int =
  0


proc composeAffine(
    f,
    g: Affine
): Affine =
  (
    a: f.a * g.a,
    b: f.a * g.b + f.b,
  )


proc affineIdentity(): Affine =
  (
    a: 1,
    b: 0,
  )


proc affineMapping(
    f: Affine,
    x: int
): int =
  if x == low(int):
    low(int)
  else:
    f.a * x + f.b


useMonoid(
  SplitMinMonoidProbe,
  int,
  minInt,
  minIdentity,
)

useMonoid(
  SplitMaxMonoidProbe,
  int,
  maxInt,
  maxIdentity,
)

useMonoid(
  SplitSumMonoidProbe,
  int,
  addInt,
  zeroInt,
)

useMonoid(
  SplitAffineMonoidProbe,
  Affine,
  composeAffine,
  affineIdentity,
)


useActionMonoid(
  SplitAffineMaxActionProbe,
  SplitAffineMonoidProbe,
  SplitMaxMonoidProbe,
  affineMapping,
)


useActedMonoid(
  SplitOldAffineMaxProbe,
  SplitMaxMonoidProbe,
  SplitAffineMonoidProbe,
  affineMapping,
)


block:
  var tree = initSegTree(
    SplitMinMonoidProbe,
    @[8, 3, 5],
  )

  doAssert tree.prod(0..<3) == 3

  tree.set(1, 7)

  doAssert tree.get(1) == 7
  doAssert tree.prod(0..2) == 5

  echo "SEGTREE_DESCRIPTOR_OK"
  echo "SEGTREE_RANGE_OK"


block:
  var tree = SplitMinMonoidProbe.initSegTree(
    @[4, 9, 2],
  )

  doAssert tree.prod(0..<3) == 2

  echo "SEGTREE_UFCS_OK"


block:
  var tree = initSegTree(
    SplitMinMonoidProbe,
    4,
  )

  doAssert tree.prod(0..<4) == high(int)

  echo "SEGTREE_LENGTH_IDENTITY_OK"


block:
  var tree = segtree.initSegTree[int](
    @[1, 2, 3],
    addInt,
    zeroInt,
  )

  doAssert tree.prod(0..<3) == 6

  echo "SEGTREE_CALLBACK_OK"


block:
  var tree = initLazySegTree(
    SplitAffineMaxActionProbe,
    @[1, 2],
  )

  let g: Affine = (
    a: 2,
    b: 1,
  )

  let f: Affine = (
    a: 3,
    b: 4,
  )

  tree.apply(0..<2, g)
  tree.apply(0..<2, f)

  doAssert tree.get(0) == 13
  doAssert tree.get(1) == 19
  doAssert tree.prod(0..1) == 19

  echo "LAZY_DESCRIPTOR_OK"
  echo "LAZY_RANGE_OK"
  echo "NONCOMMUTATIVE_COMPOSITION_OK"


block:
  var tree = SplitAffineMaxActionProbe.initLazySegTree(
    @[2, 4],
  )

  let f: Affine = (
    a: 2,
    b: 3,
  )

  tree.apply(0..<1, f)

  doAssert tree.get(0) == 7

  echo "LAZY_UFCS_OK"


block:
  var tree = initLazySegTree(
    SplitAffineMaxActionProbe,
    3,
  )

  doAssert tree.prod(0..<3) == low(int)

  tree.set(0, 5)

  doAssert tree.get(0) == 5

  echo "LAZY_LENGTH_IDENTITY_OK"


block:
  var tree = SplitOldAffineMaxProbe.initLazySegTree(
    @[1, 2],
  )

  let f: Affine = (
    a: 2,
    b: 1,
  )

  tree.apply(0..<2, f)

  doAssert tree.get(0) == 3
  doAssert tree.get(1) == 5

  echo "LAZY_LEGACY_DESCRIPTOR_OK"


block:
  proc op(a, b: int): int =
    max(a, b)

  proc e(): int =
    low(int)

  proc mapping(
      f: Affine,
      x: int
  ): int =
    affineMapping(f, x)

  proc composition(
      f,
      g: Affine
  ): Affine =
    composeAffine(f, g)

  proc id(): Affine =
    affineIdentity()

  template callbackTree(
      values: seq[int]
  ): untyped =
    when compiles(
      lazysegtree.initLazySegTree[int, Affine](
        values,
        op,
        e,
        mapping,
        composition,
        id,
      )
    ):
      lazysegtree.initLazySegTree[int, Affine](
        values,
        op,
        e,
        mapping,
        composition,
        id,
      )

    elif compiles(
      lazysegtree.initLazySegTree(
        values,
        op,
        e,
        mapping,
        composition,
        id,
      )
    ):
      lazysegtree.initLazySegTree(
        values,
        op,
        e,
        mapping,
        composition,
        id,
      )

    elif compiles(
      lazysegtree.initLazySegTree[int, Affine](
        op,
        e,
        mapping,
        composition,
        id,
        values,
      )
    ):
      lazysegtree.initLazySegTree[int, Affine](
        op,
        e,
        mapping,
        composition,
        id,
        values,
      )

    else:
      {.error:
        "no compatible callback constructor"
      .}

  var tree = callbackTree(@[1, 2])

  let f: Affine = (
    a: 2,
    b: 1,
  )

  tree.apply(0..<2, f)

  doAssert tree.prod(0..<2) == 5

  echo "LAZY_CALLBACK_OK"


echo "MONOID_SEGTREE_SPLIT_FACADE_OK"
