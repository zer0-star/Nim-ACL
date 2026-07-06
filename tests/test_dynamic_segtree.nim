
discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/dynamic_segtree

block:
  proc op(a, b: int): int = a + b
  proc e(): int = 0

  var st = initSegTree[int](@[1, 2, 3, 4, 5], op, e)

  doAssert st.get(0) == 1
  doAssert st.get(4) == 5
  doAssert st.prod(0..4) == 15
  doAssert st.prod(1..3) == 9
  doAssert st.all_prod() == 15

  st.set(2, 10)

  doAssert st.get(2) == 10
  doAssert st.prod(0..4) == 22
  doAssert st.prod(2..2) == 10

block:
  proc op(a, b: int): int = a + b
  proc e(): int = 0

  var st = initSegTree[int](5, op, e)

  for i in 0..<5:
    st.set(i, i + 1)

  doAssert st.max_right(0, proc(x: int): bool = x <= 6) == 3
  doAssert st.min_left(5, proc(x: int): bool = x <= 9) == 3
