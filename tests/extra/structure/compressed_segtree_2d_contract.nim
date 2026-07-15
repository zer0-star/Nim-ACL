import atcoder/extra/structure/compressed_segtree_2d

proc addInt(a, b: int): int =
  a + b

proc zeroInt(): int =
  0

type
  CommutativeSum =
    CommutativeMonoidOf(
      int,
      addInt,
      zeroInt,
    )

var direct =
  initCompressedSegTree2D(
    @[
      (x: -2, y: 5),
      (x: 0, y: 0),
      (x: 0, y: 9),
      (x: 1, y: 3),
      (x: 3, y: -1),
      (x: 5, y: 5),
      (x: -2, y: 5),
    ],
    CommutativeSum,
  )

doAssert direct.pointCount == 6
doAssert direct.containsPoint(0, 0)
doAssert direct.containsPoint(0, 9)
doAssert not direct.containsPoint(0, 1)

direct.set(0, 0, 10)
direct.combineAt(0, 0, 7)
direct.combineAt((-2), 5, 3)
direct[1, 3] = 11
direct.combineAt(3, (-1), 13)
direct.set(5, 5, 17)

doAssert direct.get(0, 0) == 17
doAssert direct[1, 3] == 11

doAssert direct.prod(
  (-100),
  100,
  (-100),
  100,
) == 61

doAssert direct.prod(
  0,
  4,
  (-1),
  4,
) == 41

doAssert direct.prod(
  100,
  200,
  100,
  200,
) == 0

doAssert direct.prod(
  3,
  3,
  0,
  1,
) == 0

doAssert direct.allProd == 61

direct.set((-2), 5, 4)

doAssert direct.allProd == 62

doAssert direct.prod(
  (-100),
  100,
  (-100),
  100,
) == 62

direct.set((-2), 5, 3)

doAssert direct.allProd == 61

echo "COMPRESSED_SEGTREE_2D_DIRECT_OK"
echo "COMPRESSED_SEGTREE_2D_DUPLICATE_Y_SET_OK"
echo "COMPRESSED_SEGTREE_2D_POINT_COUNT_OK"

var builder =
  initCompressedSegTree2DBuilder()

builder.addPoint(0, 0)
builder.addPoint(0, 2)
builder.registerPoint(2, 2)

builder.addPoints(@[
  (x: 4, y: 4),
  (x: 2, y: 2),
])

var built =
  builder.build(
    CommutativeSum
  )

doAssert built.pointCount == 4

built.combineAt(0, 0, 5)
built.set(0, 2, 1)
built.set(2, 2, 7)
built.combineAt(4, 4, 11)

doAssert built.prod(
  0,
  5,
  0,
  5,
) == 24

doAssert built.allProd == 24

echo "COMPRESSED_SEGTREE_2D_BUILDER_OK"

type PairValue = object
  first: int
  second: int

proc addPair(
    a,
    b: PairValue
): PairValue =
  PairValue(
    first: a.first + b.first,
    second: a.second + b.second,
  )

proc zeroPair(): PairValue =
  PairValue()

type
  CommutativePair =
    CommutativeMonoidOf(
      PairValue,
      addPair,
      zeroPair,
    )

var genericTree =
  initCompressedSegTree2D(
    @[
      (x: 0, y: 0),
      (x: 1, y: 0),
      (x: 1, y: 1),
    ],
    CommutativePair,
  )

genericTree.set(
  0,
  0,
  PairValue(
    first: 2,
    second: 3,
  ),
)

genericTree.combineAt(
  1,
  0,
  PairValue(
    first: 5,
    second: 7,
  ),
)

genericTree.set(
  1,
  1,
  PairValue(
    first: 11,
    second: 13,
  ),
)

let genericProduct =
  genericTree.prod(
    0,
    2,
    0,
    2,
  )

doAssert genericProduct.first == 18
doAssert genericProduct.second == 23

let genericAll =
  genericTree.allProd

doAssert genericAll.first == 18
doAssert genericAll.second == 23

echo "COMPRESSED_SEGTREE_2D_GENERIC_OK"

var noPoints:
  seq[tuple[x, y: int]] = @[]

var emptyTree =
  initCompressedSegTree2D(
    noPoints,
    CommutativeSum,
  )

doAssert emptyTree.pointCount == 0
doAssert emptyTree.prod(0, 1, 0, 1) == 0
doAssert emptyTree.allProd == 0

echo "COMPRESSED_SEGTREE_2D_EMPTY_OK"
