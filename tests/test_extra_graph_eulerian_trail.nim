import std/[
  algorithm,
  unittest,
]

import atcoder/extra/graph/eulerian_trail


proc sortedEdgeIds(
    trails: seq[seq[int]],
): seq[int] =
  for trail in trails:
    result.add(trail)

  result.sort()


proc followsDirectedEdges(
    graph: var auto,
    trail: seq[int],
): bool =
  if trail.len == 0:
    return true

  for index in 0 ..< trail.len - 1:
    let
      current =
        graph.get_edge(
          trail[index]
        )

      next =
        graph.get_edge(
          trail[index + 1]
        )

    if current[1] != next[0]:
      return false

  true


proc followsUndirectedEdges(
    graph: var auto,
    trail: seq[int],
): bool =
  if trail.len <= 1:
    return true

  let first =
    graph.get_edge(
      trail[0]
    )

  for initialDirection in 0 .. 1:
    var currentVertex =
      if initialDirection == 0:
        first[1]
      else:
        first[0]

    var valid =
      true

    for index in 1 ..< trail.len:
      let edge =
        graph.get_edge(
          trail[index]
        )

      if edge[0] == currentVertex:
        currentVertex =
          edge[1]

      elif edge[1] == currentVertex:
        currentVertex =
          edge[0]

      else:
        valid =
          false

        break

    if valid:
      return true

  false


suite "Eulerian Trail isolated contract":
  test "undirected Eulerian circuit":
    var graph =
      initEulerianTrail(
        3,
        false,
      )

    graph.add_edge(0, 1)
    graph.add_edge(1, 2)
    graph.add_edge(2, 0)

    let trails =
      graph.enumerate_eulerian_trail()

    check trails.len == 1

    check sortedEdgeIds(
      trails
    ) == @[0, 1, 2]

    check followsUndirectedEdges(
      graph,
      trails[0],
    )

    echo "EULERIAN_UNDIRECTED_CIRCUIT=PASS"
    echo "EULERIAN_EDGE_RECOVERY=PASS"

  test "directed Eulerian circuit":
    var graph =
      initEulerianTrail(
        3,
        true,
      )

    graph.add_edge(0, 1)
    graph.add_edge(1, 2)
    graph.add_edge(2, 0)

    let trails =
      graph.enumerate_eulerian_trail()

    check trails.len == 1

    check sortedEdgeIds(
      trails
    ) == @[0, 1, 2]

    check followsDirectedEdges(
      graph,
      trails[0],
    )

    echo "EULERIAN_DIRECTED_CIRCUIT=PASS"

  test "directed semi-Eulerian trail":
    var graph =
      initEulerianTrail(
        3,
        true,
      )

    graph.add_edge(0, 1)
    graph.add_edge(1, 2)

    let trails =
      graph.enumerate_semi_eulerian_trail()

    check trails.len == 1

    check sortedEdgeIds(
      trails
    ) == @[0, 1]

    check followsDirectedEdges(
      graph,
      trails[0],
    )

    echo "EULERIAN_DIRECTED_SEMI_TRAIL=PASS"
