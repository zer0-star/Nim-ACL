# AtCoder 色別ライブラリガイド

このページでは、Nim-ACL のライブラリを AtCoder のおおまかな色帯に合わせて分類します。

分類は絶対的なものではありません。同じアルゴリズムでも、問題への気づき方や他の技法との組み合わせによって難易度は大きく変わります。

ここでは、次の目安を使います。

| 区分 | 色の目安 | 想定 |
|---|---|---|
| 初級 | 灰・茶・緑以下 | ABC の A〜D、基本的な E |
| 中級 | 水・青以下 | ABC E〜F、ARC の基本問題 |
| 上級 | 黄以上 | ARC 上位、AGC、CF Div.1、Library Checker 上級 |


## AtCoder 公式講座との関係

このページの「初級・中級・上級」は Nim-ACL 独自の利用頻度・色帯分類です。
AtCoder Algorithm Lectures の難易度 1〜9 とは別の指標です。

公式講座との対応状況は
[AtCoder Algorithm Lectures 対応表](./atcoder_algorithm_lectures_coverage.html)
を参照してください。

## 記号

- **必須**：その色帯で優先して覚えたい
- **推奨**：出題頻度が高く、覚える価値が大きい
- **発展**：特定の問題で非常に強い
- **内部・高度**：利用よりも実装理解や特殊用途向け

---

# 初級：緑以下

初級では、難しい data structure を大量に覚えるより、

1. 配列・文字列を整理する
2. graph を正しく走査する
3. prefix sum や DSU で計算量を落とす
4. よく出る定型処理をライブラリ化する

ことが重要です。

## 最初に覚えたいもの

| 分野 | ライブラリ | 重要度 | 典型的な用途 |
|---|---|---:|---|
| 配列 | [Coordinate Compression](../extra/algorithm/coordinate_compression.html) | 必須 | 大きい座標を `0 ..< k` に圧縮 |
| 配列 | [Run-Length Encoding](../extra/algorithm/run_length_encoding.html) | 必須 | 連続する同値要素を run にまとめる |
| 集合 | [MexSet](../extra/structure/mex_set.html) | 推奨 | 動的な mex |
| 集合 | [SortedSet / SortedMap](../extra/structure/sorted_set_map.html) | 推奨 | 順序付き集合・写像 |
| graph | Dijkstra | 必須 | 非負辺の最短路 |
| graph | 0-1 BFS / Dijkstra01 | 推奨 | 重みが 0/1 の最短路 |
| graph | Topological Sort | 必須 | DAG の順序・DP |
| graph | Cycle Detection | 推奨 | graph の cycle 判定 |
| graph | Kruskal / Prim | 推奨 | 最小全域木 |
| graph | [Functional Graph / Doubling](../extra/graph/functional_graph.html) | 推奨 | 写像を `k` 回適用 |
| 文字列 | [KMP / Prefix Function](../extra/string/kmp.html) | 推奨 | pattern 検索・周期 |
| 幾何 | [Geometry facade](../extra/geometry/geometry.html) | 発展 | 点・直線・円の基本操作 |

## ACL 本体で優先して覚えるもの

次の module は競技プログラミングの基礎です。

~~~nim
import atcoder/dsu
import atcoder/fenwicktree
import atcoder/segtree
import atcoder/modint
~~~

### DSU

無向 graph の連結成分を管理します。

典型的なキーワード：

- 頂点を順に結ぶ
- 同じ連結成分か
- 連結成分サイズ
- Kruskal

### Fenwick Tree

点加算・prefix sum に向いています。

典型的なキーワード：

- inversion number
- prefix sum を更新付きで求める
- 座標圧縮後の頻度管理

### Segment Tree

区間積・点更新を扱います。

典型的なキーワード：

- 区間最小・最大・和
- 点更新
- 二分探索付き区間 query

## 初級のおすすめ学習順

1. Run-Length Encoding
2. Coordinate Compression
3. Cumulative Sum
4. DSU
5. Fenwick Tree
6. Dijkstra
7. Topological Sort
8. Segment Tree
9. Functional Graph / Doubling
10. KMP

## 初級の逆引き

| 問題文の特徴 | 候補 |
|---|---|
| 値が `10^9` だが種類数は少ない | Coordinate Compression |
| 同じ文字・値が連続している | Run-Length Encoding |
| `k` 回移動し、`k` が非常に大きい | Functional Graph / Doubling |
| 連結成分を追加しながら管理 | DSU |
| prefix sum を更新したい | Fenwick Tree |
| pattern の全出現位置 | KMP |
| mex を追加・削除付きで求める | MexSet |
| 最短路、辺重みが非負 | Dijkstra |
| 依存関係・先行順序 | Topological Sort |

---

# 中級：青以下

中級では、問題の構造に応じて data structure を選ぶ力が重要になります。

「とりあえず Segment Tree」ではなく、

- 静的か動的か
- 演算が冪等か
- query が online か offline か
- XOR や文字列に特別な構造があるか

を見分けます。

## 区間 query・集合

| ライブラリ | 重要度 | 典型的な用途 |
|---|---:|---|
| [Sparse Table](../extra/structure/sparse_table.html) | 推奨 | 静的・冪等な区間 query |
| [Disjoint Sparse Table](../extra/structure/disjoint_sparse_table.html) | 推奨 | 静的・結合的な区間 query |
| [FastSet](../extra/structure/fast_set.html) | 推奨 | successor / predecessor |
| [Binary Trie](../extra/structure/binary_trie.html) | 必須 | XOR 最小・最大 |
| [Wavelet Matrix](../extra/structure/wavelet_matrix.html) | 発展 | 区間 k-th、頻度、rank |
| [SegTree2D](../extra/structure/segtree_2d.html) | 発展 | 二次元点・矩形 query |
| [Mo's Algorithm](../extra/algorithm/mo.html) | 推奨 | offline range query |
| [Cartesian Tree](../extra/structure/cartesian_tree.html) | 発展 | RMQ、単調 stack、木への変換 |

## 最適化 DP・直線集合

| ライブラリ | 重要度 | 典型的な用途 |
|---|---:|---|
| [Convex Hull Trick Add Monotone](../extra/structure/convex_hull_trick_add_monotone.html) | 発展 | 傾きが単調な一次関数 DP |
| [Li Chao Tree](../extra/structure/li_chao_tree.html) | 発展 | 一般的な一次関数最小値 query |
| Lazy Segment Tree | 必須 | 区間更新・区間 query |
| Dual Fenwick Tree | 推奨 | 区間更新・点取得 |

## XOR・数学

| ライブラリ | 重要度 | 典型的な用途 |
|---|---:|---|
| [XOR Basis](../extra/math/xor_basis.html) | 推奨 | subset XOR、cycle XOR |
| Binary Trie | 必須 | 集合内の値との XOR 最適化 |
| modint | 必須 | mod 計算 |
| convolution | 発展 | 多項式積・数え上げ |

## 文字列

| ライブラリ | 重要度 | 典型的な用途 |
|---|---:|---|
| [Manacher](../extra/string/manacher.html) | 推奨 | 回文半径・回文判定 |
| [Aho-Corasick](../extra/string/aho_corasick.html) | 推奨 | 複数 pattern matching |
| [Minimum Rotation / Booth](../extra/string/minimum_rotation.html) | 発展 | 最小巡回表現 |
| Rolling Hash | 推奨 | substring 比較・LCP |
| Suffix Array / LCP | 推奨 | substring の順序・検索 |

## 木 DP

| ライブラリ | 重要度 | 典型的な用途 |
|---|---:|---|
| [Rerooting DP](../extra/graph/rerooting_dp.html) | 必須 | 全頂点を root とした木 DP |
| Heavy-Light Decomposition | 発展 | 木上の path query |
| LCA / Binary Lifting | 必須 | ancestor、距離、path |
| [Euler Tour](../extra/graph/euler_tour.html) | 推奨 | subtree を区間へ変換 |
| Weighted Union Find | 推奨 | 差分制約・potential |

## 中級のおすすめ学習順

1. Lazy Segment Tree
2. Sparse Table
3. Disjoint Sparse Table
4. Binary Trie
5. XOR Basis
6. Manacher
7. Rolling Hash
8. Mo's Algorithm
9. Rerooting DP
10. Wavelet Matrix
11. Convex Hull Trick
12. Li Chao Tree

## 区間 data structure の使い分け

| 条件 | 選ぶもの |
|---|---|
| 静的、min/max/gcd | Sparse Table |
| 静的、sum/product/concat | Disjoint Sparse Table |
| 点更新あり | Segment Tree |
| 区間更新あり | Lazy Segment Tree |
| offline、add/remove が軽い | Mo |
| 区間 k-th / rank / frequency | Wavelet Matrix |
| 二次元座標 | SegTree2D |

## 文字列の使い分け

| 欲しいもの | 選ぶもの |
|---|---|
| 1 pattern の検索 | KMP |
| 多数 pattern の検索 | Aho-Corasick |
| substring の hash 比較 | Rolling Hash |
| 回文判定・回文半径 | Manacher |
| 最小巡回表現 | Minimum Rotation |
| substring の辞書順 | Suffix Array |
| 異なる substring の状態 | Suffix Automaton |

---

# 上級：黄以上

上級では、単独のアルゴリズムを知っているだけではなく、

- offline 化
- rollback
- 木や graph の圧縮
- 複数 data structure の組み合わせ
- 問題固有の invariant

が必要になります。

## 動的 graph・rollback

| ライブラリ | 重要度 | 典型的な用途 |
|---|---:|---|
| [Rollback DSU](../extra/structure/rollback_dsu.html) | 必須 | DSU の状態を巻き戻す |
| [Offline Dynamic Connectivity](../extra/graph/offline_dynamic_connectivity.html) | 必須 | 辺追加・削除付き連結性 |
| Partially Persistent DSU | 発展 | 過去時刻の DSU query |

### DSU の使い分け

| 問題 | 選ぶもの |
|---|---|
| 現在の連結状態だけ | DSU |
| DFS / 分割統治で状態を戻す | Rollback DSU |
| 各辺の有効時間区間がある | Offline Dynamic Connectivity |
| 過去時刻の状態を直接 query | Partially Persistent DSU |

## 木の圧縮・subtree query

| ライブラリ | 重要度 | 典型的な用途 |
|---|---:|---|
| [Virtual Tree](../extra/graph/virtual_tree.html) | 必須 | 指定頂点集合だけの圧縮木 |
| [DSU on Tree](../extra/graph/dsu_on_tree.html) | 必須 | 各 subtree の頻度集計 |
| Rerooting DP | 必須 | 全 root に対する木 DP |
| Link-Cut Tree | 内部・高度 | 動的 forest |

## 無向 graph 分解

| ライブラリ | 重要度 | 典型的な用途 |
|---|---:|---|
| [Undirected Graph Decomposition](../extra/graph/undirected_decomposition.html) | 必須 | Low-link 分解の共通 API |
| [Biconnected Components](../extra/graph/biconnected_components.html) | 推奨 | 関節点で分かれる block |
| [Two-Edge-Connected Components](../extra/graph/two_edge_connected_components.html) | 推奨 | 橋を除いた component |
| [Block-Cut Tree](../extra/graph/block_cut_tree.html) | 発展 | block と articulation の木 |

### Low-link 系の使い分け

| 欲しいもの | 選ぶもの |
|---|---|
| bridge / articulation point | LowLink |
| 関節点で分かれる component | Biconnected Components |
| bridge で分かれる component | Two-Edge-Connected Components |
| component を木として DP | Block-Cut Tree |

## 高度な文字列

| ライブラリ | 重要度 | 典型的な用途 |
|---|---:|---|
| [Suffix Automaton](../extra/string/suffix_automaton.html) | 推奨 | 異なる substring・出現回数 |
| [Palindromic Tree / Eertree](../extra/string/palindromic_tree.html) | 発展 | 異なる回文・回文 suffix DP |
| Aho-Corasick | 推奨 | automaton 上の文字列 DP |
| Suffix Array / LCP | 必須 | substring の順序構造 |

### 回文 algorithm の使い分け

| 欲しいもの | 選ぶもの |
|---|---|
| 各中心の回文半径 | Manacher |
| substring が回文か | Manacher |
| 異なる回文の一覧 | Palindromic Tree |
| 回文ごとの出現回数 | Palindromic Tree |
| 回文 suffix を使う DP | Palindromic Tree |

## 多項式・高度な数学

| ライブラリ | 重要度 | 典型的な用途 |
|---|---:|---|
| [FPS facade](../extra/math/fps.html) | 発展 | 形式的冪級数 |
| convolution / NTT | 必須 | 多項式積 |
| Arbitrary Mod Combination | 推奨 | 合成数 mod の組合せ |
| XOR Basis | 推奨 | GF(2) 線形代数 |


## 高度な静的・永続区間 data structure

| ライブラリ | 重要度 | 典型的な用途 |
|---|---:|---|
| [Sqrt Tree](../extra/structure/sqrt_tree.html) | 発展 | 静的モノイド列の大量区間 query |
| [Persistent Segment Tree](../extra/structure/persistent_segment_tree.html) | 推奨 | 過去 version の区間 query |

## 高度な graph

次の分野は、出題頻度は低めですが、必要な問題では代替が難しいです。

~~~nim
import atcoder/extra/graph/chu_liu_edmonds
import atcoder/extra/graph/boruvka
~~~

- Chu-Liu/Edmonds：有向最小全域木
- Borůvka：component 単位の最小全域木
- Dominator Tree：有向 graph の支配関係
- Mo on Tree：木上の offline path query

## 上級のおすすめ学習順

1. Rollback DSU
2. Offline Dynamic Connectivity
3. Virtual Tree
4. DSU on Tree
5. Biconnected Components
6. Two-Edge-Connected Components
7. Block-Cut Tree
8. Suffix Automaton
9. Palindromic Tree
10. FPS
11. Link-Cut Tree
12. Dominator Tree

---

# 目的別の逆引き

## XOR

| 問題 | ライブラリ |
|---|---|
| 集合中の値との XOR 最大・最小 | Binary Trie |
| subset XOR で作れる値 | XOR Basis |
| 区間 XOR basis | Segment Tree + XOR Basis |
| graph の cycle XOR | XOR Basis |

## 回文

| 問題 | ライブラリ |
|---|---|
| 最長回文 substring | Manacher |
| 多数の回文判定 | Manacher |
| 異なる回文数 | Palindromic Tree |
| 回文出現回数 | Palindromic Tree |

## 木

| 問題 | ライブラリ |
|---|---|
| subtree query を全頂点で | DSU on Tree |
| root を全頂点に変える | Rerooting DP |
| 指定頂点だけが重要 | Virtual Tree |
| path query | Heavy-Light Decomposition |
| 動的 forest | Link-Cut Tree |

## graph connectivity

| 問題 | ライブラリ |
|---|---|
| 辺追加のみ | DSU |
| 辺追加・削除を offline | Offline Dynamic Connectivity |
| 状態を DFS 中に戻す | Rollback DSU |
| bridge / articulation | LowLink |
| component へ分解 | BCC / 2ECC |
| component tree で DP | Block-Cut Tree |

## 文字列検索

| 問題 | ライブラリ |
|---|---|
| 1 pattern | KMP |
| 多数 pattern | Aho-Corasick |
| hash で substring 比較 | Rolling Hash |
| 全 substring の状態 | Suffix Automaton |
| substring の辞書順 | Suffix Array |

---

# コンテスト別の目安

## ABC A〜C

優先度が高いもの：

- Run-Length Encoding
- Coordinate Compression
- cumulative sum
- basic graph traversal
- DSU
- modint

## ABC D〜E

優先度が高いもの：

- Fenwick Tree
- Segment Tree
- Dijkstra
- Functional Graph / Doubling
- KMP
- MexSet
- SortedSet / SortedMap
- Rerooting DP

## ABC F・ARC

優先度が高いもの：

- Lazy Segment Tree
- Binary Trie
- XOR Basis
- Sparse Table
- Disjoint Sparse Table
- Mo
- Wavelet Matrix
- Manacher
- Aho-Corasick
- Convex Hull Trick
- Li Chao Tree

## ARC 上位・AGC・Codeforces Div.1

候補：

- Rollback DSU
- Offline Dynamic Connectivity
- Virtual Tree
- DSU on Tree
- Biconnected Components
- Block-Cut Tree
- Suffix Automaton
- Palindromic Tree
- FPS
- Link-Cut Tree

---

# 今後の追加候補

Nim-ACL で今後優先したい候補です。

## 初級〜中級

- Z Algorithm の使いやすい facade
- Prefix Sum facade の統一
- Monotonic Queue / Stack helper
- Interval Set

## 中級

- Mo with Updates
- Persistent Binary Trie
- Static Range Frequency facade
- Matrix utility
- Miller-Rabin
- Pollard Rho

## 上級

- Dominator Tree
- Mo on Tree
- Segment Tree Beats facade
- Dynamic Tree DP
- Li Chao Tree persistent version
- General matching / blossom
- Min-plus convolution 系

---

# 学習方針

ライブラリを暗記するより、次を説明できる状態を目指すのがおすすめです。

1. 何を高速化するアルゴリズムか
2. 素朴解は何計算量か
3. 前提条件は何か
4. update/query が online か offline か
5. 使用する data structure の invariant は何か
6. 似たライブラリとどう使い分けるか

Nim-ACL の高度な module では、API だけでなく「概要・使いどころ・考え方」も記載していきます。
