# DenseFenwickTree2D

`DenseFenwickTree2D` は、固定された `width × height` の格子に対して、点加算と矩形和を処理する密な二次元Fenwick Treeです。

## import

~~~nim
import atcoder/extra/structure/dense_fenwicktree_2d
~~~

## 構築

~~~nim
var tree =
  initDenseFenwickTree2D[int](
    width,
    height,
  )
~~~

座標は `(x, y)` の順で指定します。

~~~text
0 <= x < width
0 <= y < height
~~~

## 点加算

~~~nim
tree.add(
  x,
  y,
  delta,
)
~~~

## prefix和

~~~nim
let prefix =
  tree.prefixSum(
    xRight,
    yRight,
  )
~~~

対象は半開矩形です。

~~~text
[0, xRight) × [0, yRight)
~~~

## 矩形和

~~~nim
let answer =
  tree.sum(
    xLeft,
    xRight,
    yLeft,
    yRight,
  )
~~~

対象は半開矩形です。

~~~text
[xLeft, xRight) × [yLeft, yRight)
~~~

`get(x, y)` は一点の値を返し、`allSum` は全格子の和を返します。

## 代数的な条件

型 `T` はzero値に加えて `+` と `-` を提供する必要があります。矩形和ではprefix和の差を取るため、加法可換群に相当する演算を前提とします。

## 計算量

| 操作 | 計算量 |
|---|---:|
| 構築 | `O(width × height)` |
| `add` | `O(log width log height)` |
| `prefixSum` | `O(log width log height)` |
| `sum` | `O(log width log height)` |
| `get` | `O(log width log height)` |
| `allSum` | `O(log width log height)` |

メモリ使用量は `O(width × height)` です。
