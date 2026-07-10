# DisjointSparseTable

`DisjointSparseTable` は、静的配列に対する結合的演算の区間積を `O(1)` で求める data structure です。

通常の Sparse Table と異なり、演算が冪等である必要はありません。和・積・文字列連結・行列積などにも使えます。

## 考え方

各 level で配列を block に分け、block 中央から左向きの suffix 積と、中央から右向きの prefix 積を前計算します。

区間 `[l, r)` について `l` と `r-1` が初めて異なる上位 bit を選ぶと、区間は1つの中央をまたぎます。その左右の前計算結果を1回 `op` すれば答えになります。

## import

~~~nim
import atcoder/extra/structure/disjoint_sparse_table
~~~

## API

~~~nim
proc initDisjointSparseTable[T](
  a: openArray[T],
  op: proc(a, b: T): T
): DisjointSparseTable[T]

proc prod[T](dst: DisjointSparseTable[T], l, r: int): T
proc `[]`[T](
  dst: DisjointSparseTable[T],
  range: tuple[l, r: int]
): T
~~~

`op` は結合法則を満たす必要があります。区間は非空の半開区間 `[l, r)` です。

## 使用例

<!-- nim-line-numbers -->
~~~nim
proc add(a, b: int): int = a + b

let dst = initDisjointSparseTable(@[1, 2, 3, 4, 5], add)

doAssert dst.prod(1, 4) == 9
doAssert dst[(2, 5)] == 12
~~~

非可換演算にも対応します。

~~~nim
proc concat(a, b: string): string = a & b

let dst = initDisjointSparseTable(@["a", "b", "c", "d"], concat)

doAssert dst.prod(1, 4) == "bcd"
~~~

## 計算量

- 構築: `O(n log n)`
- query: `O(1)`
- memory: `O(n log n)`

## 関連資料・他言語ライブラリ

- [Library Checker: Static RMQ](https://judge.yosupo.jp/problem/staticrmq)
- Nyaan Library: Disjoint Sparse Table
- ei1333 Library: Disjoint Sparse Table
