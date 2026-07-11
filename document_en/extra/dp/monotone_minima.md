# Monotone Minima

Finds the minimum column of every row when the leftmost minimum columns are monotonically nondecreasing.

The matrix is accessed lazily through a function and does not need to be stored. Ties are resolved toward the leftmost column.

## Import

~~~nim
import atcoder/extra/dp/monotone_minima
~~~

## `monotoneMinima`

~~~nim
let center = @[0, 1, 1, 3]

let value =
  proc(row, column: int): int =
    let d = column - center[row]
    d * d

let argmin = monotoneMinima[int](
  center.len,
  5,
  value,
)

doAssert argmin == center
~~~

### Complexity

For \(H\) rows and \(W\) columns, the number of matrix evaluations is

\[
O((H+W)\log(H+1)).
\]

## `divideAndConquerOptimization`

Returns both the minimum value and the minimum column of every row.

~~~nim
let result = divideAndConquerOptimization[int](
  center.len,
  5,
  value,
)

echo result.minimum
echo result.argmin
~~~

## `divideAndConquerDpLayer`

Computes one DP layer of the form

\[
\mathrm{current}[j]
=
\min_i
\left(
\mathrm{previous}[i]
+
\mathrm{cost}(i,j)
\right).
\]

The caller must guarantee that the leftmost optimal \(i\) is monotonically nondecreasing with \(j\).

~~~nim
let previous = @[8, 3, 5, 9]

let cost =
  proc(candidate, state: int): int =
    let d = candidate - state
    d * d

let next = divideAndConquerDpLayer[int](
  previous,
  6,
  cost,
)
~~~

## Preconditions

- The leftmost row-minimum positions must be monotonically nondecreasing.
- Monge and totally monotone matrices are common applications.
- Results are unspecified when the monotonicity condition is not satisfied.

## Practice problems

<details class="problem-examples">
<summary>Show problems that can use this library (may reveal the intended technique)</summary>
<ul>
  <li><a href="https://atcoder.jp/contests/abc348/tasks/abc348_g" target="_blank" rel="noopener">AtCoder Beginner Contest 348 G - Max (Sum - Max)</a></li>
  <li><a href="https://atcoder.jp/contests/abc355/tasks/abc355_g" target="_blank" rel="noopener">AtCoder Beginner Contest 355 G - Baseball</a></li>
</ul>
</details>
