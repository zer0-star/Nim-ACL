# Block-Cut Tree

Biconnected component と articulation vertex の関係を二部 forest として表します。

指定頂点集合に対する graph DP や、関節点をまたぐ経路の処理に利用できます。

詳細は [Undirected Graph Decomposition](./undirected_decomposition.html) を参照してください。

## import

~~~nim
import atcoder/extra/graph/block_cut_tree
~~~

## API

~~~nim
proc blockCutTree(
  g: UndirectedGraph
): BlockCutTreeResult
~~~
