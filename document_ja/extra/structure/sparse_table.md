# SparseTable

`SparseTable` は、静的な列に対して区間集約を高速に行う data structure です。

`min`, `max`, `gcd` のような **冪等な演算** に向いています。

## import

~~~nim
import atcoder/extra/structure/sparse_table
~~~

## 型

~~~nim
type SparseTable[T]
~~~

## コンストラクタ

~~~nim
proc initSparseTable[T](
  v: seq[T],
  op: proc(a, b: T): T,
  e: proc(): T
): SparseTable[T]
~~~

- `v`: 元の列
- `op`: 区間を合成する二項演算
- `e`: 空区間の単位元

## 区間取得

~~~nim
proc prod[T](st: SparseTable[T], r: RangeType): T
proc `[]`[T](st: SparseTable[T], r: RangeType): T
~~~

区間 `r` の集約値を返します。

## 使用例

~~~nim
proc op(a, b: int): int = max(a, b)
proc e(): int = int.low

let a = @[3, 1, 4, 1, 5, 9]
let st = initSparseTable(a, op, e)

doAssert st.prod(1 ..< 5) == 5
doAssert st[2 ..< 6] == 9
~~~

## 制約

この実装では、長さ `2^k` の 2 つの重なり合う区間を合成して答えます。  
そのため `op` は結合的であるだけでなく、冪等である必要があります。

使える例:

- `min`
- `max`
- `gcd`

使えない例:

- `+`
- `*`

## 計算量

列の長さを `n` とします。

- 構築: `O(n log n)`
- 区間取得: `O(1)`
