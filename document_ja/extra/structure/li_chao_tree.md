# LiChaoTree

`LiChaoTree` は、一次関数を追加し、指定した座標での最小値を求める data structure です。

この実装は座標圧縮型です。query で使う `x` 座標列を最初に渡します。

## import

~~~nim
import atcoder/extra/structure/li_chao_tree
~~~

## 型

~~~nim
type Line[T]
type LiChaoTree[T]
~~~

## コンストラクタ

~~~nim
proc initLine[T](a, b: T): Line[T]
proc initLiChaoTree[T](xs: seq[T], inf_val: T): LiChaoTree[T]
~~~

- `initLine(a, b)` は直線 `f(x) = ax + b` を返します。
- `initLiChaoTree(xs, inf_val)` は query で使う座標列 `xs` を持つ Li Chao Tree を作ります。

## 操作

~~~nim
proc update[T](cht: var LiChaoTree[T], a, b: T)
proc update[T](cht: var LiChaoTree[T], a, b: T, r: Slice[int])
proc query[T](cht: LiChaoTree[T], k: int): T
~~~

- `update(a, b)` は直線 `f(x) = ax + b` を全体に追加します。
- `update(a, b, r)` は直線を index 区間 `r` にだけ追加します。
- `query(k)` は `xs[k]` における最小値を返します。

## 使用例

~~~nim
const INF = int.high div 4

var cht = initLiChaoTree[int](@[0, 1, 2, 3, 4, 5], INF)

cht.update(2, 3)    # 2x + 3
cht.update(-1, 10)  # -x + 10
cht.update(0, 7)    # 7

doAssert cht.query(0) == 3
doAssert cht.query(5) == 5
~~~

区間追加もできます。

~~~nim
var cht = initLiChaoTree[int](@[0, 1, 2, 3, 4, 5], INF)

cht.update(0, 100)
cht.update(0, 1, 2 .. 4)

doAssert cht.query(1) == 100
doAssert cht.query(2) == 1
doAssert cht.query(4) == 1
~~~

## 制約

- この実装は最小値用です。
- `query(k)` は最初に与えた座標列 `xs` の `k` 番目に対する query です。
- 任意の座標値を直接渡すのではなく、あらかじめ座標を与えておく必要があります。

## 計算量

座標数を `n` とすると、

- 直線追加: `O(log n)`
- 区間直線追加: `O(log^2 n)`
- query: `O(log n)`

です。
