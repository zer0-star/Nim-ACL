# sorted_set_map

`sorted_set_map` provides ordered sets and ordered maps.

Nim's standard `sets` and `tables` are hash-based. This module provides containers closer to C++ `std::set` and `std::map`.

For normal ordered set/map use, this module is recommended. The default backend is RedBlackTree. See [Tree backends](./tree_backends.html) for backend details.

## Import

~~~nim
import atcoder/extra/structure/sorted_set_map
~~~

## Types

~~~nim
type SortedSet(K, countable = false, comp = nil)
type SortedMultiSet(K, countable = false, comp = nil)
type SortedMap(K, V, countable = false, comp = nil)
type SortedMultiMap(K, V, countable = false, comp = nil)
~~~

- `SortedSet`: set without duplicate keys
- `SortedMultiSet`: set with duplicate keys
- `SortedMap`: key-value map
- `SortedMultiMap`: map with duplicate keys
- `countable = true`: enables index access and rank-related operations
- `comp`: comparison function; ascending order is used by default

## Constructors

~~~nim
proc initSortedSet[K](countable = false, comp = nil): auto
proc initSortedSet[K](a: openArray[K], countable = false, comp = nil): auto

proc initSortedMultiSet[K](countable = false, comp = nil): auto
proc initSortedMultiSet[K](a: openArray[K], countable = false, comp = nil): auto

proc initSortedMap[K, V](countable = false, comp = nil): auto
proc initSortedMap[K, V](a: openArray[(K, V)], countable = false, comp = nil): auto

proc initSortedMultiMap[K, V](countable = false, comp = nil): auto
proc initSortedMultiMap[K, V](a: openArray[(K, V)], countable = false, comp = nil): auto
~~~

## Common operations

~~~nim
proc empty(s): bool
proc len(s): int

proc insert(s: var SortedSet, key)
proc insert(s: var SortedMap, item)

proc erase(s: var SortedSet, key)
proc erase(s: var SortedMap, key)

proc contains(s, key): bool
proc find(s, key): iterator
proc lower_bound(s, key): iterator
proc upper_bound(s, key): iterator
proc begin(s): iterator
proc end(s): iterator
~~~

`key in s` and `key notin s` are also available.

## SortedSet example

~~~nim
var s = initSortedSet[int](countable = true)

s.insert(3)
s.insert(1)
s.insert(4)
s.insert(1)

doAssert s.len == 3
doAssert 1 in s
doAssert 2 notin s

doAssert *s{0} == 1
doAssert *s{1} == 3
doAssert *s{2} == 4

s.erase(3)

doAssert 3 notin s
doAssert s.len == 2
~~~

## SortedMap example

~~~nim
var mp = initSortedMap[string, int](countable = true)

mp["three"] = 3
mp["one"] = 100
mp["one"] = 1
mp["four"] = 4

doAssert "one" in mp
doAssert "two" notin mp
doAssert mp["one"] == 1
doAssert mp["four"] == 4

var xs: seq[(string, int)] = @[]
for k, v in mp:
  xs.add((k, v))

doAssert xs == @[("four", 4), ("one", 1), ("three", 3)]
~~~

## MultiSet / MultiMap

`SortedMultiSet` and `SortedMultiMap` allow duplicate keys.

~~~nim
var s = initSortedMultiSet[int](countable = true)

s.insert(2)
s.insert(1)
s.insert(2)
s.insert(3)

doAssert 2 in s

s.erase(2)

doAssert 2 notin s
~~~

The current `erase(key)` removes the equal-key range.

## Custom comparator

~~~nim
proc desc(a, b: int): bool = a > b

var s = initSortedSet[int](countable = true, desc)

s.insert(3)
s.insert(1)
s.insert(4)

doAssert *s{0} == 4
doAssert *s{1} == 3
doAssert *s{2} == 1
~~~

## Notes

- Prefer `sorted_set_map` for new code.
- `set_map` is a compatibility alias.
- If you need low-level backends directly, see [Tree backends](./tree_backends.html).

## Complexity

For `n` elements:

- `insert`: `O(log n)`
- `erase`: `O(log n)`
- `find`, `lower_bound`, `upper_bound`: `O(log n)`
- index access `{i}`: `O(log n)`
