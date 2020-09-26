import atcoder/segtree
import std/sugar, std/sequtils
import unittest

type segtree_naive[S] = object
  n:int
  op: (S,S)->S
  e: ()->S
  d:seq[string]# ??

proc initSegtreeNaive[S](n:int, op:(S,S)->S, e:()->S):segtree_naive[S] =
  segtree_naive[S](n:n, d:newSeqWith(n, e()), op:op, e:e)

proc set[ST:segtree_naive](self: var ST, p:int, x:ST.S) =
  self.d[p] = x
proc get[ST:segtree_naive](self: ST, p:int):ST.S = self.d[p]

proc prod[ST:segtree_naive](self: ST, p:Slice[int]):ST.S =
  var sum = self.e()
  for i in p:
    sum = self.op(sum, self.d[i])
  return sum

proc all_prod[ST:segtree_naive](self: ST):ST.S = return self.prod(0..<self.n)

proc max_right[ST:segtree_naive](self: ST, l:int, f:(ST.S)->bool):int =
  var sum = self.e()
  assert(f(sum))
  for i in l..<self.n:
    sum = self.op(sum, self.d[i])
    if not f(sum): return i
  return self.n

proc min_left[ST:segtree_naive](self: ST, r:int, f:(ST.S)->bool):int =
  var sum = self.e()
  assert(f(sum))
  for i in countdown(r - 1, 0):
    sum = self.op(self.d[i], sum)
    if not f(sum): return i + 1
  return 0

proc op(a, b:string):string =
  assert(a == "$" or b == "$" or a <= b)
  if a == "$": return b
  if b == "$": return a
  return a & b

proc e():string = return "$"

test "SegtreeTest, Zero":
  block:
    var s = initSegTree(0, op, e)
    check("$" == s.all_prod())
  #TODO
  # {
  #   seg s;
  #   ASSERT_EQ("$", s.all_prod());
  # }


test "SegtreeTest, Invalid":
  expect RangeError:
    var s = initSegTree(-1, op, e)

  var s = initSegTree(10, op, e)

  expect AssertionError: discard s.get(-1)
  expect AssertionError: discard s.get(10)
  
  expect AssertionError: discard s.prod(-1..< -1)
  expect AssertionError: discard s.prod(3..<2)
  expect AssertionError: discard s.prod(0..<11)
  expect AssertionError: discard s.prod(-1..<11)

  expect AssertionError:
#    discard s.max_right(11, proc(s:string):bool = true)
    proc f(s:string):bool = true
    discard s.max_right(11, f)
  expect AssertionError:
#    discard s.max_right(-1, proc(s:string):bool = true)
    proc f(s:string):bool = true
    discard s.max_right(-1, f)

#  expect AssertionError: discard s.max_right(0, proc(s:string):bool = false)
  proc f(s:string):bool = false
  expect AssertionError: 
#    proc f(s:string):bool = false
    discard s.max_right(0, f)

test "SegtreeTest, One":
  var s = initSegTree(1, op, e)
  check "$" == s.all_prod()
  check "$" == s.get(0)
  check "$" == s.prod(0..<1)
  s.set(0, "dummy")
  check "dummy" == s.get(0)
  check "$" == s.prod(0 ..< 0)
  check "dummy" == s.prod(0 ..< 1)
  check "$" == s.prod(1 ..< 1)

var y:string
proc leq_y(x:string):bool = return x.len <= y.len

test "SegtreeTest, CompareNaive":
  for n in 0..<30:
    var
      seg0 = initSegtreeNaive(n, op, e)
      seg1 = initSegTree(n, op, e)
    for i in 0..<n:
      var s = ""
      s &= chr('a'.int + i)
      seg0.set(i, s)
      seg1.set(i, s)

    for l in 0..n:
      for r in l..n:
        check seg0.prod(l ..< r) == seg1.prod(l .. <r)

    for l in 0..n:
      for r in l..n:
        y = seg1.prod(l ..< r)
        check seg0.max_right(l, leq_y) == seg1.max_right(l, leq_y)
        check seg0.max_right(l, leq_y) ==
          seg1.max_right(l, (x:string) => x.len <= y.len)

    for l in 0..n:
      for r in l..n:
        y = seg1.prod(l ..< r)
        check seg0.min_left(r, leq_y) == seg1.min_left(r, leq_y)
        check seg0.min_left(r, leq_y) ==
          seg1.min_left(r, (x:string) => x.len <= y.len)

test "SegtreeTest, Assign":
  var seg0:segtree[string, (op:op, e:e)]
  seg0.init(10)
