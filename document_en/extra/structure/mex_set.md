# MexSet

`MexSet` dynamically maintains the mex of an integer multiset.

The mex is the smallest non-negative integer that is absent.

## Import and API

~~~nim
import atcoder/extra/structure/mex_set

proc initMexSet(limit: int): MexSet
proc insert(s: var MexSet, x: int): bool
proc erase(s: var MexSet, x: int): bool
proc count(s: MexSet, x: int): int
proc mex(s: MexSet): int
~~~

## Example

~~~nim
var s = initMexSet(10)

s.incl(0)
s.incl(1)
s.incl(3)

doAssert s.mex == 2
~~~

## Complexity

Insertion, deletion, and mex queries take `O(log_64 limit)`.
