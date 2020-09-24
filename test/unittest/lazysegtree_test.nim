import std/unittest
import std/sugar
import std/sequtils
import atcoder/lazysegtree

#include <algorithm>
#include <atcoder/lazysegtree>
#include <string>
#include <vector>


proc op_ss(a, b:int):int = max(a, b)
proc op_ts(a, b:int):int = a + b
proc op_tt(a, b:int):int = a + b
proc e_s():int = -1_000_000_000
proc e_t():int = 0

#using starry_seg = lazy_segtree<int,
#                starry::op_ss,
#                starry::e_s,
#                int,
#                starry::op_ts,
#                starry::op_tt,
#                starry::e_t>;

test "LazySegtreeTest, Zero":
  block:
    var s = initLazySegTree(0, op_ss, e_s, op_ts, op_tt, e_t)
    check -1_000_000_000 == s.all_prod()
  block:
    var s = initLazySegTree(0, op_ss, e_s, op_ts, op_tt, e_t)
    check -1_000_000_000 == s.all_prod()
  block:
    var s = initLazySegTree(10, op_ss, e_s, op_ts, op_tt, e_t)
    check -1_000_000_000 == s.all_prod()

test "LazySegtreeTest, Assign":
  var seg0 = initLazySegTree(10, op_ss, e_s, op_ts, op_tt, e_t)

test "LazySegtreeTest, Invalid":
  expect RangeError:
    var s = initLazySegTree(-1, op_ss, e_s, op_ts, op_tt, e_t)
  var s = initLazySegTree(10, op_ss, e_s, op_ts, op_tt, e_t)

  expect AssertionError: discard s.get(-1)
  expect AssertionError: discard s.get(10)

  expect AssertionError: discard s.prod(-1 ..< -1)
  expect AssertionError: discard s.prod(3 ..< 2)
  expect AssertionError: discard s.prod(0 ..< 11)
  expect AssertionError: discard s.prod(-1 ..< 11)

test "LazySegtreeTest, NaiveProd":
  for n in 0..50:
    var seg = initLazySegTree(n, op_ss, e_s, op_ts, op_tt, e_t)
    var p = newSeq[int](n)
    for i in 0..<n:
      p[i] = (i * i + 100) mod 31
      seg.set(i, p[i])
    for l in 0..n:
      for r in l..n:
        var e = -1_000_000_000
        for i in l..<r:
          e = max(e, p[i])
        check e == seg.prod(l ..< r)

test "LazySegtreeTest, Usage":
  var seg = initLazySegTree(newSeqWith(10, 0), op_ss, e_s, op_ts, op_tt, e_t)
  check 0 == seg.all_prod()
  seg.apply(0 ..< 3, 5)
  check 5 == seg.all_prod()
  seg.apply(2, -10)
  check -5 == seg.prod(2 ..< 3)
  check 0 == seg.prod(2 ..< 4)
