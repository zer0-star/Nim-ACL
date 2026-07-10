discard """
  cmd: "nim cpp -r $file"
"""

import std/unittest
import atcoder/extra/math/xor_basis

test "XorBasis basic independence and representation":
  var xb = initXorBasis[int](maxLog = 4)

  check xb.empty()
  check xb.rank == 0
  check xb.len == 0

  check xb.add(3) == true
  check xb.add(5) == true
  check xb.add(6) == false

  check not xb.empty()
  check xb.rank == 2
  check xb.len == 2

  check 0 in xb
  check 3 in xb
  check 5 in xb
  check 6 in xb
  check 1 notin xb

  check xb.reduce(6) == 0
  check xb.reduce(7) == 1

  check xb.maxXor() == 6
  check xb.maxXor(1) == 7
  check xb.minXor(7) == 1

test "XorBasis agrees with small closure":
  let xs = @[1, 2, 4, 7]
  var xb = initXorBasis[int](maxLog = 4)
  xb.addAll(xs)

  var representable = newSeq[bool](16)

  for mask in 0 ..< (1 shl xs.len):
    var v = 0
    for i in 0 ..< xs.len:
      if ((mask shr i) and 1) != 0:
        v = v xor xs[i]
    representable[v] = true

  for v in 0 ..< 16:
    check (v in xb) == representable[v]

  for q in 0 ..< 16:
    var expectedMax = 0
    var expectedMin = int.high

    for v in 0 ..< 16:
      if representable[v]:
        expectedMax = max(expectedMax, q xor v)
        expectedMin = min(expectedMin, q xor v)

    check xb.maxXor(q) == expectedMax
    check xb.minXor(q) == expectedMin

test "XorBasis merge":
  var a = initXorBasis[int](maxLog = 3)
  var b = initXorBasis[int](maxLog = 3)

  discard a.add(1)
  discard a.add(2)

  discard b.add(4)
  discard b.add(6)

  let c = merge(a, b)

  check c.rank == 3
  check c.maxXor() == 7
  check 7 in c
  check 3 in c
  check 5 in c

test "XorBasis uint64 high bit":
  var xb = initXorBasis[uint64](maxLog = 63)

  let hi = 1'u64 shl 63

  check xb.add(hi) == true
  check xb.add(hi) == false

  check xb.rank == 1
  check xb.maxXor() == hi
  check hi in xb
  check 1'u64 notin xb
