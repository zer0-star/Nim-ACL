import std/unittest
import atcoder/mincostflow

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
  EdgeInfo[Cap, Cost](src:src, dst:dst, cap:cap, flow:flow, cost:cost)

test "MincostflowTest, Simple":
  var g = initMCFGraph[int,int](4)
  g.add_edge(0, 1, 1, 1)
  g.add_edge(0, 2, 1, 1)
  g.add_edge(1, 3, 1, 1)
  g.add_edge(2, 3, 1, 1)
  g.add_edge(1, 2, 1, 1)
  let expect = @[(0, 0), (2, 4)]
  check expect == g.slope(0, 3, 10)
  var e = EdgeInfo[int,int]()

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
