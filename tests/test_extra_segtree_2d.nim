
discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/extra/structure/segtree_2d

block:
  proc op(a, b: int): int = a + b
  proc e(): int = 0

  var st = initSegTree2D[int](@[
    (x: 0, y: 0),
    (x: 0, y: 1),
    (x: 1, y: 0),
    (x: 2, y: 2),
  ], op, e)

  st.add(0, 0, 5)
  st.add(0, 0, 7)
  st.add(0, 1, 3)
  st.add(1, 0, 11)
  st.add(2, 2, 13)

  doAssert st.get(0, 0) == 12
  doAssert st[0, 1] == 3
  doAssert st[1, 0] == 11
  doAssert st[2, 2] == 13

  doAssert st.prod(0..0, 0..1) == 15
  doAssert st.prod(0..1, 0..1) == 26
  doAssert st.prod(0..2, 0..2) == 39
  doAssert st[2, 2] == 13

block:
  proc op(a, b: string): string = a & b
  proc e(): string = ""

  var st = initSegTree2D[string](@[
    (x: 0, y: 0),
    (x: 1, y: 0),
    (x: 2, y: 0),
  ], op, e)

  st.add(0, 0, "A")
  st.add(1, 0, "B")
  st.add(2, 0, "C")

  doAssert st.prod(0..2, 0) == "ABC"
  doAssert st.prod(1..2, 0) == "BC"
