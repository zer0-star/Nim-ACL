import atcoder/convolution
import atcoder/modint
import std/unittest
import std/random
import std/sequtils
#include <random>
#include "../utils/random.hpp"

type ll = int

proc conv_ll_naive(a, b:seq[ll]):seq[ll] =
  let
    n = a.len
    m = b.len
  var c = newSeq[ll](n + m - 1)
  for i in 0..<n:
    for j in 0..<m:
      c[i + j] += a[i] * b[j]
  return c

proc conv_naive[mint:StaticModInt](a, b:seq[mint]):seq[mint] =
  let
    n = a.len
    m = b.len
  var c = newSeq[mint](n + m - 1)
  for i in 0..<n:
    for j in 0..<m:
      c[i + j] += a[i] * b[j]
  return c

proc conv_naive[T:SomeInteger](a, b:seq[T], MOD:static[int]):seq[T] =
  let
    n = a.len
    m = b.len
  var c = newSeq[T](n + m - 1)
  for i in 0..<n:
    for j in 0..<m:
      c[i + j] += (T)(a[i].int * b[j].int mod MOD)
      if c[i + j] >= MOD.T: c[i + j] -= MOD.T
  return c

test "ConvolutionTest, Empty":
  check newSeq[int32]() == convolution(newSeq[int32](), newSeq[int32]())
  check newSeq[int32]() == convolution(newSeq[int32](), @[1.int32, 2.int32])
  check newSeq[int32]() == convolution(@[1.int32, 2.int32], newSeq[int32]())
  check newSeq[int32]() == convolution(@[1.int32], newSeq[int32]())
  check newSeq[ll]() == convolution(newSeq[ll](), newSeq[ll]())
  check newSeq[ll]() == convolution(newSeq[ll](), @[1.ll, 2.ll])

  check newSeq[modint998244353]() == convolution(newSeq[modint998244353](), newSeq[modint998244353]())
  check newSeq[modint998244353]() == convolution(newSeq[modint998244353](), @[modint998244353.init(1), modint998244353.init(2)])

test "ConvolutionTest, Mid":
  var rnd = initRand(2020)
  let
    n = 1234
    m = 2345
  var a = newSeq[modint998244353](n)
  var b = newSeq[modint998244353](m)
  
  for i in 0..<n:
    a[i] = modint998244353.init(rnd.next())
  for i in 0..<m:
    b[i] = modint998244353.init(rnd.next())
  check conv_naive(a, b) == convolution(a, b)

test "ConvolutionTest, SimpleSMod":
  const MOD1 = 998244353
  const MOD2 = 924844033
  type s_mint1 = StaticModInt[MOD1]
  type s_mint2 = StaticModInt[MOD2]

  var rnd = initRand(2020)
  for n in 1..<20:
    for m in 1..<20:
      var a = newSeq[s_mint1](n)
      var b = newSeq[s_mint1](m)
      for i in 0..<n:
        a[i] = s_mint1.init(rnd.next())
      for i in 0..<m:
        b[i] = s_mint1.init(rnd.next())
      check conv_naive(a, b) == convolution(a, b)
  for n in 1..<20:
    for m in 1..<20:
      var a = newSeq[s_mint2](n)
      var b = newSeq[s_mint2](m)
      for i in 0..<n:
        a[i] = s_mint2.init(rnd.next())
      for i in 0..<m:
        b[i] = s_mint2.init(rnd.next())
      check conv_naive(a, b) == convolution(a, b)

test "ConvolutionTest, SimpleInt":
  const MOD1 = 998244353
  const MOD2 = 924844033

  var rnd = initRand(2020)
  for n in 1..<20:
    for m in 1..<20:
      var a = newSeq[int32](n)
      var b = newSeq[int32](m)
      for i in 0..<n:
        a[i] = int32(rnd.next() mod MOD1)
      for i in 0..<m:
        b[i] = int32(rnd.next() mod MOD1)
      check conv_naive(a, b, MOD1) == convolution(a, b)
      check conv_naive(a, b, MOD1) == convolution(a, b, MOD1)
  for n in 1..<20:
    for m in 1..<20:
      var a = newSeq[int32](n)
      var b = newSeq[int32](m)
      for i in 0..<n:
        a[i] = int32(rnd.next() mod MOD2)
      for i in 0..<m:
        b[i] = int32(rnd.next() mod MOD2)
      check conv_naive(a, b, MOD2) == convolution(a, b, MOD2)

test "ConvolutionTest, SimpleUint":
  const MOD1 = 998244353
  const MOD2 = 924844033

  var rnd = initRand(2020)
  for n in 1..<20:
    for m in 1..<20:
      var a = newSeq[uint32](n)
      var b = newSeq[uint32](m)
      for i in 0..<n:
        a[i] = uint32(rnd.next() mod MOD1)
      for i in 0..<m:
        b[i] = uint32(rnd.next() mod MOD1)
      check conv_naive(a, b, MOD1) == convolution(a, b)
      check conv_naive(a, b, MOD1) == convolution(a, b, MOD1)
  for n in 1..<20:
    for m in 1..<20:
      var a = newSeq[uint32](n)
      var b = newSeq[uint32](m)
      for i in 0..<n:
        a[i] = uint32(rnd.next() mod MOD2)
      for i in 0..<m:
        b[i] = uint32(rnd.next() mod MOD2)
      check conv_naive(a, b, MOD2) == convolution(a, b, MOD2)



test "ConvolutionTest, SimpleLL":
  const MOD1 = 998244353
  const MOD2 = 924844033

  var rnd = initRand(2020)
  for n in 1..<20:
    for m in 1..<20:
      var a = newSeq[int64](n)
      var b = newSeq[int64](m)
      for i in 0..<n:
        a[i] = int64(rnd.next() mod MOD1)
      for i in 0..<m:
        b[i] = int64(rnd.next() mod MOD1)
      check conv_naive(a, b, MOD1) == convolution(a, b)
      check conv_naive(a, b, MOD1) == convolution(a, b, MOD1)
  for n in 1..<20:
    for m in 1..<20:
      var a = newSeq[int64](n)
      var b = newSeq[int64](m)
      for i in 0..<n:
        a[i] = int64(rnd.next() mod MOD2)
      for i in 0..<m:
        b[i] = int64(rnd.next() mod MOD2)
      check conv_naive(a, b, MOD2) == convolution(a, b, MOD2)


test "ConvolutionTest, SimpleULL":
  const MOD1 = 998244353
  const MOD2 = 924844033

  var rnd = initRand(2020)
  for n in 1..<20:
    for m in 1..<20:
      var a = newSeq[uint64](n)
      var b = newSeq[uint64](m)
      for i in 0..<n:
        a[i] = uint64(rnd.next() mod MOD1)
      for i in 0..<m:
        b[i] = uint64(rnd.next() mod MOD1)
      check conv_naive(a, b, MOD1) == convolution(a, b)
      check conv_naive(a, b, MOD1) == convolution(a, b, MOD1)
  for n in 1..<20:
    for m in 1..<20:
      var a = newSeq[uint64](n)
      var b = newSeq[uint64](m)
      for i in 0..<n:
        a[i] = uint64(rnd.next() mod MOD2)
      for i in 0..<m:
        b[i] = uint64(rnd.next() mod MOD2)
      check conv_naive(a, b, MOD2) == convolution(a, b, MOD2)

##ifndef _MSC_VER
#TEST(ConvolutionTest, SimpleInt128) {
#  const int MOD1 = 998244353;
#  const int MOD2 = 924844033;
#
#  mt19937 mt;
#  for (int n = 1; n < 20; n++) {
#    for (int m = 1; m < 20; m++) {
#      seq[__int128> a(n), b(m);
#      for (int i = 0; i < n; i++) {
#        a[i] = mt() % MOD1;
#      }
#      for (int i = 0; i < m; i++) {
#        b[i] = mt() % MOD1;
#      }
#      check conv_naive<MOD1>(a, b), convolution(a, b));
#      check conv_naive<MOD1>(a, b), (convolution<MOD1>(a, b)));
#    }
#  }
#  for (int n = 1; n < 20; n++) {
#    for (int m = 1; m < 20; m++) {
#      seq[__int128> a(n), b(m);
#      for (int i = 0; i < n; i++) {
#        a[i] = mt() % MOD2;
#      }
#      for (int i = 0; i < m; i++) {
#        b[i] = mt() % MOD2;
#      }
#      check conv_naive<MOD2>(a, b), (convolution<MOD2>(a, b)));
#    }
#  }
#}
#
#TEST(ConvolutionTest, SimpleUInt128) {
#  const int MOD1 = 998244353;
#  const int MOD2 = 924844033;
#
#  mt19937 mt;
#  for (int n = 1; n < 20; n++) {
#    for (int m = 1; m < 20; m++) {
#      seq[unsigned __int128> a(n), b(m);
#      for (int i = 0; i < n; i++) {
#        a[i] = mt() % MOD1;
#      }
#      for (int i = 0; i < m; i++) {
#        b[i] = mt() % MOD1;
#      }
#      check conv_naive<MOD1>(a, b), convolution(a, b));
#      check conv_naive<MOD1>(a, b), (convolution<998244353>(a, b)));
#    }
#  }
#  for (int n = 1; n < 20; n++) {
#    for (int m = 1; m < 20; m++) {
#      seq[unsigned __int128> a(n), b(m);
#      for (int i = 0; i < n; i++) {
#        a[i] = mt() % MOD2;
#      }
#      for (int i = 0; i < m; i++) {
#        b[i] = mt() % MOD2;
#      }
#      check conv_naive<MOD2>(a, b), (convolution<MOD2>(a, b)));
#    }
#  }
#}
#
##endif

test "ConvolutionTest, ConvLL":
  var rnd = initRand(2020)
  for n in 1..<20:
    for m in 1..<20:
      var a = newSeq[ll](n)
      var b = newSeq[ll](m)
      for i in 0..<n:
        a[i] = ll(rnd.next() mod 1_000_000) - 500_000
      for i in 0..<m:
        b[i] = ll(rnd.next() mod 1_000_000) - 500_000
      check conv_ll_naive(a, b) == convolution_ll(a, b)

test "ConvolutionTest, ConvLLBound":
  const
    MOD1 = 469762049.uint  # 2^26
    MOD2 = 167772161.uint  # 2^25
    MOD3 = 754974721.uint  # 2^24
    M2M3 = MOD2 * MOD3
    M1M3 = MOD1 * MOD3
    M1M2 = MOD1 * MOD2
  for i in -1000..1000:
    let
      a = @[ll(0.uint - M1M2 - M1M3 - M2M3 + i.uint)]
      b = @[1]

    check a == convolution_ll(a, b)
  for i in 0..<1000:
    let
      a = @[ll.low + i]
      b = @[1]

    check a == convolution_ll(a, b)

  for i in 0..<1000:
    let
      a = @[ll.high - i]
      b = @[1]

    check a == convolution_ll(a, b)

# https://github.com/atcoder/ac-library/issues/30
test "ConvolutionTest, Conv641":
  # 641 = 128 * 5 + 1
  const MOD = 641
  var
    rnd = initRand(2020)
    a = newSeqWith(64, rnd.rand(MOD - 1).ll)
    b = newSeqWith(65, rnd.rand(MOD - 1).ll)

  check conv_naive(a, b, MOD) == convolution(a, b, MOD)

# https://github.com/atcoder/ac-library/issues/30
test "ConvolutionTest, Conv18433":
  # 18433 = 2048 * 9 + 1
  const MOD = 18433
  var
    rnd = initRand(2020)
    a = newSeqWith(1024, rnd.rand(MOD - 1).ll)
    b = newSeqWith(1025, rnd.rand(MOD - 1).ll)

  check conv_naive(a, b, MOD) == convolution(a, b, MOD)
