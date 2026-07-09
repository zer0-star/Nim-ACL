---
title: Tree backends
documentation_of: //src/atcoder/extra/structure/tree_backends.nim
---

# Tree backends

Nim-ACL has several low-level tree backends for ordered sets, sequence operations, and lazy propagation.

If you need a normal ordered set or map, start with [`sorted_set_map`](./sorted_set_map.html).

~~~nim
import atcoder/extra/structure/sorted_set_map
~~~

## Recommended user-facing module

### sorted_set_map

~~~nim
import atcoder/extra/structure/sorted_set_map
~~~

This is the recommended ordered set/map interface.

Main container types:

~~~nim
SortedSet(K)
SortedMultiSet(K)
SortedMap(K, V)
SortedMultiMap(K, V)
~~~

## Compatibility alias

### set_map

~~~nim
import atcoder/extra/structure/set_map
~~~

`set_map` is a compatibility alias for `sorted_set_map`.  
For new code, prefer `sorted_set_map`.

## Low-level backends

The following modules are low-level or advanced tree backends:

~~~nim
import atcoder/extra/structure/red_black_tree
import atcoder/extra/structure/randomized_binary_search_tree_with_parent
import atcoder/extra/structure/splay_tree
~~~

### RedBlackTree

The default backend of `sorted_set_map`.  
It exposes low-level node operations, so most users do not need to import it directly.

### RandomizedBinarySearchTree

A backend useful when you want to work directly with sequence operations and split/merge.

### SplayTree

A backend for sequence operations, reversal, and lazy propagation.

## Notes

Importing multiple low-level backend modules together can cause ambiguous names.  
Import only the backend you actually need.

This `tree_backends` module is documentation-only and intentionally does not re-export low-level backends.
