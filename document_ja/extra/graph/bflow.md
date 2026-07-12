# 最小費用B-flow

下限・上限付き有向辺、各頂点の供給量・需要量、および辺費用を持つ
最小費用B-flow問題を解きます。

## 一般形

~~~nim
var flow =
  initBFlow[Capacity, Cost](
    vertexCount,
  )

flow.add_supply(
  vertex,
  supply,
)

flow.add_demand(
  vertex,
  demand,
)

flow.add_edge(
  source,
  target,
  lowerCapacity,
  upperCapacity,
  cost,
)

let (feasible, minimumCost) =
  flow.solve()
~~~

## 引数・型

- `CAP`: 容量、供給量、需要量、flowの型
- `COST`: 辺費用、最小費用、potentialの型
- `vertexCount`: 頂点数
- `add_supply(v, amount)`: 頂点`v`へ供給量を追加
- `add_demand(v, amount)`: 頂点`v`へ需要量を追加
- `add_edge(s, t, lower, upper, cost)`: 下限・上限・単位費用付き有向辺を追加

辺は追加順に番号付けされます。平行辺を追加できます。負の辺費用にも対応します。

## 前提条件

- 頂点番号は`0 ..< vertexCount`
- `CAP`と`COST`は内部の最大流・費用スケーリング実装に必要な
  四則演算と比較をサポートする
- 各辺では通常`lower <= upper`

`lower > upper`の辺を追加すると`flow.infeasible`が`true`になります。

一般の実行可能性判定には`flow.infeasible`ではなく、必ず`solve()`の
返り値の第1要素を使用してください。容量不足や供給・需要総量の不一致では、
`solve()[0]`が`false`でも`flow.infeasible`は`false`のままです。

## 返り値と副作用

~~~nim
let (feasible, minimumCost) =
  flow.solve()
~~~

- `feasible`: 実行可能なB-flowが存在するか
- `minimumCost`: 実行可能な場合の最小費用
- `flow.f[edgeId]`: 追加順の辺`edgeId`へ流れたflow
- `flow.potential[v]`: solve後の頂点`v`のpotential
- `flow.infeasible`: `lower > upper`を追加したことを示す事前検査フラグ

`solve()[0]`が一般の実行可能性を表す正本です。

## 具体例

~~~nim
import atcoder/extra/graph/bflow

var flow =
  initBFlow[int, int](2)

flow.add_supply(
  0,
  2,
)

flow.add_demand(
  1,
  2,
)

flow.add_edge(
  0,
  1,
  2,
  5,
  3,
)

let answer =
  flow.solve()

doAssert answer ==
  (true, 6)

doAssert flow.f ==
  @[2]
~~~

## 関連API

- `MinCostFlow`: 通常の始点・終点・流量指定型の最小費用流
- `MinCostFlowLowerBound`: 下限制約付き最小費用流
- `MFGraph`: 最大流

このmoduleは下限・上限、頂点balance、費用を1つのB-flow問題として扱います。
内部では最大流と費用スケーリング型最小費用流を組み合わせます。

## 計算量と内部実装

- `initBFlow`: `O(vertexCount)`
- `add_supply`, `add_demand`, `add_edge`: 償却`O(1)`
- `solve`: 内部の最大流および費用スケーリング最小費用流の計算量に従う
- メモリ: `O(vertexCount + edgeCount)`に内部solverの作業領域を加えた量

`solve`の詳細な上界は、内部で利用する`MFGraph`と`MCFCostScaling`に依存します。
