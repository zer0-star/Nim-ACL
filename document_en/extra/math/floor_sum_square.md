# Floor Sum Square

`floor_sum_square(n, m, a, b)` computes the following three sums at once:

~~~text
S1 = Σ i floor((a i + b) / m)
S2 = Σ floor((a i + b) / m)^2
S3 = Σ floor((a i + b) / m)
~~~

The summation range is `i = 0 ..< n`.

## Import

~~~nim
import atcoder/extra/math/floor_sum_square
~~~

## Example

~~~nim
import atcoder/extra/math/floor_sum_square

let ans = floor_sum_square(5, 7, 3, 2)

doAssert ans.S1 == 13
doAssert ans.S2 == 6
doAssert ans.S3 == 4
~~~

In this example:

~~~text
floor((3i + 2) / 7) = 0, 0, 1, 1, 2
~~~

## Return value

~~~nim
tuple[S1, S2, S3: T]
~~~

- `S1`: `Σ i floor((a i + b) / m)`
- `S2`: `Σ floor((a i + b) / m)^2`
- `S3`: `Σ floor((a i + b) / m)`

## Complexity

The running time is roughly:

- `O(log(n + m + a + b))`
