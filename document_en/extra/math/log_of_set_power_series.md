# Logarithm of Set Power Series

Computes the logarithm of a set power series whose empty-set coefficient is
`1`.

## General form

~~~nim
let logarithm =
  logOfSetPowerSeries(
    values,
  )
~~~

## Parameters and types

- `values`: coefficient sequence of the set power series
- `T`: coefficient type

For length `2^k`, an index is the bit mask of a subset of a `k`-element set.

The coefficient type `T` must form a commutative ring supporting `+`, `-`, and
`*`, and it must be constructible from the integer `1`.

The input sequence is not modified.

## Preconditions

- `values.len` is a positive power of two
- `values[0] == T(1)`

Here, `values[0]` is the empty-set coefficient.

A violation raises `ValueError`.

## Return value

The result is a `seq[T]` with the same length as the input.

Its empty-set coefficient is `0`.

~~~nim
logOfSetPowerSeries(
  expOfSetPowerSeries(f),
) == f
~~~

For a series `g` whose empty-set coefficient is `1`:

~~~nim
expOfSetPowerSeries(
  logOfSetPowerSeries(g),
) == g
~~~

## Example

~~~nim
import atcoder/extra/math/log_of_set_power_series

let values =
  @[
    1'i64,
    2,
    3,
    11,
  ]

let logarithm =
  logOfSetPowerSeries(
    values,
  )

doAssert logarithm ==
  @[
    0'i64,
    2,
    3,
    5,
  ]
~~~

## Related APIs

- `expOfSetPowerSeries`: exponential of a set power series with empty-set
  coefficient `0`
- `subsetConvolution`: subset convolution

Internally, the implementation recursively separates one variable and uses
subset convolution. It also computes the inverse of a unit set power series
inside the recursion, but that inverse is not exposed as a separate public API.

Together, `expOfSetPowerSeries` and `logOfSetPowerSeries` form the core Exp/Log
set-power-series API.

## Complexity and implementation

Let `values.len = 2^k`.

- Time: `O(k^2 2^k)`
- Memory: `O(k 2^k)`

The implementation uses `subsetConvolution` internally.
