# Biconnected Components

無向グラフを vertex-biconnected components に分解し、articulation point と bridge も求めます。

アルゴリズムの概要・API・使用例は [Undirected Graph Decomposition](./undirected_decomposition.html) を参照してください。

## import

~~~nim
import atcoder/extra/graph/biconnected_components
~~~

## API

~~~nim
proc initUndirectedGraph(n: int): UndirectedGraph
proc addEdge(g: var UndirectedGraph, u, v: int): int

proc biconnectedComponents(
  g: UndirectedGraph
): BiconnectedComponentsResult
~~~
