# Boruvka

`Boruvka` は、各連結成分から出る最小辺を反復的に選んで最小全域木の重みを求めるための補助構造です。

辺集合をライブラリ側に直接渡すのではなく、現在の DSU の状態を見ながら「各成分の最良辺」を `update` callback で設定します。そのため、通常の無向 graph だけでなく、問題固有の方法で候補辺を生成したい場合にも使えます。

## import

~~~nim
import atcoder/extra/graph/boruvka
~~~

## 使用例

<!-- nim-line-numbers -->
~~~nim
import atcoder/extra/graph/boruvka

let edges = @[
  (0, 1, 1),
  (1, 2, 2),
  (0, 2, 5),
  (2, 3, 1),
  (1, 3, 4),
]

var b = initBoruvka[int](4)

let cost = b.build(proc(best: var seq[(int, int)]) =
  for (u, v, w) in edges:
    let ru = b.find(u)
    let rv = b.find(v)

    if ru == rv:
      continue

    if w < best[ru][0]:
      best[ru] = (w, rv)

    if w < best[rv][0]:
      best[rv] = (w, ru)
)

doAssert cost == 4
~~~

## callback

~~~nim
proc(best: var seq[(T, int)])
~~~

`best[leader]` に、その連結成分から出る最小辺を `(cost, otherLeader)` として設定します。

`otherLeader` が `-1` のままの成分は、その反復で merge されません。

## disconnected graph

すべての頂点を連結できない場合、`initBoruvka` に渡した `inf` が返ります。

~~~nim
let inf = 1_000_000_000
var b = initBoruvka[int](n, inf)
~~~

## 計算量

各反復で `update` が全候補辺を一度見る場合、頂点数を `n`、辺数を `m` としておおよそ

- `O(m log n)`

です。
