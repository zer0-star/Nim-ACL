import std/unittest

import atcoder/maxflow

import "../test/utils/random.nim"

type ll = int
type ull = uint

test "MaxflowTest, Zero":
  var g1: MFGraph[int]
  var g2 = init_mf_graph[int](0)

test "MaxflowTest, Assign":
  var g: MFGraph[int]
  g = init_mf_graph[int](10)

template edge_eq[edge](expect, actual: edge) =
  check expect.src == actual.src
  check expect.dst == actual.dst
  check expect.cap == actual.cap
  check expect.flow == actual.flow

test "MaxflowTest, Simple":
  var g = init_mf_graph[int](4)
  check 0 == g.add_edge(0, 1, 1)
  check 1 == g.add_edge(0, 2, 1)
  check 2 == g.add_edge(1, 3, 1)
  check 3 == g.add_edge(2, 3, 1)
  check 4 == g.add_edge(1, 2, 1)
  check 2 == g.flow(0, 3)

  var e:EdgeInfo[int]
  e = EdgeInfo[int](src:0, dst:1, cap:1, flow:1)
  edge_eq(e, g.get_edge(0))
  e = EdgeInfo[int](src:0, dst:2, cap:1, flow:1)
  edge_eq(e, g.get_edge(1))
  e = EdgeInfo[int](src:1, dst:3, cap:1, flow:1)
  edge_eq(e, g.get_edge(2))
  e = EdgeInfo[int](src:2, dst:3, cap:1, flow:1)
  edge_eq(e, g.get_edge(3))
  e = EdgeInfo[int](src:1, dst:2, cap:1, flow:0)
  edge_eq(e, g.get_edge(4))

  check @[true, false, false, false] == g.min_cut(0)

test "MaxflowTest, NotSimple":
  var g = init_mf_graph[int](2)
  check 0 == g.add_edge(0, 1, 1)
  check 1 == g.add_edge(0, 1, 2)
  check 2 == g.add_edge(0, 1, 3)
  check 3 == g.add_edge(0, 1, 4)
  check 4 == g.add_edge(0, 1, 5)
  check 5 == g.add_edge(0, 0, 6)
  check 6 == g.add_edge(1, 1, 7)
  check 15 == g.flow(0, 1)

  var e: EdgeInfo[int]
  e = EdgeInfo[int](src:0, dst:1, cap:1, flow:1)
  edge_eq(e, g.get_edge(0))
  e = EdgeInfo[int](src:0, dst:1, cap:2, flow:2)
  edge_eq(e, g.get_edge(1))
  e = EdgeInfo[int](src:0, dst:1, cap:3, flow:3)
  edge_eq(e, g.get_edge(2))
  e = EdgeInfo[int](src:0, dst:1, cap:4, flow:4)
  edge_eq(e, g.get_edge(3))
  e = EdgeInfo[int](src:0, dst:1, cap:5, flow:5)
  edge_eq(e, g.get_edge(4))

  check @[true, false] == g.min_cut(0)

test "MaxflowTest, Cut":
  var g = init_mf_graph[int](3)
  check 0 == g.add_edge(0, 1, 2)
  check 1 == g.add_edge(1, 2, 1)
  check 1 == g.flow(0, 2)

  var e:EdgeInfo[int]
  e = EdgeInfo[int](src:0, dst:1, cap:2, flow:1)
  edge_eq(e, g.get_edge(0))
  e = EdgeInfo[int](src:1, dst:2, cap:1, flow:1)
  edge_eq(e, g.get_edge(1))

  check @[true, true, false] == g.min_cut(0)

test "MaxflowTest, Twice":
  var e:EdgeInfo[int]
  
  var g = init_mf_graph[int](3)
  check 0 == g.add_edge(0, 1, 1)
  check 1 == g.add_edge(0, 2, 1)
  check 2 == g.add_edge(1, 2, 1)
  
  check 2 == g.flow(0, 2)

  e = EdgeInfo[int](src:0, dst:1, cap:1, flow:1)
  edge_eq(e, g.get_edge(0))
  e = EdgeInfo[int](src:0, dst:2, cap:1, flow:1)
  edge_eq(e, g.get_edge(1))
  e = EdgeInfo[int](src:1, dst:2, cap:1, flow:1)
  edge_eq(e, g.get_edge(2))

  g.change_edge(0, 100, 10)
  e = EdgeInfo[int](src:0, dst:1, cap:100, flow:10)
  edge_eq(e, g.get_edge(0))

  check 0 == g.flow(0, 2)
  check 90 == g.flow(0, 1)

  e = EdgeInfo[int](src:0, dst:1, cap:100, flow:100)
  edge_eq(e, g.get_edge(0))
  e = EdgeInfo[int](src:0, dst:2, cap:1, flow:1)
  edge_eq(e, g.get_edge(1))
  e = EdgeInfo[int](src:1, dst:2, cap:1, flow:1)
  edge_eq(e, g.get_edge(2))

  check 2 == g.flow(2, 0)

  e = EdgeInfo[int](src:0, dst:1, cap:100, flow:99)
  edge_eq(e, g.get_edge(0))
  e = EdgeInfo[int](src:0, dst:2, cap:1, flow:0)
  edge_eq(e, g.get_edge(1))
  e = EdgeInfo[int](src:1, dst:2, cap:1, flow:0)
  edge_eq(e, g.get_edge(2))

test "MaxflowTest, Bound":
  var e:EdgeInfo[int32]

  const INF = int32.high
  var g = init_mf_graph[int32](3)
  check 0 == g.add_edge(0, 1, INF)
  check 1 == g.add_edge(1, 0, INF)
  check 2 == g.add_edge(0, 2, INF)

  check INF == g.flow(0, 2)

  e = EdgeInfo[int32](src:0, dst:1, cap:INF, flow:0.int32)
  edge_eq(e, g.get_edge(0))
  e = EdgeInfo[int32](src:1, dst:0, cap:INF, flow:0.int32)
  edge_eq(e, g.get_edge(1))
  e = EdgeInfo[int32](src:0, dst:2, cap:INF, flow:INF)
  edge_eq(e, g.get_edge(2))

test "MaxflowTest, BoundUint":
  var e:EdgeInfo[uint32]

  const INF = uint32.high
  var g = init_mf_graph[uint32](3)
  check 0 == g.add_edge(0, 1, INF)
  check 1 == g.add_edge(1, 0, INF)
  check 2 == g.add_edge(0, 2, INF)

  check INF == g.flow(0, 2)

  e = EdgeInfo[uint32](src:0, dst:1, cap:INF, flow:0.uint32)
  edge_eq(e, g.get_edge(0))
  e = EdgeInfo[uint32](src:1, dst:0, cap:INF, flow:0.uint32)
  edge_eq(e, g.get_edge(1))
  e = EdgeInfo[uint32](src:0, dst:2, cap:INF, flow:INF)
  edge_eq(e, g.get_edge(2))

# https://github.com/atcoder/ac-library/issues/1
test "MaxflowTest, SelfLoop":
  var g = init_mf_graph[int](3)
  check 0 == g.add_edge(0, 0, 100)

  let e = EdgeInfo[int](src:0, dst:0, cap:100, flow:0)
  edge_eq(e, g.get_edge(0))

test "MaxflowTest, Invalid":
  var g = init_mf_graph[int](2)
  # https://github.com/atcoder/ac-library/issues/5
  expect AssertionError:
    discard g.flow(0, 0)
    discard g.flow(0, 0, 0)

test "MaxflowTest, Stress":
  for phase in 0..<10000:
    let n = randint(2, 20);
    let m = randint(1, 100);

    var (s, t) = randpair(0, n - 1)
    if randbool(): swap(s, t)

    var g = init_mf_graph[int](n)
    for i in 0..<m:
      let
        u = randint(0, n - 1)
        v = randint(0, n - 1)
        c = randint(0, 10000)
      g.add_edge(u, v, c)
    let flow = g.flow(s, t)
    var dual = 0
    let cut = g.min_cut(s)
    var v_flow = newSeq[int](n)
    for e in g.edges:
      v_flow[e.src] -= e.flow
      v_flow[e.dst] += e.flow
      if cut[e.src] and not cut[e.dst]: dual += e.cap
    check flow == dual
    check -flow == v_flow[s]
    check flow == v_flow[t]
    for i in 0..<n:
      if i == s or i == t: continue
      check 0 == v_flow[i]
