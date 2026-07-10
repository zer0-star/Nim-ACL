# WeightedUnionFind

`WeightedUnionFind` は、各頂点に potential を持たせる Union-Find です。

同じ連結成分内の 2 頂点 `x`, `y` について、`weight(y) - weight(x)` を高速に取得できます。

## import

~~~nim
import atcoder/extra/structure/weighted_union_find
~~~

## 型

~~~nim
type WeightedUnionFind[T]
~~~

`T` は potential の差を表す型です。通常は `int` などを使います。

## コンストラクタ

~~~nim
proc initWeightedUnionFind[T](n: int): WeightedUnionFind[T]
~~~

`n` 頂点の Weighted Union-Find を作ります。初期状態ではすべての頂点が別々の成分で、potential は `0` です。

## 操作

~~~nim
proc root[T](uf: var WeightedUnionFind[T], x: int): int
proc weight[T](uf: var WeightedUnionFind[T], x: int): T

proc unionSet[T](uf: var WeightedUnionFind[T], x, y: int, w: T): bool

proc same[T](uf: var WeightedUnionFind[T], x, y: int): bool
proc size[T](uf: var WeightedUnionFind[T], x: int): int
proc diff[T](uf: var WeightedUnionFind[T], x, y: int): T
proc groups[T](uf: var WeightedUnionFind[T]): seq[seq[int]]
~~~

`unionSet(uf, x, y, w)` は次の制約を追加しながら成分を併合します。

~~~text
weight(y) - weight(x) = w
~~~

`diff(uf, x, y)` は `weight(y) - weight(x)` を返します。

## 使用例

<!-- nim-line-numbers -->
~~~nim
var uf = initWeightedUnionFind[int](4)

discard uf.unionSet(0, 1, 2)  # weight(1) - weight(0) = 2
discard uf.unionSet(1, 2, 3)  # weight(2) - weight(1) = 3

doAssert uf.same(0, 2)
doAssert uf.diff(0, 2) == 5
doAssert uf.diff(2, 0) == -5
doAssert uf.size(0) == 3
~~~

## 計算量

ほぼ Union-Find と同じで、各操作は償却 `O(α(n))` です。
