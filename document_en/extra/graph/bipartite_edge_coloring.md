# Bipartite Edge Coloring

Colors every edge of a bipartite multigraph so that edges incident to the same
vertex receive different colors. The number of colors is the maximum degree
`Δ`, and is therefore optimal.

Parallel edges are supported.

## General form

~~~nim
let colors =
  bipartiteEdgeColoring(
    leftCount,
    rightCount,
    edges,
  )
~~~

## Parameters

- `leftCount`: number of left-side vertices
- `rightCount`: number of right-side vertices
- `edges`: edge sequence; each edge is represented by `(left, right)`

Left vertices are numbered `0 ..< leftCount`, and right vertices are numbered
`0 ..< rightCount`.

The input order of `edges` is preserved, and the input is not modified.

## Preconditions

- `leftCount >= 0`
- `rightCount >= 0`
- every edge `(left, right)` satisfies
  `0 <= left < leftCount`
- every edge `(left, right)` satisfies
  `0 <= right < rightCount`

Negative vertex counts or out-of-range endpoints raise `ValueError`.

## Return value

The result is a `seq[int]` with the same length as `edges`.

~~~nim
colors[edgeId]
~~~

is the color assigned to `edges[edgeId]`.

When at least one edge exists, all colors in

~~~text
0 ..< Δ
~~~

are used, where `Δ` is the maximum degree of the bipartite multigraph.
No two edges incident to the same vertex receive the same color.

An empty graph produces an empty sequence.

## Example

~~~nim
import atcoder/extra/graph/bipartite_edge_coloring

let edges =
  @[
    (0, 0),
    (0, 1),
    (1, 0),
  ]

let colors =
  bipartiteEdgeColoring(
    2,
    2,
    edges,
  )

doAssert colors.len == edges.len
doAssert colors[0] != colors[1]
doAssert colors[0] != colors[2]
~~~

Color numbers are not unique, so programs should not depend on one particular
color sequence.

## Related APIs

- `HopcroftKarp`: maximum matching in a bipartite graph
- `EulerianTrail`: enumeration of Eulerian trails and circuits

Internally, both sides are padded to the same number of vertices, and dummy
edges make the graph `Δ`-regular. The implementation then removes `Δ` perfect
matchings. Multiplicities of parallel dummy edges are compressed instead of
being stored edge by edge.

## Complexity

Let `N = max(leftCount, rightCount)`, `M = edges.len`, and let `Δ` be the
maximum degree.

- Time: `O(Δ (M + N) sqrt(N))`
- Memory: `O(M + N)`

This bound follows from the internal Hopcroft–Karp implementation.
