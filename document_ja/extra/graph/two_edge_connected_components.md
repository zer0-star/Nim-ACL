# Two-Edge-Connected Components

無向グラフから橋を除き、残った maximal connected components を求めます。

component を縮約すると bridge forest が得られます。

詳細は [Undirected Graph Decomposition](./undirected_decomposition.html) を参照してください。

## import

~~~nim
import atcoder/extra/graph/two_edge_connected_components
~~~

## API

~~~nim
proc twoEdgeConnectedComponents(
  g: UndirectedGraph
): TwoEdgeConnectedComponentsResult
~~~
