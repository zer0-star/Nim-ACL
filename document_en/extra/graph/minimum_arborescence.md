# Minimum Arborescence

`minimumArborescence(es, vertexCount, root)` is a functional-name alias for the existing Chu–Liu/Edmonds implementation.

The historical `minimumSpanningTreeArborescence` name remains available.

## Import

~~~nim
import std/options
import atcoder/extra/graph/minimum_arborescence
~~~

## Example

~~~nim
import std/options
import atcoder/extra/graph/minimum_arborescence

let es: Edges[int, int] = @[
  initEdge[int, int](0, 1, 1),
  initEdge[int, int](0, 2, 5),
  initEdge[int, int](1, 2, 1),
  initEdge[int, int](2, 3, 1),
]

let ans = minimumArborescence(es, 4, 0)

doAssert ans.isSome
doAssert ans.get[0] == 3
~~~

Its return value and complexity are identical to `minimumSpanningTreeArborescence`.
