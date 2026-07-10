when not declared ATCODER_EXTRA_JA_GRAPH_MINIMUM_SPANNING_TREE_HPP:
  const ATCODER_EXTRA_JA_GRAPH_MINIMUM_SPANNING_TREE_HPP* = 1

  import atcoder/extra/graph/graph_template
  import atcoder/extra/graph/kruskal

  export graph_template
  export kruskal

  proc 最小全域木*[G: Graph](
      g: G,
  ): (G.T, seq[Edge[G.T, G.U]]) {.inline.} =
    ## `kruskal(g)` の日本語別名です。
    ##
    ## 最小全域木の重み合計と、選ばれた辺の列を返します。

    kruskal(g)
