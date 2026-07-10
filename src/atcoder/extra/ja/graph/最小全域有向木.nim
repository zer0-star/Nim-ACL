when not declared ATCODER_EXTRA_JA_GRAPH_MINIMUM_ARBORESCENCE_HPP:
  const ATCODER_EXTRA_JA_GRAPH_MINIMUM_ARBORESCENCE_HPP* = 1

  import std/options

  import atcoder/extra/graph/graph_template
  import atcoder/extra/graph/minimum_arborescence

  export graph_template
  export minimum_arborescence

  proc 最小全域有向木*[T](
      es: Edges[T, int],
      vertexCount: int,
      root: int,
  ): Option[(T, seq[int])] {.inline.} =
    ## `minimumArborescence` の日本語別名です。
    ##
    ## `root` を根とする最小全域有向木を返します。
    ## 存在しない場合は `none` を返します。

    minimumArborescence(
      es,
      vertexCount,
      root,
    )
