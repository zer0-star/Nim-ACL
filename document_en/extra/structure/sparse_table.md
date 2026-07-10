# SparseTable

`SparseTable` is a data structure for fast range aggregation on a static sequence.

It is suitable for idempotent operations such as `min`, `max`, and `gcd`.

## Import

~~~nim
import atcoder/extra/structure/sparse_table
~~~

## Type

~~~nim
type SparseTable[T]
~~~

## Constructor

~~~nim
proc initSparseTable[T](
  v: seq[T],
  op: proc(a, b: T): T,
  e: proc(): T
): SparseTable[T]
~~~

- `v`: original sequence
- `op`: binary operation
- `e`: identity value for empty ranges

## Range query

~~~nim
proc prod[T](st: SparseTable[T], r: RangeType): T
proc `[]`[T](st: SparseTable[T], r: RangeType): T
~~~

Returns the aggregate value over range `r`.

## Example

<!-- nim-line-numbers -->
~~~nim
proc op(a, b: int): int = max(a, b)
proc e(): int = int.low

let a = @[3, 1, 4, 1, 5, 9]
let st = initSparseTable(a, op, e)

doAssert st.prod(1 ..< 5) == 5
doAssert st[2 ..< 6] == 9
~~~

## Constraints

This implementation answers a query by combining two overlapping intervals of length `2^k`.  
Therefore, `op` must be idempotent as well as associative.

Good examples:

- `min`
- `max`
- `gcd`

Bad examples:

- `+`
- `*`

## Complexity

For a sequence of length `n`:

- build: `O(n log n)`
- query: `O(1)`
