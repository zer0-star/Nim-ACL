
# CompressedSegTree2D

`CompressedSegTree2D` は、あらかじめ登録した二次元座標に対して点更新と矩形積を行う、座標圧縮型の二次元セグメント木です。

## import

```nim
import atcoder/extra/structure/compressed_segtree_2d
```

## 可換モノイド

矩形queryは複数の内部nodeへ分解され、非可換演算について外部から観測できる固定順序を保証しません。そのため、演算には可換モノイドを指定します。

```nim
proc addInt(a, b: int): int =
  a + b

proc zeroInt(): int =
  0

type
  CommutativeSum =
    CommutativeMonoidOf(
      int,
      addInt,
      zeroInt,
    )
```

可換性はcompilerが証明するものではなく、利用者が保証する代数的な契約です。

## 構築

更新する可能性のある座標をすべて登録してから構築します。同じ座標を複数回指定しても一つにまとめられます。

```nim
var tree =
  initCompressedSegTree2D(
    @[
      (x: 0, y: 0),
      (x: 1, y: 3),
      (x: 4, y: 2),
    ],
    CommutativeSum,
  )
```

座標を段階的に集める場合はbuilderも使用できます。

```nim
var builder =
  initCompressedSegTree2DBuilder()

builder.addPoint(0, 0)
builder.registerPoint(1, 3)

builder.addPoints(@[
  (x: 4, y: 2),
])

var tree =
  builder.build(
    CommutativeSum
  )
```

## 点操作

```nim
tree.set(0, 0, 10)
tree.combineAt(0, 0, 7)

doAssert tree.get(0, 0) == 17
doAssert tree[0, 0] == 17

tree[0, 0] = 5
```

- `set(x, y, value)` は値を置き換えます。
- `combineAt(x, y, value)` は `op(current, value)` で更新します。
- `get(x, y)` は現在値を返します。
- `containsPoint(x, y)` は登録済み座標か判定します。
- `pointCount` は異なる登録座標対の個数を返します。

同じ `y` を持つ異なる `x` が存在しても、`set` は子から祖先を再計算するため、別の点の寄与を上書きしません。

## 矩形積

```nim
let answer =
  tree.prod(
    xLeft,
    xRight,
    yLeft,
    yRight,
  )
```

対象は半開矩形

```text
[xLeft, xRight) × [yLeft, yRight)
```

です。空矩形では単位元を返します。全登録点の積は `allProd` で取得します。

## 計算量

登録点数を `N` とします。

| 操作 | 計算量 |
|---|---:|
| 構築 | `O(N log N)` |
| `set` | `O(log^2 N)` |
| `combineAt` | `O(log^2 N)` |
| `get` | `O(log N)` |
| `prod` | `O(log^2 N)` |
| `allProd` | `O(1)` |

メモリ使用量は `O(N log N)` です。
