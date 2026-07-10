# Persistent Segment Tree

`PersistentSegmentTree` preserves old versions after point updates.

Only nodes on the root-to-leaf update path are copied. Unchanged subtrees are shared between versions.

## Import and API

~~~nim
import atcoder/extra/structure/persistent_segment_tree

proc initPersistentSegmentTree(values, identity, op): PersistentSegmentTree

proc setValue(
  tree: var PersistentSegmentTree,
  root, position: int,
  value
): int

proc prod(tree, root, l, r: int): T
~~~

Each version is represented by a root node index.

## Complexity

- build: `O(n)`
- point update: `O(log n)` time and additional memory
- range query: `O(log n)`
