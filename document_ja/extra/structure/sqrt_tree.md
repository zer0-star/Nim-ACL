# Sqrt Tree

`SqrtTree` は、静的なモノイド列を再帰的に平方分割し、区間積 query を高速に処理する data structure です。

この Nim-ACL 実装は、理解しやすい再帰版です。

- 前計算: `O(n log log n)`
- query: `O(log log n)`
- memory: `O(n log log n)`

AtCoder公式講座では、query 区間がどの level で分岐するかを bit 演算で直接求めることで、query を `O(1)` にする発展形も説明されています。

## 使いどころ

- 静的配列の区間積
- 演算は結合的だが冪等とは限らない
- query が非常に多い
- sum、product、文字列連結、行列積
- Segment Tree より query を速くしたい
- Disjoint Sparse Table より前計算 memory を抑えたい

## 考え方

まず列をおよそ平方根個の block に分けます。

各 block について、

- block 先頭から各位置までの `prefix`
- 各位置から block 末尾までの `suffix`
- block 全体同士の区間積 `between`

を前計算します。

query の両端が異なる block に入るなら、

1. 左端から左 block の末尾
2. 間にある完全な block
3. 右 block の先頭から右端

の高々3部分に分解できます。

両端が同じ block にある場合は、その block をさらに平方分割した子 node へ進みます。

## import

~~~nim
import atcoder/extra/structure/sqrt_tree
~~~

ローカル短縮 import：

~~~nim
import lib/structure/sqrt_tree
~~~

## API

~~~nim
proc initSqrtTree[T](
  data: openArray[T],
  identity: T,
  op: proc(a, b: T): T
): SqrtTree[T]

proc prod(
  tree: SqrtTree[T],
  l, r: int
): T

proc allProd(tree: SqrtTree[T]): T
~~~

query 区間は非空の半開区間 `[l, r)` です。

## 使用例

<!-- nim-line-numbers -->
~~~nim
proc add(a, b: int): int = a + b

let tree = initSqrtTree(
  @[1, 2, 3, 4, 5],
  identity = 0,
  op = add,
)

doAssert tree.prod(1, 4) == 9
doAssert tree[(2, 5)] == 12
~~~

非可換演算にも使えます。

<!-- nim-line-numbers -->
~~~nim
proc concat(a, b: string): string = a & b

let tree = initSqrtTree(
  @["a", "b", "c", "d"],
  identity = "",
  op = concat,
)

doAssert tree.prod(1, 4) == "bcd"
~~~

## 他の構造との使い分け

| 構造 | 前計算 | query | memory |
|---|---:|---:|---:|
| Segment Tree | `O(n)` | `O(log n)` | `O(n)` |
| Disjoint Sparse Table | `O(n log n)` | `O(1)` | `O(n log n)` |
| この Sqrt Tree | `O(n log log n)` | `O(log log n)` | `O(n log log n)` |

## 注意

- 配列は静的です。
- `op` は結合法則を満たす必要があります。
- `identity` は `op` の単位元です。
- query 区間は空にできません。
- `O(1)` query の level-selection 最適化は今後の候補です。

## 関連資料

- [AtCoder Algorithm Lectures: Sqrt Tree](https://info.atcoder.jp/entry/algorithm_lectures/sqrt_tree)
- Disjoint Sparse Table
- Library Checker: Static RMQ
