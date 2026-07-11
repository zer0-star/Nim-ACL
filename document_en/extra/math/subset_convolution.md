# Subset Convolution

Computes the subset convolution of two set functions `f` and `g`.

## General form

~~~nim
let result =
  subsetConvolution(
    f,
    g,
  )
~~~

## Parameters

- `f`: first set function
- `g`: second set function
- `T`: element type supporting addition, subtraction, and multiplication

For an array of length `2^k`, index `mask` represents a subset of a
`k`-element set.

## Preconditions

- `f.len == g.len`
- the input length is a positive power of two
- empty arrays are not accepted

Invalid inputs raise `ValueError`.

## Return value

The return value is a `seq[T]` with the same length as the inputs.

For every set `S`:

~~~text
result[S] = sum f[T] * g[S xor T]
~~~

where the sum ranges over every subset `T` of `S`.

The input arrays are not modified.

## Example

~~~nim
import atcoder/modint
import atcoder/extra/math/subset_convolution

type mint = modint998244353

let
  f = @[
    mint.init(1),
    mint.init(2),
    mint.init(3),
    mint.init(4),
  ]

  g = @[
    mint.init(5),
    mint.init(6),
    mint.init(7),
    mint.init(8),
  ]

  result =
    subsetConvolution(
      f,
      g,
    )

doAssert result == @[
  mint.init(5),
  mint.init(16),
  mint.init(22),
  mint.init(60),
]
~~~

Indices `0, 1, 2, 3` represent the empty set, `{0}`, `{1}`, and `{0,1}`,
respectively.

## Related APIs

- `orConvolution`: OR convolution
- `andConvolution`: AND convolution
- `xorConvolution`: XOR convolution
- `zeta_transform`: low-level subset and superset zeta transforms

Use `subsetConvolution` when a set is divided into two disjoint parts.

## Complexity

For input length `2^k`:

- Time: `O(k^2 * 2^k)`
- Memory: `O(k * 2^k)`

The implementation uses ranked zeta and Möbius transforms internally.
