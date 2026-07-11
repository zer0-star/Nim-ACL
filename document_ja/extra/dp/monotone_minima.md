# Monotone Minima

各行の最小値を取る列が単調非減少になる行列について、各行の最小列を分割統治で求めます。

行列全体を保持する必要はなく、要素を返す関数だけを渡します。同じ最小値を取る列が複数ある場合は、最も左の列を返します。

## import

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

### 計算量

行数を \(H\)、列数を \(W\) とすると、要素評価回数は

\[
O((H+W)\log(H+1))
\]

です。

## `divideAndConquerOptimization`

各行の最小値と最小列の両方を返します。

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

次の形のDPを1層計算します。

\[
\mathrm{current}[j]
=
\min_i
\left(
\mathrm{previous}[i]
+
\mathrm{cost}(i,j)
\right)
\]

最適な \(i\) が \(j\) に対して単調非減少であることを、呼び出し側で保証してください。

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

## 前提条件

- 行ごとの最左の最小列が単調非減少である必要があります。
- Monge行列またはtotally monotone行列は、代表的な適用対象です。
- 条件を満たさない行列に使用した場合、結果は保証されません。

## このライブラリが使える問題

<details class="problem-examples">
<summary>問題例を表示する（解法のネタバレを含む可能性があります）</summary>
<ul>
  <li><a href="https://atcoder.jp/contests/abc348/tasks/abc348_g" target="_blank" rel="noopener">AtCoder Beginner Contest 348 G - Max (Sum - Max)</a></li>
  <li><a href="https://atcoder.jp/contests/abc355/tasks/abc355_g" target="_blank" rel="noopener">AtCoder Beginner Contest 355 G - Baseball</a></li>
</ul>
</details>
