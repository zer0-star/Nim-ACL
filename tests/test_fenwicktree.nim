import std/unittest
import atcoder/fenwicktree
import atcoder/modint as modint_lib

type ll = int
type ull = uint

test "FenwickTreeTest, Empty":
  var fw_ll:FenwickTree.getType(ll)
  check 0 == fw_ll.sum(0 ..< 0)

  var fw_modint:FenwickTree.getType(modint)
  check 0 == fw_modint.sum(0 ..< 0).val()

test "FenwickTreeTest, Assign":
  var fw = init_fenwick_tree[ll](10)

test "FenwickTreeTest, Zero":
  var fw_ll = init_fenwick_tree[ll](0)
  check 0 == fw_ll.sum(0 ..< 0)

  var fw_modint = init_fenwick_tree[modint](0)
  check 0 == fw_modint.sum(0 ..< 0).val()

test "FenwickTreeTest, OverFlowULL":
  var fw = init_fenwick_tree[ull](10)
  for i in 0..<10:
    fw.add(i, (1'u shl 63) + i.uint)
  for i in 0..10:
    for j in i..10:
      var sum = 0'u
      for k in i ..< j:
        sum += k.uint
      check (if (j - i) mod 2 == 1: (1'u shl 63) + sum else: sum) == fw.sum(i ..< j)

test "FenwickTreeTest, NaiveTest":
  for n in 0..50:
    var fw = init_fenwick_tree[ll](n)
    for i in 0..<n:
      fw.add(i, i * i)
    for l in 0..n:
      for r in l..n:
        var sum = 0
        for i in l..<r:
          sum += i * i
        check sum == fw.sum(l..<r)
        check sum == fw[l..<r]

useStaticModInt(mint, 11)

test "FenwickTreeTest, SMintTest":
  for n in 0..50:
    var fw = init_fenwick_tree[mint](n)
    for i in 0..<n:
      fw.add(i, mint(i) * i)
    for l in 0..n:
      for r in l..n:
        var sum = mint(0)
        for i in l ..< r:
          sum += mint(i) * i;
        check sum == fw.sum(l ..< r)

test "FenwickTreeTest, MintTest":
  type mint = modint
  mint.set_mod(11)
  for n in 0..50:
    var fw = init_fenwick_tree[mint](n)
    for i in 0..<n:
      fw.add(i, mint(i) * i)
    for l in 0..n:
      for r in l..n:
        var sum = mint(0)
        for i in l..<r:
          sum += mint(i) * i
        check sum == fw.sum(l ..< r)

test "FenwickTreeTest, Invalid":
  expect RangeError:
    var s = init_fenwick_tree[int](-1)

  var s = init_fenwick_tree[int](10)

  expect AssertionError: s.add(-1, 0)
  expect AssertionError: s.add(10, 0)

  expect AssertionError: discard s.sum(-1 ..< 3)
  expect AssertionError: discard s.sum(3 ..< 11)
  expect AssertionError: discard s.sum(5 ..< 3)


test "FenwickTreeTest, Bound":
  var fw = init_fenwick_tree[int32](10)
  fw.add(3, int32.high)
  fw.add(5, int32.low)
  check -1 == fw.sum(0 ..< 10)
  check -1 == fw.sum(3 ..< 6)
  check int32.high == fw.sum(3 ..< 4)
  check int32.low == fw.sum(4 ..< 10)

test "FenwickTreeTest, Boundll":
  var fw = init_fenwick_tree[ll](10)
  fw.add(3, ll.high)
  fw.add(5, ll.low)
  check -1 == fw.sum(0 ..< 10)
  check -1 == fw.sum(3 ..< 6)
  check ll.high == fw.sum(3 ..< 4)
  check ll.low == fw.sum(4 ..< 10)

test "FenwickTreeTest, OverFlow":
  var 
    fw = init_fenwick_tree[int32](20)
    a = newSeq[ll](20)
  for i in 0 ..< 10:
    let x = int32.high
    a[i] += x
    fw.add(i, x)
  for i in 10 ..< 20:
    let x = int32.low
    a[i] += x
    fw.add(i, x)
  a[5] += 11111
  fw.add(5, 11111)

  for l in 0..20:
    for r in l..20:
      var sum = 0.ll
      for i in l ..< r:
        sum += a[i]
      var dif = sum - fw.sum(l ..< r)
      check 0 == dif mod (1.ll shl 32)

##ifndef _MSC_VER
#
#TEST(FenwickTreeTest, Int128) {
#  fenwick_tree<__int128> fw(20);
#  for (int i = 0; i < 20; i++) {
#    fw.add(i, i);
#  }
#
#  for (int l = 0; l <= 20; l++) {
#    for (int r = l; r <= 20; r++) {
#      ll sum = 0;
#      for (int i = l; i < r; i++) {
#        sum += i;
#      }
#      check sum, fw.sum(l, r));
#    }
#  }
#}
#
##endif
