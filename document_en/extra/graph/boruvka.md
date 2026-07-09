# Boruvka

`Boruvka` is a helper structure for computing the minimum spanning tree cost by repeatedly selecting the cheapest outgoing edge from each connected component.

Instead of passing all edges directly to the library, you provide an `update` callback that fills the best outgoing edge for each current DSU component. This is useful not only for ordinary undirected graphs but also for problems where candidate edges are generated dynamically.

## Import

~~~nim
import atcoder/extra/graph/boruvka
~~~

## Example

~~~nim
import atcoder/extra/graph/boruvka

let edges = @[
  (0, 1, 1),
  (1, 2, 2),
  (0, 2, 5),
  (2, 3, 1),
  (1, 3, 4),
]

var b = initBoruvka[int](4)

let cost = b.build(proc(best: var seq[(int, int)]) =
  for (u, v, w) in edges:
    let ru = b.find(u)
    let rv = b.find(v)

    if ru == rv:
      continue

    if w < best[ru][0]:
      best[ru] = (w, rv)

    if w < best[rv][0]:
      best[rv] = (w, ru)
)

doAssert cost == 4
~~~

## Callback

~~~nim
proc(best: var seq[(T, int)])
~~~

Set `best[leader]` to `(cost, otherLeader)` for the cheapest outgoing edge of the component.

A component with `otherLeader == -1` is not merged in that iteration.

## Disconnected graph

If all vertices cannot be connected, `build` returns the `inf` value passed to `initBoruvka`.

~~~nim
let inf = 1_000_000_000
var b = initBoruvka[int](n, inf)
~~~

## Complexity

If each `update` iteration scans all candidate edges once, the running time is roughly:

- `O(m log n)`

where `n` is the number of vertices and `m` is the number of candidate edges.
