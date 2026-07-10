# Convert Base

`toSeq` and `toInt` convert between an integer and a digit sequence in base `b`.

The digit sequence is **little-endian**: the least significant digit comes first.

## Import

~~~nim
import atcoder/extra/math/convert_base
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/math/convert_base

doAssert toSeq(12345, 10) == @[5, 4, 3, 2, 1]
doAssert toInt(@[5, 4, 3, 2, 1], 10) == 12345

doAssert toSeq(13, 2) == @[1, 0, 1, 1]
doAssert toInt(@[1, 0, 1, 1], 2) == 13
~~~

## min_digit

`toSeq(n, b, min_digit)` pads with zeros until the result has at least `min_digit` digits.

~~~nim
doAssert toSeq(0, 10, 4) == @[0, 0, 0, 0]
~~~

## Complexity

Let `d` be the number of digits.

- `toSeq`: `O(d)`
- `toInt`: `O(d)`
