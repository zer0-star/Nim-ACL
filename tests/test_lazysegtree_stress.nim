import atcoder/lazysegtree
import std/unittest
import std/sequtils
import std/random as random_lib

import "../test/utils/random.nim"
#include "../utils/random.hpp"
#include <string>
#include <vector>

# time manager
type TimeManager = object
  v:seq[int]

proc initTimeManager(n:int):TimeManager =
  TimeManager(v:newSeqWith(n, -1))

proc action(self: var TimeManager, p:Slice[int] , time:int) =
  for i in p:
    self.v[i] = time

proc prod(self: TimeManager, p:Slice[int]):int =
  var res = -1
  for i in p:
    res = max(res, self.v[i])
  return res

type S = tuple[l, r, time:int]

type T = tuple[new_time:int]

proc op_ss(l, r:S):S =
  if l.l == -1: return r
  if r.l == -1: return l
  assert l.r == r.l
  return (l.l, r.r, max(l.time, r.time))

proc op_ts(l:T, r:S):S =
  if l.new_time == -1: return r
  assert r.time < l.new_time
  return (r.l, r.r, l.new_time)

proc op_tt(l, r:T):T =
  if l.new_time == -1: return r
  if r.new_time == -1: return l
  assert l.new_time > r.new_time
  return l

proc e_s():S = (-1, -1, -1)
proc e_t():T = (-1,)

#using seg = lazy_segtree<S, op_ss, e_s, T, op_ts, op_tt, e_t>;

test "LazySegtreeStressTest, NaiveTest":
  var rnd = initRand(2020)
  for n in 1..30:
    for ph in 0..<10:
      var seg0 = initLazySegTree(n, op_ss, e_s, op_ts, op_tt, e_t)
      var tm = initTimeManager(n)
      for i in 0..<n:
        seg0.set(i, (i, i + 1, -1))
      var now = 0
      for q in 0..<3000:
        let ty = rnd.rand(3)
        let (l, r) = randpair(0, n)
        if ty == 0:
          let res = seg0.prod(l ..< r)
          check l == res.l
          check r == res.r
          check tm.prod(l ..< r) == res.time
        elif ty == 1:
          let res = seg0.get(l) # TODO: DOWN when l = n
          check l == res.l
          check l + 1 == res.r
          check tm.prod(l ..< l + 1) == res.time
        elif ty == 2:
          now.inc
          seg0.apply(l ..< r, (now,))
          tm.action(l ..< r, now)
        elif ty == 3:
          now.inc
          seg0.apply(l, (now,))
          tm.action(l ..< l + 1, now)
        else:
          assert(false)

test "LazySegtreeStressTest, MaxRightTest":
  var rnd = initRand(2020)
  for n in 1..30:
    for ph in 0..<10:
      var seg0 = initLazySegTree(n, op_ss, e_s, op_ts, op_tt, e_t)
      var tm = initTimeManager(n)
      for i in 0..<n:
        seg0.set(i, (i, i + 1, -1))
      var now = 0
      for q in 0..<1000:
        let ty = rnd.rand(2)
        let (l, r) = randpair(0, n)
        if ty == 0:
          check r == seg0.max_right(l, proc(s:S):bool =
            if s.l == -1: return true
            assert s.l == l
            assert s.time == tm.prod(l ..< s.r)
            return s.r <= r
          )
        else:
          now.inc
          seg0.apply(l ..< r, (now,))
          tm.action(l ..< r, now)

test "LazySegtreeStressTest, MinLeftTest":
  var rnd = initRand(2020)
  for n in 1..30:
    for ph in 0..<10:
      var seg0 = initLazySegTree(n, op_ss, e_s, op_ts, op_tt, e_t)
      var tm = initTimeManager(n)
      for i in 0..<n:
        seg0.set(i, (i, i + 1, -1))
      var now = 0
      for q in 0..<1000:
        let ty = rnd.rand(2)
        let (l, r) = randpair(0, n)
        if ty == 0:
          check l == seg0.min_left(r, proc(s:S):bool =
            if s.l == -1: return true
            assert s.r == r
            assert s.time == tm.prod(s.l ..< r)
            return l <= s.l
          )
        else:
          now.inc
          seg0.apply(l ..< r, (now,))
          tm.action(l ..< r, now)
