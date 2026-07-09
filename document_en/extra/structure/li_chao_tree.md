# LiChaoTree

`LiChaoTree` maintains linear functions and answers minimum value queries at predefined coordinates.

This implementation is coordinate-compressed: all query coordinates are provided at initialization.

## Import

~~~nim
import atcoder/extra/structure/li_chao_tree
~~~

## Types

~~~nim
type Line[T]
type LiChaoTree[T]
~~~

## Constructor

~~~nim
proc initLine[T](a, b: T): Line[T]
proc initLiChaoTree[T](xs: seq[T], inf_val: T): LiChaoTree[T]
~~~

- `initLine(a, b)` constructs `f(x) = ax + b`.
- `initLiChaoTree(xs, inf_val)` constructs a tree over query coordinates `xs`.

## Operations

~~~nim
proc update[T](cht: var LiChaoTree[T], a, b: T)
proc update[T](cht: var LiChaoTree[T], a, b: T, r: Slice[int])
proc query[T](cht: LiChaoTree[T], k: int): T
~~~

- `update(a, b)` adds `f(x) = ax + b` globally.
- `update(a, b, r)` adds the line only to index range `r`.
- `query(k)` returns the minimum value at `xs[k]`.

## Example

~~~nim
const INF = int.high div 4

var cht = initLiChaoTree[int](@[0, 1, 2, 3, 4, 5], INF)

cht.update(2, 3)    # 2x + 3
cht.update(-1, 10)  # -x + 10
cht.update(0, 7)    # 7

doAssert cht.query(0) == 3
doAssert cht.query(5) == 5
~~~

## Complexity

For `n` coordinates:

- line insertion: `O(log n)`
- segment line insertion: `O(log^2 n)`
- query: `O(log n)`
