# AC(AtCoder) Library Document

## インストール方法

- zipファイルを解凍すると、`ac-library`フォルダ, そしてその中に`atcoder`フォルダが入っているはずです。
- g++を使っている場合, `atcoder`フォルダを`main.cpp`と同じ場所に置いて、`g++ main.cpp -std=c++14 -I .`でコンパイルできます。  
  - `-std=c++14`か`-std=c++17`をつけてコンパイルする必要があります。
- 詳しくは [Appendix](./appendix.html) を参照してください。

## お約束

- 制約外の入力を入れたときの挙動はすべて未定義です。
- このドキュメントでは長い型を便宜上短く書きます
  - `unsigned int` → `uint`
  - `long long` → `ll`
  - `unsigned long long` → `ull`
- $0^0$ は $1$ です
- 明記されていない場合、多重辺や自己ループも入力可能です。

## リスト

`import atcoder/all` : 一括include

### データ構造

- [`import atcoder/fenwicktree`](./fenwicktree.html)
- [`import atcoder/segtree`](./segtree.html)
- [`import atcoder/lazysegtree`](./lazysegtree.html)
- [`import atcoder/string`](./string.html)

### 数学

- [`import atcoder/math`](./math.html)
- [`import atcoder/convolution`](./convolution.html)
- 💻[`import atcoder/modint`](./modint.html)

### グラフ

- [`import atcoder/dsu`](./dsu.html)
- [`import atcoder/maxflow`](./maxflow.html)
- [`import atcoder/mincostflow`](./mincostflow.html)
- [`import atcoder/scc`](./scc.html)
- [`import atcoder/twosat`](./twosat.html)

## エキストラライブラリ

ACLには収録されていないが、使用頻度が高そうなライブラリを追加しました。

### データ構造
- ソート済みのset, table(map)(C++のset, mapと同機能)  [`import atcoder/extra/structure/set_map`](./extra/structure/sorted_set_map.html)
- Skew Heap
- dual fenwick tree
- Splay Tree
- Universal SegTree
- Wavelet Matrix
- weighted Union Find
- Sliding Window Aggregation
- Radix Heap
- 二分木関係
  - Link Cut Tree
  - Randomized Binary Search Tree
- Sparse Table
- 永続関係
  - 永続配列 [`import atcoder/extra/structure/persistent_array`](./extra/structure/persistent_array.html)
  - 永続DSU [`import atcoder/extra/structure/persistent_dsu`](./extra/structure/persistent_dsu.html)
  - Partially Persistent DSU


### 数学
- 約数系
  - 約数列挙 [`import atcoder/extra/math/divisor`](./extra/math/divisor.html)
  - エラトステネス [`import atcoder/extra/math/eratosthenes`](./extra/math/eratosthenes.html)
  - 素因数分解(pollard-rho法)[`import atcoder/extra/math/factorization`](./extra/math/factorization.html)
- 畳み込み関係
  - 任意modの畳み込み
  - 高速フーリエ変換
  - NTT
  - bitwise畳み込み
- 形式的べき級数関係
  - 形式的べき級数
  - 形式的べき級数(sparse)
- 行列
- 順列・組み合わせ関係
  - コンビネーション(階乗・逆元)[`import atcode/extra/math/combination`](./extra/math/combination.html)
  - コンビネーションテーブル
- 進数変換
- 大きな数の階乗
- modint関係
  - モンゴメリ演算によるmodint
  - modintによる平方根
  - modintの分数推測

### グラフ
- [`import atcoder/extra/graph/graph_template`](./extra/graph/graph_template.html)
- 最短経路問題
  - dijkstra法: [`import atcoder/extra/graph/dijkstra`](./extra/graph/dijkstra.html)
  - bellman-ford法: [`import atcoder/extra/graph/bellman_ford`](./extra/graph/bellman_ford.html)
  - warshall-floyd法: [`import atcoder/extra/graph/warshall_floyd`](./extra/graph/warshall_floyd.html)
- 最小木問題
  - prim法
  - kruskal法
  - volvka法
- 有向グラフの最小木問題
  - Chu-Liu-Edmonds
- 二部グラフの最大マッチング(最小頂点被覆)
  - hopcroft-karp法
- 一般グラフのマッチング
  - gabow-edmonds法
- 割当問題
　- ハンガリアン法
- 橋と結節点
  - lowlink
- 最大独立集合
- サイクルの検出
- オイラー周回
- 彩色数
- トポロジカルソート
- 強連結の向き付け: [`import atcoder/extra/graph/strong_orientation`](./extra/graph/strong_orientation.html)

### 木
- 木の直径
- 重心分解
- lowest common ancestor
- Heavy-Light Decomposition
- 全方位DP(rerooting): [`import atcoder/extra/tree/rerooting`](./extra/tree/rerooting.html)

### その他
- Assignment Operator
- 二分探索
  - 整数版
  - 不動小数版
- bitset
- bitutils
- 座標圧縮
- debug.nim
- decimal.nim
- サイコロ
- 方向(direction.nim)
- floatutils.nim
- 無限(inf.nim)
- インタラクティブ用マクロ
- internal関係
  - internal_complex.nim
  - internal_sugar.nim
- listutils
- 読み込み用(reader.nim)
- 参照渡し
- seq_array_utils
- sliceutils
- solve関数用マクロ
- special_judge.nim
- static_var.nim
- セイウチ演算子
- zip.nim


## 付録

- [Appendix / FAQ](./appendix.html)

## テスト

- [こちら](https://atcoder.jp/contests/practice2) で実際にこの Library を使う問題を解いてみることができます。

## ライセンス

ヘッダファイル群(同梱の `atcoder` フォルダ以下)はCC0ライセンスで公開しています。詳しくは`atcoder/LICENSE`を参照してください。
