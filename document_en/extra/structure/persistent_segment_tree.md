# Persistent Segment Tree

A persistent segment tree creates a new version without modifying previous versions.

Like Nim-ACL's standard `SegTree`, the canonical API obtains the monoid operation `op` and identity `e` from a static generic tuple.

## Recommended API

<!-- PST_CANONICAL_FACTORY_API -->

Use `PersistentSegTreeType` for normal code. Like the standard
`SegTreeType`, it wraps `op` and `e` in distinct
`{.gensym, inline.}` procedures, allowing multiple monoids to coexist
safely in one program.

```nim
proc addInt(
    left,
    right: int,
): int =
  left + right

proc zeroInt(): int =
  0

type
  SumPersistentSegTree =
    PersistentSegTreeType[int](
      addInt,
      zeroInt,
    )

var tree =
  SumPersistentSegTree.init(
    @[1, 2, 3, 4],
    expectedUpdates = 100,
  )
```

The shorthand constructor uses the same factory internally.

```nim
var tree =
  initPersistentSegmentTree(
    @[1, 2, 3, 4],
    addInt,
    zeroInt,
    expectedUpdates = 100,
  )
```

For the length-only form, the element type is inferred from the return
type of `e()`, and every initial value is `e()`.

```nim
var tree =
  initPersistentSegmentTree(
    200_000,
    addInt,
    zeroInt,
    expectedUpdates = 200_000,
  )
```

### Raw static tuple form

<!-- PST_RAW_TUPLE_LOW_LEVEL_WARNING -->

`PersistentSegTree[S, (op: ..., e: ...)]` is a low-level API.

In Nim, storing multiple different anonymous procedures with the same
signature directly in raw static tuples may cause a later type to reuse
the first procedure. In an isolated test, separately defined sum and max
trees both used the sum operation.

Use `PersistentSegTreeType` or `initPersistentSegmentTree` for normal
code.

## Import

~~~nim
import atcoder/extra/structure/persistent_segment_tree
~~~

## Monoid

~~~nim
proc addInt(
  left,
  right: int,
): int =
  left + right

proc zeroInt(): int =
  0
~~~

## Construction

~~~nim
var tree =
  PersistentSegTree[
    int,
    (
      op: addInt,
      e: zeroInt,
    ),
  ].init(
    @[1, 2, 3, 4],
    expectedUpdates = 100,
  )
~~~

Passing only a length initializes every position with `e()`.

~~~nim
var tree =
  PersistentSegTree[
    int,
    (
      op: addInt,
      e: zeroInt,
    ),
  ].init(
    200_000,
    expectedUpdates = 200_000,
  )
~~~

The following shorthand generates the same static generic type.

~~~nim
var tree = initPersistentSegmentTree(
  @[1, 2, 3, 4],
  addInt,
  zeroInt,
  expectedUpdates = 100,
)
~~~

## Versions

~~~nim
let version0 = tree.initialVersion
~~~

Versions use the distinct `PersistentVersion` type. This helps detect accidental mixing of versions with positions or range endpoints.

## Point assignment

~~~nim
let version1 = tree.set(
  1,
  20,
  version0,
)
~~~

The argument order follows the standard segment-tree API:

```text
position, value, version
```

`version0` remains unchanged.

## Point access

~~~nim
echo tree.get(
  1,
  version1,
)
~~~

The argument order is:

```text
position, version
```

## Range product

~~~nim
echo tree.prod(
  1 ..< 4,
  version1,
)
~~~

The explicit half-open form is also available.

~~~nim
echo tree.prod(
  1,
  4,
  version1,
)
~~~

The range or endpoints come first and the version comes last.

## Whole-array product

~~~nim
echo tree.allProd(version1)
~~~

Nim identifiers are style-insensitive, so `all_prod` resolves to the same procedure.

## Materialization

~~~nim
let values = tree.toSeq(version1)
~~~

This is mainly useful for debugging and small checks. It takes \(O(N\log N)\).

## `expectedUpdates`

<!-- NIM_ACL_TUNING_PARAMETER: expectedUpdates -->

| Item | Description |
|---|---|
| Meaning | An estimate of the number of future point updates. It is not a limit on versions or updates. |
| Preallocation | It reserves capacity for the internal node pool and reduces reallocations while updating. |
| Correctness | It is only a capacity hint, so it does not affect correctness. |
| Too small | The sequence grows automatically. More reallocations and copies may occur. |
| Too large | Unused capacity may increase memory consumption. |
| Default | The default is `0`, which preallocates only the capacity required by the initial tree. |

Let `size` be the smallest power of two at least \(N\), and let \(h=\log_2(\mathrm{size})\). The initial node-pool capacity is

\[
2\mathrm{size}
+
\mathrm{expectedUpdates}(h+1).
\]

Each point update copies the root-to-leaf path and therefore appends exactly \(h+1\) nodes.

## Complexity

For an initial length \(N\) and \(U\) updates:

- construction: \(O(N)\)
- `set`: \(O(\log N)\)
- `get`: \(O(\log N)\)
- `prod`: \(O(\log N)\)
- `allProd`: \(O(1)\)
- retaining or copying a version: \(O(1)\)
- node count: \(O(N+U\log N)\)

## Legacy runtime API

For compatibility, the previous API that stores runtime `identity` and closure `op` values and accepts a raw root integer first remains available.

New code should prefer the static generic API for consistency with `SegTree` and safer argument ordering.
