# AtCoder Algorithm Lectures 対応表

確認日: 2026-07-11

このページは AtCoder 公式の Algorithm Lectures と、Nim-ACL の実装・ドキュメント状況を対応付けた独自の棚卸しです。

## 著作権・参照方針

- 公式講座の本文・図・コードは転載しません。
- 掲載するのは講座名、難易度目安、リンク、および Nim-ACL 独自の状況評価です。
- アルゴリズム解説本文は Nim-ACL 側で独自に執筆します。
- 難易度目安や分類は公式側で変更される場合があります。

- [AtCoder Algorithm Lectures 公式一覧](https://info.atcoder.jp/entry/algorithm_lectures/index)

## 状態の意味

| 状態 | 意味 |
|---|---|
| 実装・docsあり | 対応 module と学習 docs を検出 |
| 実装あり | 対応実装を検出したが docs を要確認 |
| 関連実装あり | 完全一致ではないが関連する機能を検出 |
| 未検出（候補） | 今後の追加候補 |
| 理論・参照中心 | module より公式解説への案内を重視 |

## データ構造

| 公式講座 | 難易度 | Nim-ACL 状態 | Nim-ACL docs | 次の対応 |
|---|---:|---|---|---|
| [スパーステーブル](https://info.atcoder.jp/entry/algorithm_lectures/sparse_table) | 3 | 実装・docsあり | [Nim-ACL](../extra/structure/sparse_table.html) | 公式講座への関連リンクを追加 |
| [Disjoint Sparse Table](https://info.atcoder.jp/entry/algorithm_lectures/disjoint_sparse_table) | 4 | 実装・docsあり | [Nim-ACL](../extra/structure/disjoint_sparse_table.html) | 公式講座への関連リンクを追加 |
| [Sqrt Tree](https://info.atcoder.jp/entry/algorithm_lectures/sqrt_tree) | 5 | 実装・docsあり | [Nim-ACL](../extra/structure/sqrt_tree.html) | 公式講座への関連リンクを追加済み |
| [静的な列の区間積クエリ](https://info.atcoder.jp/entry/algorithm_lectures/static_range_product) | 7 | 関連実装あり | — | 公式講座との対応範囲を監査 |
| [Union-Find の計算量上界](https://info.atcoder.jp/entry/algorithm_lectures/unionfind_complexity) | 8 | 理論・参照中心 | — | Nim-ACL docs から公式解説を案内 |
| [Wavelet Matrix（基礎）](https://info.atcoder.jp/entry/algorithm_lectures/wavelet_matrix_basic) | 6 | 実装・docsあり | [Nim-ACL](../extra/structure/wavelet_matrix.html) | 公式講座への関連リンクを追加 |
| [Wavelet Matrix（発展）](https://info.atcoder.jp/entry/algorithm_lectures/wavelet_matrix_advanced) | 7 | 実装・docsあり | [Nim-ACL](../extra/structure/wavelet_matrix.html) | 公式講座への関連リンクを追加 |
| [永続セグメント木](https://info.atcoder.jp/entry/algorithm_lectures/persistent_segment_tree) | 7 | 実装・docsあり | [Nim-ACL](../extra/structure/persistent_segment_tree.html) | 公式講座への関連リンクを追加済み |

## グラフ

| 公式講座 | 難易度 | Nim-ACL 状態 | Nim-ACL docs | 次の対応 |
|---|---:|---|---|---|
| [オイラーツアーテクニック](https://info.atcoder.jp/entry/algorithm_lectures/euler_tour_technique) | 4 | 実装・docsあり | [Nim-ACL](../extra/graph/euler_tour.html) | 公式講座への関連リンクを追加済み |
| [重軽分解（HLD）](https://info.atcoder.jp/entry/algorithm_lectures/heavy_light_decomposition) | 4 | 未検出（候補） | — | 出題頻度・実装コストを評価 |
| [線形時間 LCA](https://info.atcoder.jp/entry/algorithm_lectures/linear_time_lca) | 6 | 関連実装あり | — | 公式講座との対応範囲を監査 |
| [グラフ理論用語集](https://info.atcoder.jp/entry/algorithm_lectures/graph_terms) | 1 | 理論・参照中心 | — | Nim-ACL docs から公式解説を案内 |
| [単純無向グラフの次数列](https://info.atcoder.jp/entry/algorithm_lectures/degree_sequence) | 6 | 未検出（候補） | — | 出題頻度・実装コストを評価 |

## 整数論

| 公式講座 | 難易度 | Nim-ACL 状態 | Nim-ACL docs | 次の対応 |
|---|---:|---|---|---|
| [合同式の基礎](https://info.atcoder.jp/entry/algorithm_lectures/modular_arithmetic) | 1 | 関連実装あり | — | 公式講座との対応範囲を監査 |
| [Euclid の互除法](https://info.atcoder.jp/entry/algorithm_lectures/euclidean_algorithm) | 2 | 理論・参照中心 | — | Nim-ACL docs から公式解説を案内 |
| [素数の性質](https://info.atcoder.jp/entry/algorithm_lectures/prime) | 3 | 理論・参照中心 | — | Nim-ACL docs から公式解説を案内 |
| [素数を法とする多項式](https://info.atcoder.jp/entry/algorithm_lectures/polynomial_over_Fp) | 5 | 関連実装あり | — | 公式講座との対応範囲を監査 |
| [中国剰余定理](https://info.atcoder.jp/entry/algorithm_lectures/chinese_remainder_theorem) | 4 | 実装あり | — | API・学習 docs を監査 |
| [原始根](https://info.atcoder.jp/entry/algorithm_lectures/primitive_root) | 6 | 実装あり | — | API・学習 docs を監査 |

## 多項式・FPS

| 公式講座 | 難易度 | Nim-ACL 状態 | Nim-ACL docs | 次の対応 |
|---|---:|---|---|---|
| [線形漸化的数列](https://info.atcoder.jp/entry/algorithm_lectures/linearly_recurrent_sequence) | 6 | 未検出（候補） | — | 出題頻度・実装コストを評価 |
| [線形漸化的数列の第 K 項](https://info.atcoder.jp/entry/algorithm_lectures/linearly_recurrent_sequence_kth_term) | 6 | 未検出（候補） | — | 出題頻度・実装コストを評価 |
| [Bostan–Mori のアルゴリズム（発展）](https://info.atcoder.jp/entry/algorithm_lectures/bostan_mori_advanced) | 8 | 未検出（候補） | — | 出題頻度・実装コストを評価 |
| [線形漸化式の復元](https://info.atcoder.jp/entry/algorithm_lectures/linearly_recurrent_sequence_reconstruction) | 7 | 未検出（候補） | — | 出題頻度・実装コストを評価 |
| [線形漸化式の復元（mod m）](https://info.atcoder.jp/entry/algorithm_lectures/linearly_recurrent_sequence_reconstruction_mod) | 9 | 未検出（候補） | — | 出題頻度・実装コストを評価 |
| [Faulhaber の公式](https://info.atcoder.jp/entry/algorithm_lectures/faulhaber_formula) | 6 | 未検出（候補） | — | 出題頻度・実装コストを評価 |

## 集合変換

| 公式講座 | 難易度 | Nim-ACL 状態 | Nim-ACL docs | 次の対応 |
|---|---:|---|---|---|
| [ゼータ・メビウス変換（部分集合関係）](https://info.atcoder.jp/entry/algorithm_lectures/subset_zeta_mobius) | 4 | 未検出（候補） | — | 出題頻度・実装コストを評価 |
| [XOR 畳み込み（除算なし）](https://info.atcoder.jp/entry/algorithm_lectures/division_free_xor_convolution) | 8 | 未検出（候補） | — | 出題頻度・実装コストを評価 |

## その他

| 公式講座 | 難易度 | Nim-ACL 状態 | Nim-ACL docs | 次の対応 |
|---|---:|---|---|---|
| [凸数列の min-plus 畳み込み](https://info.atcoder.jp/entry/algorithm_lectures/min_plus_convolution) | 4 | 未検出（候補） | — | 出題頻度・実装コストを評価 |
| [Color-Coding](https://info.atcoder.jp/entry/algorithm_lectures/color_coding) | 5 | 未検出（候補） | — | 出題頻度・実装コストを評価 |
| [代数構造用語集](https://info.atcoder.jp/entry/algorithm_lectures/algebra_terms) | 6 | 理論・参照中心 | — | Nim-ACL docs から公式解説を案内 |

## 優先候補の見方

公式講座にあることだけで実装優先度を決めるわけではありません。
次の要素を合わせて判断します。

1. AtCoder / Codeforces / yukicoder での利用頻度
2. Library Checker に検証問題があるか
3. 既存 Nim-ACL module との依存関係
4. 実装・テスト・保守コスト
5. Nim の macro、template、operator で読みやすい API にできるか

特に `未検出（候補）` のうち、Sqrt Tree、永続 Segment Tree、Euler Tour、線形漸化数列、Bostan–Mori、subset transform などは、追加候補として別途優先順位を付けます。

