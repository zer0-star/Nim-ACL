# Combination Table

`combination_table` is a small helper module that lazily builds tables for binomial coefficients and factorials.

It can be called in a method-like style, such as `int.C(n, r)`.

## Import

~~~nim
import atcoder/extra/math/combination_table
~~~

## Example

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/math/combination_table

doAssert int.C(5, 2) == 10
doAssert int.H(3, 2) == 6
doAssert int.P(5, 2) == 20
doAssert int.fact(5) == 120
~~~

## API

### C

~~~nim
T.C(n, r)
~~~

Returns the binomial coefficient `n choose r`. Out-of-range values return `0`.

### H

~~~nim
T.H(n, r)
~~~

Returns the number of combinations with repetition.

### P

~~~nim
T.P(n, r)
~~~

Returns the number of permutations.

### fact

~~~nim
T.fact(k)
~~~

Returns `k!`.

### resetCombination

~~~nim
T.resetCombination()
~~~

Clears the internal tables.

## Complexity

Tables are extended lazily.

- first construction up to a new `n`: `O(n^2)`
- query within the already built range: `O(1)`
