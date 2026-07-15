import atcoder/extra/structure/segtree_2d

proc addInt(a, b: int): int =
  a + b

proc zeroInt(): int =
  0

var tree =
  initSegTree2D[int](
    @[
      (x: 0, y: 0),
      (x: 0, y: 1),
      (x: 1, y: 0),
      (x: 2, y: 2),
      (x: high(int), y: 0),
    ],
    addInt,
    zeroInt,
  )

tree.add(0, 0, 5)
tree.add(0, 0, 7)
tree.add(0, 1, 3)
tree.add(1, 0, 11)
tree.add(2, 2, 13)
tree.add(high(int), 0, 17)

doAssert tree.get(0, 0) == 12
doAssert tree[0, 0] == 12

doAssert tree[
  0..1,
  0..1,
] == 26

doAssert tree[
  0..<2,
  0..<2,
] == 26

doAssert tree[
  0..1,
  0,
] == 23

doAssert tree[
  0,
  0..1,
] == 15

doAssert tree[
  high(int)..high(int),
  0..0,
] == 17

doAssert tree.prod(
  0,
  2,
  0,
  2,
) == 26

tree.set(2, 2, 19)
doAssert tree.get(2, 2) == 19

echo "SEGTREE_2D_LEGACY_OK"
