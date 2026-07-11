# Persistent Segment Tree

One tree owns all nodes, while each `PersistentVersion` identifies a root.

Copy a sequence by copying its version rather than its elements.

```nim
versions[x] = versions[y]
```

## Initialization

The general form is:

```nim
type Tree =
  PersistentSegTreeType[S](
    op,
    e,
  )

var tree =
  Tree.init(
    valuesOrLength,
    expectedUpdates = 0,
  )
```

- `S`: element and aggregate type
- `op(left, right)`: combines the left and right aggregates
- `e()`: returns the identity element of `op`
- `valuesOrLength`: initial sequence or initial length
- `expectedUpdates`: estimated number of point updates

For a sum monoid, `op` and `e` can be defined as follows.

```nim
proc op(
    left,
    right: int,
): int =
  left + right

proc e(): int =
  0
```

Pass these definitions to the general form.

```nim
type SumTree =
  PersistentSegTreeType[int](
    op,
    e,
  )

var tree =
  SumTree.init(
    n,
    expectedUpdates = q,
  )
```

Passing only a length initializes every element with `e()`.

The shorthand constructor is also available.

```nim
var tree =
  initPersistentSegmentTree(
    n,
    op,
    e,
    expectedUpdates = q,
  )
```

## Initial version

```nim
let version =
  tree.initialVersion
```

A version is a lightweight root identifier.

## Point update

The general form is:

```nim
newVersion =
  tree.set(
    version,
    position,
    value,
  )
```

- `version`: source version
- `position`: updated index
- `value`: new value
- return value: newly created version

The source version remains unchanged.

```nim
versions[x] =
  tree.set(
    versions[x],
    y,
    z,
  )
```

The indexing form updates the supplied version variable.

```nim
tree[version][position] = value
```

or:

```nim
tree[version, position] = value
```

## Point access

The general form is:

```nim
value =
  tree.get(
    version,
    position,
  )
```

- `version`: queried version
- `position`: queried index

Indexing forms:

```nim
value = tree[version][position]
```

or:

```nim
value = tree[version, position]
```

## Range product

The general form is:

```nim
answer =
  tree.prod(
    version,
    range,
  )
```

- `version`: queried version
- `range`: aggregated range

Half-open endpoints can be supplied directly.

```nim
answer =
  tree.prod(
    version,
    left,
    right,
  )
```

Indexing forms:

```nim
answer = tree[version][left ..< right]
```

or:

```nim
answer = tree[version, left ..< right]
```

## Whole-tree product

```nim
answer =
  tree.allProd(
    version
  )
```

## Restore a sequence

```nim
values =
  tree.toSeq(
    version
  )
```

This takes `O(n log n)` time and is mainly useful for debugging.

## Version views

`tree[version]` is a temporary view referencing both the tree and version.

```nim
tree[version][position] = value
answer = tree[version][range]
```

A view may be stored in a variable, but must not outlive its tree or version.

## expectedUpdates

<!-- NACL_EXPECTED_UPDATES_SECTION_START -->
<!-- NIM_ACL_TUNING_PARAMETER: expectedUpdates -->

- expectedUpdates: Meaning — estimates the number of future point updates.
- expectedUpdates: Default — the default value is `0`.
- expectedUpdates: Correctness — it does not affect results or the number of versions that can be created.
- expectedUpdates: If too small — node storage grows automatically and results remain correct.
- expectedUpdates: If too large — additional unused capacity is reserved.
- expectedUpdates: Memory — it is used only to preallocate initial node capacity.
- With tree height `h`, every point update creates exactly `h + 1` nodes.
- Initial capacity is approximately `2 * size + expectedUpdates * (h + 1)`.

<!-- NACL_EXPECTED_UPDATES_SECTION_END -->

## Raw static tuple form

`PersistentSegTree[S, (op: ..., e: ...)]` is a low-level API.

When multiple anonymous procedures with the same signature are passed
directly through raw static tuples, Nim may reuse the first procedure for
later types.

Use `PersistentSegTreeType` or `initPersistentSegmentTree` for normal code.

## Complexity

- Initialization: `O(n)`
- Version copy: `O(1)`
- Point update: `O(log n)` time and `O(log n)` additional memory
- Point access: `O(log n)`
- Range product: `O(log n)`
- Whole-tree product: `O(1)`
