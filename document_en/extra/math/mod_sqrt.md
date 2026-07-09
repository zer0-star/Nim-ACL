# Mod Sqrt

`modSqrt(a)` finds one `x` such that `x^2 = a` over a modint type.

It returns `some(x)` when a square root exists, and `none` otherwise.

## Import

~~~nim
import std/options
import atcoder/modint
import atcoder/extra/math/mod_sqrt
~~~

## Example

~~~nim
import std/options
import atcoder/modint
import atcoder/extra/math/mod_sqrt

type mint = modint998244353

let r = modSqrt(mint(4))

doAssert r.isSome

let x = r.get

doAssert x * x == mint(4)
~~~

## Return value

~~~nim
Option[T]
~~~

Use `std/options` helpers such as `isSome`, `isNone`, and `get`.

## Notes

- The modulus is assumed to be prime.
- If two square roots exist, one of them is returned.
- If no square root exists, the result is `none`.

## Complexity

For modulus `p`, the running time is roughly:

- `O(log^2 p)`
