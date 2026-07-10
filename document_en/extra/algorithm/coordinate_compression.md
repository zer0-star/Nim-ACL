# Coordinate Compression

Coordinate compression replaces sparse or large values with consecutive indices while preserving their order.

## Import and API

~~~nim
import atcoder/extra/algorithm/coordinate_compression

proc initCoordinateCompression[T](
  a: openArray[T]
): CoordinateCompression[T]

proc encode(cc, x): int
proc decode(cc, index): T
proc compress(cc, a): seq[int]
~~~

## Example

~~~nim
let
  a = @[100, -5, 100, 7]
  cc = initCoordinateCompression(a)

doAssert cc.values == @[-5, 7, 100]
doAssert cc.compress(a) == @[2, 0, 2, 1]
~~~

## Complexity

- build: `O(n log n)`
- encode: `O(log n)`
- decode: `O(1)`
