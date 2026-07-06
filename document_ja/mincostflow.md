# MinCostFlow

[Minimum-cost flow problem](https://en.wikipedia.org/wiki/Minimum-cost_flow_problem)を扱うライブラリです。

## コンストラクタ

```nim
var graph = init_mcf_graph[Cap, Cost](int n)
```

$n$ 頂点 $0$ 辺のグラフを作る。`Cap`は容量の型、`Cost`はコストの型

**@{keyword.constraints}**

- $0 \leq n \leq 10^8$
- `Cap, Cost` は `int, ll`

**@{keyword.complexity}**

- $O(n)$

## add_edge

```nim
graph.add_edge(src:int, dst:int, cap:Cap, cost:Cost):int
```

`from`から`to`へ最大容量`cap`, コスト`cost`の辺を追加する。何番目に追加された辺かを返す。

**@{keyword.constraints}**

- $0 \leq \mathrm{from}, \mathrm{to} \lt n$
- $0 \leq \mathrm{cap}, \mathrm{cost}$

**@{keyword.complexity}**

- ならし $O(1)$

## min_cost_max_flow

```nim
(1) graph.flow(s:int, t:int):(Cap, Cost)
(2) graph.flow(s:int, t:int, flow_limit:Cap):(Cap, Cost)
```

$s$ から $t$ へ流せるだけ流し、その流量とコストを返す。

- (1) sからtへ流せるだけ流す
- (2) sからtへ流量`flow_limit`まで流せるだけ流す

**@{keyword.constraints}**

- `min_cost_slope`と同じ

**@{keyword.complexity}**

- `min_cost_slope`と同じ

## min_cost_slope

```nim
graph.slope(s:int, t:int):seq[(Cap, Cost)]
graph.slope(s:int, t:int, flow_limit:Cap):seq[(Cap, Cost)]
```

帰り値に流量とコストの関係の折れ線が入る。全ての $x$ について、流量 $x$ の時の最小コストを $g(x)$ とすると、$(x, g(x))$ は帰り値を折れ線として見たものに含まれる。

- 帰り値の最初の要素は $(0, 0)$
- 帰り値の`.first`、`.second`は共に狭義単調増加
- 3点が同一線上にあることはない
- (1) 帰り値の最後の要素は最大流量 $x$ として $(x, g(x))$
- (2) 帰り値の最後の要素は $y = \min(x, \mathrm{flow\\_limit})$ として $(y, g(y))$

**@{keyword.constraints}**

辺のコストの最大を $x$ として

- $s \neq t$
- `min_cost_slope`や`min_cost_max_flow`を合わせて複数回呼んだときの挙動は未定義
- `s`から`t`へ流したフローの流量が `Cap` に収まる。
- 流したフローのコストの総和が `Cost` に収まる。
- (Cost : `int`): $0 \leq nx \leq 2 \times 10^9 + 1000$
- (Cost : `ll`): $0 \leq nx \leq 8 \times 10^{18} + 1000$

**@{keyword.complexity}**

$F$を流量、$m$を追加した辺の本数として

- $O(F (n + m) \log n)$

## edges

```nim
type edge_info[Cap, Cost] =
  src, dst:int
  cap, flow: Cap
  cost:Cost

(1) graph.get_edge(int i):edge_info[Cap, Cost]
(2) graph.edges():seq[edge_info[Cap, Cost]]
```

- 今の内部の辺の状態を返す
- 辺の順番はadd_edgeで追加された順番と同一

$m$ を追加された辺数として

**@{keyword.constraints}**

- (1): $0 \leq i \lt m$

**@{keyword.complexity}**

- (1): $O(1)$
- (2): $O(m)$

## @{keyword.examples}

@{example.mincostflow_practice}
