# Floor Sum Square

`floor_sum_square(n, m, a, b)` は、次の 3 つの和を同時に求めます。

~~~text
S1 = Σ i floor((a i + b) / m)
S2 = Σ floor((a i + b) / m)^2
S3 = Σ floor((a i + b) / m)
~~~

ただし、和は `i = 0 ..< n` について取ります。

## import

~~~nim
import atcoder/extra/math/floor_sum_square
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/math/floor_sum_square

let ans = floor_sum_square(5, 7, 3, 2)

doAssert ans.S1 == 13
doAssert ans.S2 == 6
doAssert ans.S3 == 4
~~~

この例では、

~~~text
floor((3i + 2) / 7) = 0, 0, 1, 1, 2
~~~

です。

## 戻り値

~~~nim
tuple[S1, S2, S3: T]
~~~

- `S1`: `Σ i floor((a i + b) / m)`
- `S2`: `Σ floor((a i + b) / m)^2`
- `S3`: `Σ floor((a i + b) / m)`

## 計算量

おおよそ

- `O(log(n + m + a + b))`

です。
