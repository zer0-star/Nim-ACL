# SegTree2D

`SegTree2D` stores values on two-dimensional points and answers rectangle aggregate queries.

All points that may appear must be provided beforehand. Coordinates are compressed internally.

## Import

~~~nim
import atcoder/extra/structure/segtree_2d
~~~

## Type

~~~nim
type SegTree2D[S, SegTree]
~~~

Usually, construct it with `initSegTree2D`.

## Constructor

~~~nim
proc initSegTree2D[S](
  points: seq[tuple[x, y: int]],
  op: static[proc(a, b: S): S],
  e: static[proc(): S]
): auto
~~~

- `points`: all points that may be used
- `op`: aggregate operation
- `e`: identity element

## Operations

~~~nim
proc add[ST: SegTree2D](st: var ST, x, y: int, v: ST.S)
proc get[ST: SegTree2D](st: var ST, x, y: int): ST.S
proc prod[ST: SegTree2D](st: var ST, xp, yp: Slice[int] or int): ST.S
proc `[]`[ST: SegTree2D](st: var ST, x, y: int): ST.S
proc `[]`[ST: SegTree2D](st: var ST, xp, yp: Slice[int] or int): ST.S
~~~

- `add(x, y, v)` adds `v` to point `(x, y)`.
- `get(x, y)` returns the value at point `(x, y)`.
- `prod(xp, yp)` returns the aggregate over rectangle `xp × yp`.

## Example

~~~nim
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
doAssert st.prod(0 .. 1, 0 .. 1) == 26
doAssert st.prod(0 .. 2, 0 .. 2) == 39
~~~

## Constraints

Points used in `add`, `get`, and `prod` must be included in the initial point set.

## Complexity

For `n` points:

- build: `O(n log n)`
- point add: `O(log^2 n)`
- point get: `O(log^2 n)`
- rectangle query: `O(log^2 n)`
