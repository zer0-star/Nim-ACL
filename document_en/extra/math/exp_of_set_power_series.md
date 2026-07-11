# Exp of Set Power Series

Computes the exponential of a set power series `f`.

## General form

~~~nim
let result =
  expOfSetPowerSeries(
    f
  )
~~~

## Parameters

- `f`: set power series
- `T`: coefficient type supporting addition, subtraction, multiplication,
  and conversion from the integer `1`

For an array of length `2^k`, index `mask` represents a subset of a
`k`-element set.

## Preconditions

- the input length is a positive power of two
- `f[0] == 0`
- empty arrays are not accepted

`f[0]` is the empty-set coefficient.

Invalid inputs raise `ValueError`.

## Return value

The return value is a `seq[T]` with the same length as the input.

For the empty set:

~~~text
result[0] = 1
~~~

For a nonempty set `S`, `result[S]` is the sum over all set partitions of
`S` of:

~~~text
product f[block]
~~~

The input `f` is not modified.

## Example

~~~nim
import atcoder/modint
import atcoder/extra/math/exp_of_set_power_series

type mint = modint998244353

let f = @[
  mint.init(0),
  mint.init(2),
  mint.init(3),
  mint.init(5),
]

let result =
  expOfSetPowerSeries(
    f
  )

doAssert result == @[
  mint.init(1),
  mint.init(2),
  mint.init(3),
  mint.init(11),
]
~~~

The last coefficient is:

~~~text
f[{0,1}] + f[{0}] * f[{1}]
= 5 + 2 * 3
= 11
~~~

## Related APIs

- `subsetConvolution(f, g)` divides a set into two disjoint parts.
- `zeta_transform` provides low-level subset and superset zeta transforms.

`expOfSetPowerSeries` internally applies `subsetConvolution` layer by layer.

## Complexity

For input length `2^k`:

- Time: `O(k^2 * 2^k)`
- Memory: `O(k * 2^k)`
