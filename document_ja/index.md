# AC(AtCoder) Library Document

## インストール方法

- zipファイルを解凍すると、`ac-library`フォルダ, そしてその中に`atcoder`フォルダが入っているはずです。
- g++を使っている場合, `atcoder`フォルダを`main.nim`と同じ場所に置いて、`nim cpp main.nim --include:.`でコンパイルできます。  
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
- Tree backends [`import atcoder/extra/structure/tree_backends`](./extra/structure/tree_backends.html)
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
  - 形式的べき級数 [`import atcoder/extra/math/formal_power_series`](./extra/math/formal_power_series.html)
  - 形式的べき級数(sparse)
- 行列
- 順列・組み合わせ関係
  - コンビネーション(階乗・逆元)[`import atcoder/extra/math/combination`](./extra/math/combination.html)
  - コンビネーションテーブル
- 進数変換
- 大きな数の階乗
- modint関係
  - モンゴメリ演算によるmodint
  - modintによる平方根
  - modintの分数推測

### グラフ
- [`import atcoder/extra/graph/graph_template`](./extra/graph/graph_template.html)
- [`import atcoder/extra/graph/static_graph`](./extra/graph/static_graph.html)
- 最短経路問題
  - dijkstra法
    - [`import atcoder/extra/graph/dijkstra`](./extra/graph/dijkstra.html)
- [`import atcoder/extra/graph/dijkstra_radix_heap`](./extra/graph/dijkstra_radix_heap.html)
  - bellman-ford法
    - [`import atcoder/extra/graph/bellman_ford`](./extra/graph/bellman_ford.html)
  - warshall-floyd法
    - [`import atcoder/extra/graph/warshall_floyd`](./extra/graph/warshall_floyd.html)
- 最小木問題
  - prim法
  - kruskal法
- [`import atcoder/extra/graph/boruvka`](./extra/graph/boruvka.html)
  - Boruvka法
- 有向グラフの最小木問題
  - [`import atcoder/extra/graph/chu_liu_edmonds`](./extra/graph/chu_liu_edmonds.html)
- 二部グラフの最大マッチング・最小頂点被覆(hopcroft-karp法)
  - [`import atcoder/extra/graph/hopcroft_karp`](./extra/graph/hopcroft_karp.html)
- 一般グラフのマッチング(gabow-edmonds法)
- 割当問題(ハンガリアン法)
  - [`import atcoder/extra/graph/hungarian`](./extra/graph/hungarian.html)
- 橋と結節点(lowlink)
- 最大独立集合
- サイクルの検出
- オイラー周回
- 彩色数
- トポロジカルソート
- 強連結の向き付け
  - [`import atcoder/extra/graph/strong_orientation`](./extra/graph/strong_orientation.html)

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

<!-- PROMOTED-EXTRA-LIBRARY-DOCS:BEGIN -->
- [sorted_set_map](extra/structure/sorted_set_map.html)
- [set_map](extra/structure/set_map.html)
- [universal_segtree](extra/structure/universal_segtree.html)
- [weighted_union_find](extra/structure/weighted_union_find.html)
- [dual_fenwicktree](extra/structure/dual_fenwicktree.html)
- [sparse_table](extra/structure/sparse_table.html)
- [radix_heap](extra/structure/radix_heap.html)
- [partially_persistent_dsu](extra/structure/partially_persistent_dsu.html)
- [segtree_2d](extra/structure/segtree_2d.html)
- [wavelet_matrix](extra/structure/wavelet_matrix.html)
- [succinct_indexable_dictionary](extra/structure/succinct_indexable_dictionary.html)
- [li_chao_tree](extra/structure/li_chao_tree.html)
- [convex_hull_trick_add_monotone](extra/structure/convex_hull_trick_add_monotone.html)
- [dynamic_segtree](dynamic_segtree.html)
- [dynamic_lazysegtree](dynamic_lazysegtree.html)
<!-- PROMOTED-EXTRA-LIBRARY-DOCS:END -->

## 付録

- [Appendix / FAQ](./appendix.html)

## テスト

- [こちら](https://atcoder.jp/contests/practice2) で実際にこの Library を使う問題を解いてみることができます。

## ライセンス

ヘッダファイル群(同梱の `atcoder` フォルダ以下)はCC0ライセンスで公開しています。詳しくは`atcoder/LICENSE`を参照してください。

<!-- AUTO-GENERATED-DOC-LINKS:BEGIN -->

## 自動生成ドキュメント一覧

この節は `tools/create_missing_docs_and_update_index.py` により自動更新されます。

### 標準ライブラリ

- [convolution](convolution.md)
- [dsu](dsu.md)

- [element_concepts](element_concepts.md)
- [fenwicktree](fenwicktree.md)
- [header](header.md)
- [lazysegtree](lazysegtree.md)
- [math](math.md)
- [maxflow](maxflow.md)
- [mincostflow](mincostflow.md)
- [modint](modint.md)
- [monoid](monoid.md)
- [rangeutils](rangeutils.md)
- [scc](scc.md)
- [segtree](segtree.md)
- [string](string.md)
- [twosat](twosat.md)

### Extra / データ構造

- [binary_tree_node_utils](extra/structure/binary_tree_node_utils.md)
- [binary_tree_utils](extra/structure/binary_tree_utils.md)

- [generalized_slope_trick](extra/structure/generalized_slope_trick.md)

- [link_cut_tree](extra/structure/link_cut_tree.md)
- [mo](extra/structure/mo.md)
- [persistent_array](extra/structure/persistent_array.md)
- [persistent_dsu](extra/structure/persistent_dsu.md)
- [randomized_binary_search_tree_with_parent](extra/structure/randomized_binary_search_tree_with_parent.md)
- [range_chmin_chmax_add_range_sum](extra/structure/range_chmin_chmax_add_range_sum.md)
- [red_black_tree](extra/structure/red_black_tree.md)

- [set_map_by_randomized_binary_search_tree](extra/structure/set_map_by_randomized_binary_search_tree.md)
- [skew_heap](extra/structure/skew_heap.md)
- [sliding_window_aggregation](extra/structure/sliding_window_aggregation.md)
- [slope_trick](extra/structure/slope_trick.md)

- [splay_tree](extra/structure/splay_tree.md)

- [trie](extra/structure/trie.md)

### Extra / グラフ

- [bellman_ford](extra/graph/bellman_ford.md)
- [bflow](extra/graph/bflow.md)
- [boruvka](extra/graph/boruvka.md)
- [chromatic_number](extra/graph/chromatic_number.md)
- [chu_liu_edmonds](extra/graph/chu_liu_edmonds.md)
- [cycle_detection](extra/graph/cycle_detection.md)
- [dijkstra](extra/graph/dijkstra.md)
- [dijkstra_multi_dimensional](extra/graph/dijkstra_multi_dimensional.md)
- [dijkstra_radix_heap](extra/graph/dijkstra_radix_heap.md)
- [dijkstra_result](extra/graph/dijkstra_result.md)
- [ear_decomposition](extra/graph/ear_decomposition.md)
- [eulerian_trail](extra/graph/eulerian_trail.md)
- [gabow_edmonds](extra/graph/gabow_edmonds.md)
- [graph_concept](extra/graph/graph_concept.md)
- [graph_template](extra/graph/graph_template.md)
- [graph_template_directed_undirected](extra/graph/graph_template_directed_undirected.md)
- [graphviz](extra/graph/graphviz.md)
- [hopcroft_karp](extra/graph/hopcroft_karp.md)
- [hungarian](extra/graph/hungarian.md)
- [kruskal](extra/graph/kruskal.md)
- [lowlink](extra/graph/lowlink.md)
- [maxflow_lowerbound](extra/graph/maxflow_lowerbound.md)
- [maximum_independent_set](extra/graph/maximum_independent_set.md)
- [mcf_costscaling](extra/graph/mcf_costscaling.md)
- [mincostflow_generalized](extra/graph/mincostflow_generalized.md)
- [mincostflow_lowerbound](extra/graph/mincostflow_lowerbound.md)
- [prim](extra/graph/prim.md)
- [static_graph](extra/graph/static_graph.md)
- [strong_orientation](extra/graph/strong_orientation.md)
- [topological_sort](extra/graph/topological_sort.md)
- [visualizer](extra/graph/visualizer.md)
- [warshall_floyd](extra/graph/warshall_floyd.md)

### Extra / 木

- [centroid_decomposition](extra/tree/centroid_decomposition.md)
- [doubling_lowest_common_ancestor](extra/tree/doubling_lowest_common_ancestor.md)
- [heavy_light_decomposition](extra/tree/heavy_light_decomposition.md)
- [rerooting](extra/tree/rerooting.md)
- [tree_diameter](extra/tree/tree_diameter.md)

### Extra / 数学

- [arbitrary_mod_combination](extra/math/arbitrary_mod_combination.md)
- [arbitrary_mod_convolution](extra/math/arbitrary_mod_convolution.md)
- [bigint](extra/math/bigint.md)
- [bitwise_convolution](extra/math/bitwise_convolution.md)
- [characteristic_polynomial](extra/math/characteristic_polynomial.md)
- [chirp_z](extra/math/chirp_z.md)
- [coef_of_generating_function](extra/math/coef_of_generating_function.md)
- [combination](extra/math/combination.md)
- [combination_table](extra/math/combination_table.md)
- [composition](extra/math/composition.md)
- [composition_kinoshita_li](extra/math/composition_kinoshita_li.md)
- [convert_base](extra/math/convert_base.md)
- [convolution_int128](extra/math/convolution_int128.md)
- [convolution_universal](extra/math/convolution_universal.md)
- [divisor](extra/math/divisor.md)
- [eratosthenes](extra/math/eratosthenes.md)
- [estimate_modint_frac](extra/math/estimate_modint_frac.md)
- [factorial](extra/math/factorial.md)
- [factorization](extra/math/factorization.md)
- [fft](extra/math/fft.md)
- [fft2d](extra/math/fft2d.md)
- [floor_sum_general](extra/math/floor_sum_general.md)
- [floor_sum_square](extra/math/floor_sum_square.md)
- [formal_power_series](extra/math/formal_power_series.md)
- [formal_power_series_differential_equation](extra/math/formal_power_series_differential_equation.md)
- [formal_power_series_sqrt](extra/math/formal_power_series_sqrt.md)
- [formal_pwoer_series](extra/math/formal_pwoer_series.md)
- [gaussian_elimination_bit](extra/math/gaussian_elimination_bit.md)
- [int128](extra/math/int128.md)
- [kitamasa](extra/math/kitamasa.md)
- [lagrange_polynomial](extra/math/lagrange_polynomial.md)
- [matrix](extra/math/matrix.md)
- [mod_sqrt](extra/math/mod_sqrt.md)
- [modint61](extra/math/modint61.md)
- [modint_asm](extra/math/modint_asm.md)
- [modint_montgomery](extra/math/modint_montgomery.md)
- [multipoint_evaluation](extra/math/multipoint_evaluation.md)
- [multipoint_evaluation_slow](extra/math/multipoint_evaluation_slow.md)
- [newton_method](extra/math/newton_method.md)
- [ntt](extra/math/ntt.md)
- [ntt_quadratic_field](extra/math/ntt_quadratic_field.md)
- [particular_mod_convolution](extra/math/particular_mod_convolution.md)
- [polynomial](extra/math/polynomial.md)
- [polynomial_taylor_shift](extra/math/polynomial_taylor_shift.md)
- [power_projection](extra/math/power_projection.md)
- [quadratic_field](extra/math/quadratic_field.md)
- [rational_approximation](extra/math/rational_approximation.md)
- [simplex](extra/math/simplex.md)
- [sqrt_int](extra/math/sqrt_int.md)
- [static_eratosthenes](extra/math/static_eratosthenes.md)
- [subproduct_tree](extra/math/subproduct_tree.md)
- [zeta_transform](extra/math/zeta_transform.md)

### Extra / DP

- [cumulative_sum](extra/dp/cumulative_sum.md)
- [cumulative_sum_2d](extra/dp/cumulative_sum_2d.md)
- [dual_cumulative_sum](extra/dp/dual_cumulative_sum.md)
- [dual_cumulative_sum_2d](extra/dp/dual_cumulative_sum_2d.md)
- [edit_distance](extra/dp/edit_distance.md)
- [largest_rectangle](extra/dp/largest_rectangle.md)
- [longest_increasing_subsequence](extra/dp/longest_increasing_subsequence.md)
- [slide_min](extra/dp/slide_min.md)

### Extra / 文字列

- [aho_corasick](extra/string/aho_corasick.md)
- [knuth_morris_pratt](extra/string/knuth_morris_pratt.md)
- [rolling_hash](extra/string/rolling_hash.md)
- [run_enumerate](extra/string/run_enumerate.md)
- [run_length_compress](extra/string/run_length_compress.md)
- [suffix_array_utils](extra/string/suffix_array_utils.md)
- [suffix_automaton](extra/string/suffix_automaton.md)

### Extra / 幾何

- [closest_pair](extra/geometry/closest_pair.md)
- [geometry_template](extra/geometry/geometry_template.md)
- [polygon](extra/geometry/polygon.md)
- [segment_graph](extra/geometry/segment_graph.md)
- [tangent](extra/geometry/tangent.md)
- [triangle](extra/geometry/triangle.md)
- [visualizer](extra/geometry/visualizer.md)

### Extra / Monoid

- [monoid](extra/monoid/monoid.md)

### Extra / その他

- [algorithmutils](extra/other/algorithmutils.md)
- [assignment_operator](extra/other/assignment_operator.md)
- [binary_search](extra/other/binary_search.md)
- [binary_search_float](extra/other/binary_search_float.md)
- [bitset](extra/other/bitset.md)
- [bitutils](extra/other/bitutils.md)
- [cfor](extra/other/cfor.md)
- [compress](extra/other/compress.md)
- [copy_proc](extra/other/copy_proc.md)
- [curly_init](extra/other/curly_init.md)
- [debug](extra/other/debug.md)
- [decimal](extra/other/decimal.md)
- [decimal_gmp](extra/other/decimal_gmp.md)
- [decimal_mp](extra/other/decimal_mp.md)
- [decimal_mpfr](extra/other/decimal_mpfr.md)
- [dice](extra/other/dice.md)
- [direction](extra/other/direction.md)
- [divutils](extra/other/divutils.md)
- [floatutils](extra/other/floatutils.md)
- [fold](extra/other/fold.md)
- [format_expression](extra/other/format_expression.md)
- [inf](extra/other/inf.md)
- [interactive](extra/other/interactive.md)
- [listutils](extra/other/listutils.md)
- [operator](extra/other/operator.md)
- [random_tree](extra/other/random_tree.md)
- [reader](extra/other/reader.md)
- [reference](extra/other/reference.md)
- [return_type](extra/other/return_type.md)
- [seq_array_utils](extra/other/seq_array_utils.md)
- [shadowing](extra/other/shadowing.md)
- [sliceutils](extra/other/sliceutils.md)
- [solve_proc](extra/other/solve_proc.md)
- [special_judge](extra/other/special_judge.md)
- [static_var](extra/other/static_var.md)
- [tuple_index](extra/other/tuple_index.md)
- [tuple_indexing](extra/other/tuple_indexing.md)
- [uncompress](extra/other/uncompress.md)
- [warlus_operator](extra/other/warlus_operator.md)
- [zip](extra/other/zip.md)

<!-- AUTO-GENERATED-DOC-LINKS:END -->

## Extra / Math

- FPS facade [`import atcoder/extra/math/fps`](./extra/math/fps.html)

## extra/dp

- [`import atcoder/extra/dp/cumulative_sum`](./extra/dp/cumulative_sum.html)
- [`import atcoder/extra/dp/cumulative_sum_2d`](./extra/dp/cumulative_sum_2d.html)
- [`import atcoder/extra/dp/dual_cumulative_sum_2d`](./extra/dp/dual_cumulative_sum_2d.html)
- [`import atcoder/extra/dp/edit_distance`](./extra/dp/edit_distance.html)
- [`import atcoder/extra/dp/largest_rectangle`](./extra/dp/largest_rectangle.html)
- [`import atcoder/extra/dp/dual_cumulative_sum`](./extra/dp/dual_cumulative_sum.html)
- [`import atcoder/extra/dp/longest_increasing_subsequence`](./extra/dp/longest_increasing_subsequence.html)
- [`import atcoder/extra/dp/slide_min`](./extra/dp/slide_min.html)

## extra/math

- [`import atcoder/extra/math/convert_base`](./extra/math/convert_base.html)
- [`import atcoder/extra/math/mod_sqrt`](./extra/math/mod_sqrt.html)
- [`import atcoder/extra/math/combination_table`](./extra/math/combination_table.html)
- [`import atcoder/extra/math/arbitrary_mod_combination`](./extra/math/arbitrary_mod_combination.html)
- [`import atcoder/extra/math/floor_sum_square`](./extra/math/floor_sum_square.html)
- [`import atcoder/extra/math/factorial`](./extra/math/factorial.html)

## extra/geometry

- [`import atcoder/extra/geometry/geometry_template`](./extra/geometry/geometry_template.html)
