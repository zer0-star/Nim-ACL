import atcoder/twosat
import std/unittest
import std/random
import std/sequtils

test "TwosatTest, Empty":
# TODO: NIMでemptyは無理？
#  two_sat ts0;
#  ASSERT_TRUE(ts0.satisfiable());
#  check std::vector<bool>({}), ts0.answer());
  var ts1 = initTwoSat(0)
  check ts1.satisfiable()
  check newSeq[bool]() == ts1.answer()

test "TwosatTest, One":
  block:
    var ts = initTwoSat(1)
    ts.add_clause(0, true, 0, true)
    ts.add_clause(0, false, 0, false)
    check: not ts.satisfiable()
  block:
    var ts = initTwoSat(1)
    ts.add_clause(0, true, 0, true)
    check ts.satisfiable()
    check @[true] == ts.answer()
  block:
    var ts = initTwoSat(1)
    ts.add_clause(0, false, 0, false)
    check ts.satisfiable()
    check @[false] == ts.answer()

test "TwosatTest, Assign":
  var ts = initTwoSat(10)

test "TwosatTest, StressOK":
  var rnd = initRand(2020)
  for phase in 0..<10000:
    let n = rnd.rand(1..20)
    let m = rnd.rand(1..100)
    var expect = newSeqWith(n, rnd.rand(2) == 1)

    var ts = initTwoSat(n)
    var
      xs = newSeq[int](m)
      ys = newSeq[int](m)
      types = newSeq[int](m)
    for i in 0..<m:
      let x = rnd.rand(n - 1)
      let y = rnd.rand(n - 1)
      let t = rnd.rand(2)
      xs[i] = x
      ys[i] = y
      types[i] = t
      if t == 0:
        ts.add_clause(x, expect[x], y, expect[y])
      elif t == 1:
        ts.add_clause(x, not expect[x], y, expect[y])
      else:
        ts.add_clause(x, expect[x], y, not expect[y])
    check ts.satisfiable()
    let actual = ts.answer()
    for i in 0..<m:
      let
        x = xs[i]
        y = ys[i]
        t = types[i]
      if t == 0:
        check actual[x] == expect[x] or actual[y] == expect[y]
      elif t == 1:
        check actual[x] != expect[x] or actual[y] == expect[y]
      else:
        check actual[x] == expect[x] or actual[y] != expect[y]
