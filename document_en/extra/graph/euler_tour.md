# Euler Tour

`EulerTour` maps every subtree of a tree to a contiguous preorder interval.

The subtree of vertex `v` is represented by:

```text
[tin[v], tout[v])
```

This makes subtree queries compatible with Fenwick Trees and Segment Trees.

## Import and API

~~~nim
import atcoder/extra/graph/euler_tour

proc initEulerTour(
  graph: seq[seq[int]],
  root: int = 0
): EulerTour

proc subtreeRange(
  tour: EulerTour,
  v: int
): tuple[l, r: int]

proc isAncestor(tour: EulerTour, a, b: int): bool
~~~

## Complexity

- build: `O(n)`
- subtree interval: `O(1)`
- memory: `O(n)`
