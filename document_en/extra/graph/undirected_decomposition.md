# Undirected Graph Decomposition

This module provides:

- articulation points and bridges
- vertex-biconnected components
- two-edge-connected components
- block-cut trees

All operations are based on DFS low-link values.

## Import

~~~nim
import atcoder/extra/graph/undirected_decomposition
~~~

Task-specific facades are also available:

~~~nim
import atcoder/extra/graph/biconnected_components
import atcoder/extra/graph/two_edge_connected_components
import atcoder/extra/graph/block_cut_tree
~~~

## Graph construction

~~~nim
proc initUndirectedGraph(n: int): UndirectedGraph
proc addEdge(g: var UndirectedGraph, u, v: int): int
~~~

Parallel edges are supported. Self-loops are rejected.

## Operations

~~~nim
proc biconnectedComponents(
  g: UndirectedGraph
): BiconnectedComponentsResult

proc twoEdgeConnectedComponents(
  g: UndirectedGraph
): TwoEdgeConnectedComponentsResult

proc blockCutTree(
  g: UndirectedGraph
): BlockCutTreeResult
~~~

## Complexity

Every decomposition runs in `O(n + m)` time and uses `O(n + m)` memory.

## Notes

Disconnected graphs are supported and produce forests. The DFS implementation is recursive.
