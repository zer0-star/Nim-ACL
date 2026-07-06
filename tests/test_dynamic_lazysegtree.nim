
discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/dynamic_lazysegtree

type Node = tuple[sum: int, len: int]

proc op(a, b: Node): Node =
  (sum: a.sum + b.sum, len: a.len + b.len)

proc e(): Node =
  (sum: 0, len: 0)

proc mapping(f: int, x: Node): Node =
  (sum: x.sum + f * x.len, len: x.len)

proc composition(f, g: int): int =
  f + g

proc id(): int =
  0

block:
  var st = init_lazy_segtree[Node, int](
    @[
      (sum: 1, len: 1),
      (sum: 2, len: 1),
      (sum: 3, len: 1),
      (sum: 4, len: 1),
      (sum: 5, len: 1),
    ],
    op,
    e,
    mapping,
    composition,
    id
  )

  doAssert st.prod(0..4).sum == 15
  doAssert st.get(2).sum == 3

  st.apply(1..3, 10)

  doAssert st.get(0).sum == 1
  doAssert st.get(1).sum == 12
  doAssert st.get(2).sum == 13
  doAssert st.get(3).sum == 14
  doAssert st.get(4).sum == 5
  doAssert st.prod(0..4).sum == 45
  doAssert st.prod(1..3).sum == 39

  st.apply(2, -5)

  doAssert st.get(2).sum == 8
  doAssert st.prod(0..4).sum == 40

  st.set(4, (sum: 100, len: 1))

  doAssert st.get(4).sum == 100
  doAssert st.all_prod().sum == 135

block:
  var st = init_lazy_segtree[Node, int](
    6,
    op,
    e,
    mapping,
    composition,
    id
  )

  for i in 0..<6:
    st.set(i, (sum: i + 1, len: 1))

  st.apply(0..5, 1)

  doAssert st.prod(0..5).sum == 27
  doAssert st.max_right(0, proc(x: Node): bool = x.sum <= 10) == 3
  doAssert st.min_left(6, proc(x: Node): bool = x.sum <= 15) == 4
