# Minimum Rotation / Booth

Minimum Rotation finds the lexicographically smallest cyclic rotation in linear time using Booth's algorithm.

## Import and API

~~~nim
import atcoder/extra/string/minimum_rotation

proc minimumRotationIndex(s): int
proc minimumRotation(s): auto
proc maximumRotationIndex(s): int
proc maximumRotation(s): auto
~~~

## Example

~~~nim
doAssert minimumRotation("bbaaccaadd") == "aaccaaddbb"
~~~

## Complexity

- index computation: `O(n)`
- rotation construction: `O(n)`
