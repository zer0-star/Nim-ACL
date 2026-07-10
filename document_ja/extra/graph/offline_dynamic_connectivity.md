# OfflineDynamicConnectivity

`OfflineDynamicConnectivity` は、辺の追加・削除があるグラフを offline に処理するための helper です。

各辺が有効な時間区間 `[l, r)` をあらかじめ与えておき、各時刻 `t` のグラフ状態を `RollbackDSU` で復元しながら query を処理します。

## 使いどころ

次のような問題で使います。

- 無向グラフに辺の追加・削除がある
- 各時刻で連結判定や連結成分数を知りたい
- query がすべて先に与えられる
- fully online でなく、offline 処理でよい
- Rollback DSU と segment tree over time を組み合わせる典型問題

## 考え方

辺 `(u, v)` が時刻区間 `[l, r)` で有効だとします。

時間軸 `[0, q)` に segment tree を作り、区間 `[l, r)` を覆う node にその辺を登録します。

その後、segment tree を DFS します。

- node に入るとき、その node に登録された辺を `RollbackDSU` に merge する
- 葉に到達したら、その時刻のグラフ状態で query を処理する
- node から出るとき、入る前の snapshot まで rollback する

こうすると、各辺は `O(log q)` 個の node にだけ登録され、各時刻の状態を効率よく復元できます。

## import

~~~nim
import atcoder/extra/graph/offline_dynamic_connectivity
~~~

この module は `rollback_dsu` も re-export します。  
callback 内では `RollbackDSU` の `same`, `size`, `componentCount` などをそのまま使えます。

## 型

~~~nim
type OfflineDCEdge = tuple[u, v: int]
type OfflineDynamicConnectivity
~~~

## コンストラクタ

~~~nim
proc initOfflineDynamicConnectivity(n, q: int): OfflineDynamicConnectivity
~~~

- `n`: 頂点数
- `q`: 時刻数。時刻は `0 ..< q` です。

## 辺の追加

~~~nim
proc addEdgeInterval(dc: var OfflineDynamicConnectivity, l, r, u, v: int)
~~~

無向辺 `(u, v)` が半開区間 `[l, r)` で有効であることを登録します。

## 実行

~~~nim
proc run(dc: OfflineDynamicConnectivity, f: proc(t: int, uf: RollbackDSU))
proc componentCounts(dc: OfflineDynamicConnectivity): seq[int]
~~~

- `run(f)` は各時刻 `t` について callback `f(t, uf)` を呼びます。
- callback 内の `uf` は、その時刻のグラフ状態を表します。
- `componentCounts()` は各時刻の連結成分数を返す helper です。

## 使用例

~~~nim
var dc = initOfflineDynamicConnectivity(n = 4, q = 5)

# t = 0: 0-1
# t = 1: 0-1, 1-2
# t = 2: 0-1, 1-2, 2-3
# t = 3: 1-2, 2-3
# t = 4: 1-2
dc.addEdgeInterval(0, 3, 0, 1)
dc.addEdgeInterval(1, 5, 1, 2)
dc.addEdgeInterval(2, 4, 2, 3)

var ans = newSeq[bool](5)

dc.run(proc(t: int, uf: RollbackDSU) =
  ans[t] = uf.same(0, 3)
)

doAssert ans == @[false, false, true, false, false]
~~~

連結成分数だけなら、helper を使えます。

~~~nim
doAssert dc.componentCounts == @[3, 2, 1, 2, 3]
~~~

## Nim らしい使い方

callback と UFCS を使うと、各時刻の query を自然に書けます。

~~~nim
dc.run(proc(t: int, uf: RollbackDSU) =
  echo t, ": ", uf.componentCount
)
~~~

## 計算量

時刻数を `q`、登録した有効区間数を `m` とします。

- edge interval の登録: `O(log q)`
- DFS 全体: `O(m log q * log n + q * callback)`
- memory: `O(m log q)`

`RollbackDSU` は path compression を使わないため、`merge` / `same` / `size` は `O(log n)` 程度です。

## 注意

- 辺の有効区間 `[l, r)` は自分で作る必要があります。
- 入力が `add edge` / `delete edge` の形なら、edge ごとに追加時刻を table で管理し、削除時に `[addTime, deleteTime)` を登録します。
- この module は graph state を復元する枠組みです。各時刻で何を答えるかは callback で自由に書きます。
- fully online な edge deletion には使えません。

## 関連資料・他言語ライブラリ

- [cp-algorithms: Deleting from a data structure in O(T(n) log n)](https://cp-algorithms.com/data_structures/deleting_in_log_n.html)
- [Library Checker: Dynamic Graph Vertex Add Component Sum](https://judge.yosupo.jp/problem/dynamic_graph_vertex_add_component_sum)
- Nyaan Library: Offline Dynamic Connectivity
- ei1333 Library: Offline Dynamic Connectivity
