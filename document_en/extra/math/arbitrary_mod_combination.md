# Arbitrary Mod Combination

`ArbitraryModBinomial` computes binomial coefficients `n choose k` modulo an arbitrary modulus.

It supports composite moduli as well as prime moduli.

## Import

~~~nim
import atcoder/extra/math/arbitrary_mod_combination
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/math/arbitrary_mod_combination

let binom = initArbitraryModBinomial(1000, 100)

doAssert binom.C(20, 10) == 756
doAssert binom.C(5, 2) == 10
doAssert binom.C(5, 6) == 0
~~~

## initArbitraryModBinomial

~~~nim
let binom = initArbitraryModBinomial(md, N_MAX)
~~~

Initializes a helper for binomial coefficients modulo `md`.

- `md`: modulus
- `N_MAX`: maximum value assumed for precomputation

If `md = 1`, all results are `0`.

## C

~~~nim
binom.C(n, k)
~~~

Returns `n choose k` modulo `md`.

Out-of-range arguments return `0`.

~~~nim
doAssert binom.C(5, -1) == 0
doAssert binom.C(5, 6) == 0
~~~

## Notes

- The intended modulus range is roughly `1 <= md < 2^30`.
- Internally, the modulus is decomposed into prime powers and combined with CRT.
- A larger `N_MAX` increases precomputation cost.

## Complexity

The initialization factors `md` and precomputes data for each prime-power component.  
Each `C(n, k)` evaluates the components and combines them with CRT.
