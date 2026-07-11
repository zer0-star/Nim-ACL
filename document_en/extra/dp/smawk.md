# SMAWK

Finds a minimum column of every row of a totally monotone implicit matrix.

## General form

~~~nim
let argmin =
  smawk[T](
    rowCount,
    columnCount,
    value,
  )
~~~

## Parameters

- `rowCount`: number of rows
- `columnCount`: number of columns
- `value(row, column)`: callback returning one matrix entry
- `T`: matrix-entry type supporting comparison with `<`

The whole matrix does not need to be stored.

## Preconditions

- `rowCount >= 0`
- `columnCount >= 0`
- when rows exist, `columnCount > 0`
- the implicit matrix represented by `value` is totally monotone

Results are not guaranteed when the matrix is not totally monotone. Negative
dimensions, or zero columns with existing rows, raise `ValueError`.

## Return value

The return value is a `seq[int]` of length `rowCount`.

~~~nim
argmin[row]
~~~

is a column attaining the row minimum. If several columns have the same
minimum value, the leftmost one is returned.

When `rowCount == 0`, an empty sequence is returned without calling `value`.

## Example

~~~nim
import atcoder/extra/dp/smawk

let centerTimesTwo =
  @[0, 1, 3, 6]

let value =
  proc(
      row,
      column: int,
  ): int =
    let difference =
      2 * column - centerTimesTwo[row]

    difference * difference

let argmin =
  smawk[int](
    centerTimesTwo.len,
    5,
    value,
  )

doAssert argmin == @[0, 0, 1, 3]
~~~

## Related APIs

- `monotoneMinima` applies divide and conquer when row-minimum columns are
  nondecreasing.
- `divideAndConquerOptimization` evaluates Monge-style DP transitions layer
  by layer.

Use `smawk` for totally monotone matrices when the number of calls to `value`
should be linear in the number of rows and columns.

## Complexity

Assuming one `value` evaluation takes `O(1)`:

- Time: `O(rowCount + columnCount)`
- Memory: `O(rowCount + columnCount)`
