# SMAWK

totally monotoneな暗黙行列について、各行の最小要素の列を求めます。

## 一般形

~~~nim
let argmin =
  smawk[T](
    rowCount,
    columnCount,
    value,
  )
~~~

## 引数

- `rowCount`: 行数
- `columnCount`: 列数
- `value(row, column)`: 指定した行列要素を返すcallback
- `T`: 行列要素の型。`<`で比較できる必要があります

行列全体を配列として保持する必要はありません。

## 前提条件

- `rowCount >= 0`
- `columnCount >= 0`
- 行が存在する場合は`columnCount > 0`
- `value`が表す行列はtotally monotone

前提条件を満たさない行列に対する結果は保証しません。負の次元や、
行があるのに列が0の場合は`ValueError`を送出します。

## 返り値

返り値は長さ`rowCount`の`seq[int]`です。

~~~nim
argmin[row]
~~~

は、その行の最小値を与える列番号です。最小値が複数ある場合は、
最も左の列を返します。

`rowCount == 0`の場合は空列を返し、`value`を呼びません。

## 具体例

~~~nim
import atcoder/extra/dp/smawk

let centerTimesTwo =
  @[0, 1, 3, 6]

let value =
  proc(
      row,
      column: int,
  ): int =
    let difference =
      2 * column - centerTimesTwo[row]

    difference * difference

let argmin =
  smawk[int](
    centerTimesTwo.len,
    5,
    value,
  )

doAssert argmin == @[0, 0, 1, 3]
~~~

## 関連API

- `monotoneMinima`:
  各行の最小列が単調非減少である行列に対する分割統治
- `divideAndConquerOptimization`:
  Monge型DP遷移を層ごとに計算するhelper

`value`の呼び出し回数を行数と列数の和に抑えたいtotally monotone行列では
`smawk`を使用します。

## 計算量

`value`の評価を`O(1)`とすると、

- 時間: `O(rowCount + columnCount)`
- メモリ: `O(rowCount + columnCount)`
