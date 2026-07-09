# SuccinctIndexableDictionary

`SuccinctIndexableDictionary` is a data structure for fast rank queries on a bit vector.

It is commonly used as an internal component of Wavelet Matrix.

## Import

~~~nim
import atcoder/extra/structure/succinct_indexable_dictionary
~~~

## Type

~~~nim
type SuccinctIndexableDictionary
~~~

## Constructor

~~~nim
proc initSuccinctIndexableDictionary(n: int): SuccinctIndexableDictionary
~~~

Creates a length-`n` bit vector initialized with zeros.

## Operations

~~~nim
proc set(sid: var SuccinctIndexableDictionary, k: int)
proc build(sid: var SuccinctIndexableDictionary)

proc rank(sid: SuccinctIndexableDictionary, k: int): int
proc rank(sid: SuccinctIndexableDictionary, bit: bool, k: int): int
~~~

- `set(k)` sets the bit at position `k` to `1`.
- `build()` builds rank metadata. Call it after all `set` calls.
- `rank(k)` returns the number of `1` bits in `[0, k)`.
- `rank(bit, k)` returns the number of `bit` values in `[0, k)`.

## Example

~~~nim
var sid = initSuccinctIndexableDictionary(8)

sid.set(1)
sid.set(3)
sid.set(4)
sid.build()

doAssert sid.rank(0) == 0
doAssert sid.rank(4) == 2
doAssert sid.rank(8) == 3

doAssert sid.rank(true, 8) == 3
doAssert sid.rank(false, 8) == 5
~~~

## Constraints

Calling `set` after `build` is not intended.  
Set all bits first, then call `build`.

## Complexity

- `set`: `O(1)`
- `build`: `O(n / word_size)`
- `rank`: `O(1)`
