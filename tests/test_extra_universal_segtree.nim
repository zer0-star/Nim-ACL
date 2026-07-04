discard """
  cmd: "nim cpp -r $file"
"""

import atcoder/lazysegtree
import atcoder/extra/structure/universal_segtree

import std/unittest
import std/sequtils

proc addInt(a, b:int):int = a + b
proc zeroInt():int = 0

proc composeAdd(f, g:int):int = f + g
proc idAdd():int = 0

type SumNode = object
  sum:int
  len:int

proc initNode(x:int):SumNode =
  SumNode(sum: x, len: 1)

proc opNode(a, b:SumNode):SumNode =
  SumNode(sum: a.sum + b.sum, len: a.len + b.len)

proc eNode():SumNode =
  SumNode(sum: 0, len: 0)

proc mappingAdd(f:int, x:SumNode):SumNode =
  SumNode(sum: x.sum + f * x.len, len: x.len)

suite "UniversalSegtree basic tests":

  test "normal segtree: prod/get/set/all_prod/max_right/min_left":
    var st = universal_segtree.initSegTree[int](@[1, 2, 3, 4, 5], addInt, zeroInt)

    check st[0..<5] == 15
    check st[1..<4] == 9
    check st[2] == 3
    check st[^1] == 5
    check st[2..<2] == 0
    check st.all_prod() == 15

    check st.max_right(0, proc(x:int):bool = x <= 6) == 3
    check st.min_left(5, proc(x:int):bool = x <= 9) == 3

    st[2] = 10
    check st[0..<5] == 22
    check st[1..<4] == 16
    check st[2] == 10
    check st.all_prod() == 22

  test "lazy segtree: range add/range sum/point apply/set":
    var v = (0..<10).mapIt(initNode(it))
    var st = universal_segtree.initLazySegTree[SumNode, int](
      v, opNode, eNode, mappingAdd, composeAdd, idAdd
    )

    check st[0..<10].sum == 45
    check st[2..<7].sum == 20

    st.apply(2..<7, 10)
    check st[0..<10].sum == 95
    check st[2].sum == 12
    check st[6].sum == 16
    check st[7].sum == 7

    st.apply(4, 100)
    check st[4].sum == 114
    check st[0..<10].sum == 195

    st[4] = initNode(4)
    check st[4].sum == 4
    check st[0..<10].sum == 85

  test "lazy segtree: max_right/min_left after lazy updates":
    var v = (0..<8).mapIt(initNode(1))
    var st = universal_segtree.initLazySegTree[SumNode, int](
      v, opNode, eNode, mappingAdd, composeAdd, idAdd
    )

    st.apply(2..<6, 2)
    # values: [1, 1, 3, 3, 3, 3, 1, 1]
    check st[0..<8].sum == 16

    check st.max_right(0, proc(x:SumNode):bool = x.sum <= 8) == 4
    check st.min_left(8, proc(x:SumNode):bool = x.sum <= 8) == 4

  test "dual segtree: range apply and point apply compose":
    var st = universal_segtree.initDualSegTree[int](5, composeAdd, idAdd)

    for i in 0..<5:
      check st[i] == 0

    st.apply(0..<5, 3)
    check st[0] == 3
    check st[2] == 3
    check st[4] == 3

    st.apply(2, 4)
    check st[2] == 7
    check st[1] == 3
    check st[3] == 3

    st.set(1, 100)
    check st[1] == 100

    st.apply(1..<4, 5)
    check st[0] == 3
    check st[1] == 105
    check st[2] == 12
    check st[3] == 8
    check st[4] == 3
