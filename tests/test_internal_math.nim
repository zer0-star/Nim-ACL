#include <gtest/gtest.h>

#include <atcoder/internal_math>
#include <numeric>
#include "../utils/math.hpp"

import std/unittest
import atcoder/internal_math
import atcoder/math
import std/math as math_lib
import ../test/utils/math as math_util_lib
#using namespace atcoder;
#using uint = unsigned int;
type ll = int
#using ull = unsigned long long;

#ll gcd(ll a, ll b) {
#  assert(0 <= a && 0 <= b);
#  if (b == 0) return a;
#  return gcd(b, a % b);
#}

#ll pow_mod_naive(ll x, ull n, uint mod) {
#  ull y = (x % mod + mod) % mod;
#  ull z = 1;
#  for (ull i = 0; i < n; i++) {
#    z = (z * y) % mod;
#  }
#  return z % mod;
#}

#ll floor_sum_naive(ll n, ll m, ll a, ll b) {
#  ll sum = 0;
#  for (ll i = 0; i < n; i++) {
#    sum += (a * i + b) div m;
#  }
#  return sum;
#}

proc is_prime_naive(n:ll):bool =
  assert 0 <= n and n <= int32.high.ll
  if n == 0 or n == 1: return false
  var i = 2
  while i * i <= n:
    if n mod i == 0: return false
    i.inc
  return true

test "InternalMathTest, Barrett":
  for m in 1..100:
    var bt = initBarrett(m.uint)
    for a in 0..<m:
      for b in 0..<m:
        check (a * b) mod m == bt.mul(a.uint, b.uint).int

  var bt = initBarrett(1)
  check 0 == bt.mul(0.uint, 0.uint).int

test "InternalMathTest, BarrettBorder":
  const mod_upper = int32.high.uint32
  for m in countdown(mod_upper, mod_upper - 20.uint32):
    var bt = initBarrett(m)
    var v = newSeq[uint32]()
    for i in 0.uint32..<10.uint32:
      v.add(i)
      v.add(m - i)
      v.add(m div 2.uint32 + i)
      v.add(m div 2.uint32 - i)
    for a in v:
      let a2 = a.ll
      check ((a2 * a2) mod m.ll * a2) mod m.ll == bt.mul(a, bt.mul(a, a)).ll
      for b in v:
        let b2 = b.ll
        check (a2 * b2) mod m.ll == bt.mul(a, b).ll

test "InternalMathTest, IsPrime":
  check not is_prime[121]()
  check not is_prime[11 * 13]()
  check is_prime[1_000_000_007]()
  check not is_prime[1_000_000_008]()
  check is_prime[1_000_000_009]()
  for i in 1..10000:
    check is_prime_naive(i) == is_prime_constexpr(i)
  for i in 1..10000:
    let x = int32.high.int - i
    check is_prime_naive(x) == is_prime_constexpr(x)

##ifndef _MSC_VER
#test "InternalMathTest, SafeMod) {
#  std::vector<ll> preds;
#  for (int i = 0; i <= 100; i++) {
#    preds.add(i);
#    preds.add(-i);
#    preds.add(i);
#    preds.add(ll.low + i);
#    preds.add(ll.high - i);
#  }
#
#  for (auto a : preds) {
#    for (auto b : preds) {
#      if (b <= 0) continue;
#      ll ans = (ll)((__int128(a) % b + b) % b);
#      ASSERT_EQ(ans, safe_mod(a, b));
#    }
#  }
#}
##endif

test "InternalMathTest, InvGcdBound":
  var pred = newSeq[ll]()
  for i in 0..10:
    pred.add(i)
    pred.add(-i)
    pred.add(ll.low + i)
    pred.add(ll.high - i)

    pred.add(ll.low div 2 + i)
    pred.add(ll.low div 2 - i)
    pred.add(ll.high div 2 + i)
    pred.add(ll.high div 2 - i)

    pred.add(ll.low div 3 + i)
    pred.add(ll.low div 3 - i)
    pred.add(ll.high div 3 + i)
    pred.add(ll.high div 3 - i)
  pred.add(998244353)
  pred.add(1_000_000_007)
  pred.add(1_000_000_009)
  pred.add(-998244353)
  pred.add(-1_000_000_007)
  pred.add(-1_000_000_009)

  for a in pred:
    for b in pred:
      if b <= 0: continue
      let a2 = floorMod(a, b)
      let eg = inv_gcd(a, b)
      let g = gcd(a2, b)
      check g == eg[0]
      check 0 <= eg[1]
      check eg[1] <= b div eg[0]
##ifndef _MSC_VER
#      ASSERT_EQ(g % b, (unsigned __int128)(eg.second) * a2 % b);
##endif

test "InternalMathTest, PrimitiveRootTestNaive":
  for m in 2..10000:
    if not is_prime_constexpr(m): continue
    let n = primitive_root_constexpr(m)
    check 1 <= n
    check n < m
    var x = 1
    for i in 1..m-2:
      x = x * n mod m
      # x == n^i
      check 1 != x
    x = x * n mod m
    check 1 == x

test "InternalMathTest, PrimitiveRootTemplateTest":
  check is_primitive_root(2, (primitive_root[2]()))
  check is_primitive_root(3, (primitive_root[3]()))
  check is_primitive_root(5, (primitive_root[5]()))
  check is_primitive_root(7, (primitive_root[7]()))
  check is_primitive_root(11, (primitive_root[11]()))
  check is_primitive_root(998244353, (primitive_root[998244353]()))
  check is_primitive_root(1000000007, (primitive_root[1000000007]()))
  check is_primitive_root(469762049, (primitive_root[469762049]()))
  check is_primitive_root(167772161, (primitive_root[167772161]()))
  check is_primitive_root(754974721, (primitive_root[754974721]()))
  check is_primitive_root(324013369, (primitive_root[324013369]()))
  check is_primitive_root(831143041, (primitive_root[831143041]()))
  check is_primitive_root(1685283601, (primitive_root[1685283601]()))

test "InternalMathTest, PrimitiveRootTest":
  for i in 0..<1000:
    let x = int32.high.int - i
    if not is_prime_constexpr(x): continue
    check is_primitive_root(x, (primitive_root_constexpr(x)))
