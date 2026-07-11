# Polynomial Interpolation

Constructs the unique polynomial of degree less than `xs.len` that passes
through every point `(xs[i], ys[i])`.

## General form

~~~nim
let coefficients =
  polynomialInterpolation(
    xs,
    ys,
  )
~~~

## Parameters

- `xs`: x coordinates of the sample points
- `ys`: polynomial values at the sample points
- `T`: coefficient type; the current fast implementation uses a finite field
  with an available NTT backend

A typical coefficient type is `modint998244353`.

## Preconditions

- `xs.len == ys.len`
- all elements of `xs` are pairwise distinct
- invalid inputs raise `ValueError`

Two empty arrays produce an empty polynomial.

## Return value

The return value is `FormalPowerSeries[T]`.

~~~nim
coefficients[i]
~~~

is the coefficient of \(x^i\). Coefficients are stored in ascending degree
order.

For `n = xs.len`, the returned sequence always has length `n`. Trailing zero
coefficients are preserved.

## Example

The following reconstructs \(f(x)=3+2x+5x^2\) from three points.

~~~nim
import atcoder/modint
import atcoder/extra/math/polynomial_interpolation

type mint = modint998244353

let
  xs = @[
    mint.init(0),
    mint.init(1),
    mint.init(2),
  ]

  ys = @[
    mint.init(3),
    mint.init(10),
    mint.init(27),
  ]

  coefficients =
    polynomialInterpolation(
      xs,
      ys,
    )

doAssert coefficients == @[
  mint.init(3),
  mint.init(2),
  mint.init(5),
]
~~~

## Related APIs

- `multipointEvaluation(f, xs)` evaluates a known polynomial at many points.
- `lagrange_polynomial(y, t)` evaluates an interpolation polynomial at one
  point when the x coordinates are `0, 1, ..., y.len - 1`.
- `subproduct_tree(xs)` is the low-level product-tree API.

Use `polynomialInterpolation` when the polynomial itself is required. Use
`lagrange_polynomial` when only one value is required and the x coordinates
are consecutive integers.

## Complexity

For `n = xs.len` and polynomial multiplication cost `M(n)`:

- Time: `O(M(n) log n)`
- Memory: `O(n log n)`

With NTT multiplication, the running time is `O(n log^2 n)`.
