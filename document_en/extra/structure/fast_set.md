# FastSet

`FastSet` stores integers in `[0, n)` using hierarchical bitsets.

It supports insertion, deletion, membership, successor, and predecessor queries with small constants.

## Import and API

~~~nim
import atcoder/extra/structure/fast_set

proc initFastSet(n: int): FastSet
proc insert(s: var FastSet, x: int): bool
proc erase(s: var FastSet, x: int): bool
proc nextGE(s: FastSet, x: int): int
proc prevLE(s: FastSet, x: int): int
~~~

Missing successor/predecessor results are represented by `-1`.

## Example

<!-- nim-line-numbers -->
~~~nim
var s = initFastSet(100)

s.incl(3)
s.incl(20)
s.incl(64)

doAssert s.nextGE(4) == 20
doAssert s.prevLE(63) == 20
~~~

## Complexity

With `L = O(log_64 n)` levels:

- insert/erase: `O(L)`
- membership: `O(1)`
- successor/predecessor: `O(L)`
