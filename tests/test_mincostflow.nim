import std/unittest
import atcoder/mincostflow, atcoder/maxflow
import "../test/utils/random.nim"

type ll = int
type ull = uint

test "MincostflowTest, Zero":
  var g1:MCFGraph[int,int]
  var g2 = initMCFGraph[int,int](0)

template edge_eq[edge](expect, actual:edge) =
  check expect.src == actual.src
  check expect.dst == actual.dst
  check expect.cap == actual.cap
  check expect.flow == actual.flow
  check expect.cost == actual.cost

proc make_edge_info[Cap, Cost](src, dst:int, cap, flow:Cap, cost:Cost):auto =
  MCFEdge[Cap, Cost](src:src, dst:dst, cap:cap, flow:flow, cost:cost)

test "MincostflowTest, Simple":
  var g = initMCFGraph[int,int](4)
  g.add_edge(0, 1, 1, 1)
  g.add_edge(0, 2, 1, 1)
  g.add_edge(1, 3, 1, 1)
  g.add_edge(2, 3, 1, 1)
  g.add_edge(1, 2, 1, 1)
  let expect = @[(0, 0), (2, 4)]
  check expect == g.slope(0, 3, 10)
  var e = MCFEdge[int,int]()

  e = make_edge_info(0, 1, 1, 1, 1)
  edge_eq(e, g.get_edge(0))
  e = make_edge_info(0, 2, 1, 1, 1)
  edge_eq(e, g.get_edge(1))
  e = make_edge_info(1, 3, 1, 1, 1)
  edge_eq(e, g.get_edge(2))
  e = make_edge_info(2, 3, 1, 1, 1)
  edge_eq(e, g.get_edge(3))
  e = make_edge_info(1, 2, 1, 0, 1)
  edge_eq(e, g.get_edge(4))

test "MincostflowTest, Usage":
  block:
    var g = initMCFGraph[int,int](2)
    g.add_edge(0, 1, 1, 2)
    check (1, 2) == g.flow(0, 1)
  block:
    var g = initMCFGraph[int,int](2)
    g.add_edge(0, 1, 1, 2);
    let expect = @[(0, 0), (1, 2)]
    check expect == g.slope(0, 1)

test "MincostflowTest, Assign":
  var g:MCFGraph[int,int]
  g = initMCFGraph[int,int](10)

test "MincostflowTest, OutOfRange":
  var g = initMCFGraph[int,int](10)
  
  expect AssertionError: discard g.slope(-1, 3)
  expect AssertionError: discard g.slope(3, 3)

# https://github.com/atcoder/ac-library/issues/1
test "MincostflowTest, SelfLoop":
  var g = initMCFGraph[int,int](3)
  check 0 == g.add_edge(0, 0, 100, 123)
  
  var e = make_edge_info(0, 0, 100, 0, 123)
  edge_eq(e, g.get_edge(0))

test "MincostflowTest, SameCostPaths":
  var g = initMCFGraph[int,int](3)
  check 0 == g.add_edge(0, 1, 1, 1)
  check 1 == g.add_edge(1, 2, 1, 0)
  check 2 == g.add_edge(0, 2, 2, 1)
  let expected = @[(0, 0), (3, 3)]
  check expected == g.slope(0, 2)

test "MincostflowTest, Invalid":
  var g = initMCFGraph[int,int](2)
  # https://github.com/atcoder/ac-library/issues/51
  expect AssertionError: discard g.add_edge(0, 0, -1, 0)
  expect AssertionError: discard g.add_edge(0, 0, 0, -1)



test "MincostflowTest, Stress":
  for phase in 0..<1000:
    let n = randint(2, 20)
    let m = randint(1, 100)
    var (s, t) = randpair(0, n - 1)
    if randbool(): swap(s, t)

    var g_mf = initMFGraph[int](n)
    var g = initMCFGraph[int, int](n)
    for i in 0..<m:
      let u = randint(0, n - 1)
      let v = randint(0, n - 1)
      let cap = randint(0, 10)
      let cost = randint(0, 10000)
      g.add_edge(u, v, cap, cost)
      g_mf.add_edge(u, v, cap)
    var (flow, cost) = g.flow(s, t)
    check g_mf.flow(s, t) == flow

    var cost2 = 0
    var v_cap = newSeq[int](n)
    for e in g.edges():
      v_cap[e.src] -= e.flow
      v_cap[e.dst] += e.flow
      cost2 += e.flow * e.cost
    check cost == cost2

    for i in 0..<n:
      if i == s:
        check -flow == v_cap[i]
      elif i == t:
        check flow == v_cap[i]
      else:
        check 0 == v_cap[i]

    # check: there is no negative-cycle
    var dist = newSeq[int](n)
    while true:
      var update = false
      for e in g.edges():
        if e.flow < e.cap:
          let ndist = dist[e.src] + e.cost
          if ndist < dist[e.dst]:
            update = true
            dist[e.dst] = ndist
        if e.flow != 0:
          let ndist = dist[e.dst] - e.cost
          if ndist < dist[e.src]:
            update = true
            dist[e.src] = ndist
      if not update: break

