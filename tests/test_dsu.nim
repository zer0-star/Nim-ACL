import std/unittest
import atcoder/dsu

test "DSUTest, Zero":
  var uf = initDSU(0)
  check newSeq[seq[int]]() == uf.groups()

# TODO: Nimでemptyはできなそう
#test "DSUTest, Empty":
#  var uf:DSU
#  check newSeq[seq[int]]() == uf.groups()

test "DSUTest, Assign":
  var uf = initDSU(10)

test "DSUTest, Simple":
  var uf = initDSU(2)
  check not uf.same(0, 1)
  let x = uf.merge(0, 1)
  check x == uf.leader(0)
  check x == uf.leader(1)
  check uf.same(0, 1)
  check 2 == uf.size(0)

test "DSUTest, Line":
  let n = 500000
  var uf = initDSU(n)
  for i in 0 ..< n - 1:
    uf.merge(i, i + 1)
  check n == uf.size(0)
  check 1 == uf.groups().len

test "DSUTest, LineReverse":
  let n = 500000
  var uf = initDSU(n)
  for i in countdown(n - 2, 0):
    uf.merge(i, i + 1)
  check n == uf.size(0)
  check 1 == uf.groups().len
