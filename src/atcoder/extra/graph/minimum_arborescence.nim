when not declared ATCODER_EXTRA_GRAPH_MINIMUM_ARBORESCENCE_HPP:
  const ATCODER_EXTRA_GRAPH_MINIMUM_ARBORESCENCE_HPP* = 1

  import std/options

  import atcoder/extra/graph/graph_template
  import atcoder/extra/graph/chu_liu_edmonds

  export graph_template
  export chu_liu_edmonds

  proc minimumArborescence*[T](
      es: Edges[T, int],
      vertexCount: int,
      root: int,
  ): Option[(T, seq[int])] {.inline.} =
    ## Functional-name alias of
    ## `minimumSpanningTreeArborescence`.
    ##
    ## Returns the minimum-cost arborescence rooted at
    ## `root`, or `none` when some vertex is unreachable.

    minimumSpanningTreeArborescence(
      es,
      vertexCount,
      root,
    )
