# Factorial

`factorial[ModInt](n)` computes `n!` over a modint type.

## Import

~~~nim
import atcoder/modint
import atcoder/extra/math/factorial
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
import atcoder/modint
import atcoder/extra/math/factorial

type mint = modint998244353

doAssert factorial[mint](0) == mint(1)
doAssert factorial[mint](5) == mint(120)
doAssert factorial[mint](10) == mint(3628800)
~~~

## Notes

If `n >= ModInt.mod()`, the result is `0`.

## Complexity

The implementation uses formal power series internally for fast factorial computation. It returns the usual `n!` value for small `n` as well.
