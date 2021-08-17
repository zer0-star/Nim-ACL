import unittest
import atcoder/math
import std/math as math_lib
import std/algorithm

type ll = int
type ull = uint

#proc gcd(a, b:ll):ll =
#  assert 0 <= a and 0 <= b
#  if b == 0: return a
#  return gcd(b, a mod b)

#ll pow_mod_naive(ll x, ull n, uint32 mod) {
#  ull y = (x % mod + mod) % mod;
#  ull z = 1;
#  for (ull i = 0; i < n; i++) {
#    z = (z * y) % mod;
#  }
#  return z % mod;
#}

proc floor_sum_naive(n, m, a, b:ll):ll =
  var sum = 0.ll
  for i in 0..<n:
    let z = a * i + b
    sum += (z - z.floorMod(m)) div m
  return sum

#bool is_prime_naive(ll n) {
#  assert(0 <= n && n <= std::numeric_limits<int>::max());
#  if (n == 0 || n == 1) return false;
#  for (ll i = 2; i * i <= n; i++) {
#    if (n % i == 0) return false;
#  }
#  return true;
#}

test "MathTest, PowMod":
  proc naive(x, n, m:ll):ll =
    var
      y = floorMod(x, m)
      z = 1 mod m
    for i in 0..<n:
      z = (z * y) mod m
    return z
  for a in -100..100:
    for b in 0..100:
      for c in 1..100:
        check naive(a, b, c) == pow_mod(a, b, c)

test "MathTest, InvBoundHand":
  let
    minll = ll.low
    maxll = ll.high
  check inv_mod(-1, maxll) == inv_mod(minll, maxll)
  check 1 == inv_mod(maxll, maxll - 1)
  check maxll - 1 == inv_mod(maxll - 1, maxll)
  check 2 == inv_mod(maxll div 2 + 1, maxll)

test "MathTest, InvMod":
  for a in -100..100:
    for b in 1..1000:
      if gcd(floorMod(a, b), b) != 1: continue
      let c = inv_mod(a, b)
      check 0 <= c
      check c < b
      check 1 mod b == ((a * c) mod b + b) mod b

test "MathTest, InvModZero":
  check 0 == inv_mod(0, 1)
  for i in 0..<10:
    check 0 == inv_mod(i, 1)
    check 0 == inv_mod(-i, 1)
    check 0 == inv_mod(ll.low + i, 1)
    check 0 == inv_mod(ll.high - i, 1)

test "MathTest, FloorSum":
  for n in 0..<20:
    for m in 1..<20:
      for a in -20..<20:
        for b in -20..<20:
          check floor_sum_naive(n, m, a, b) == floor_sum(n, m, a, b)

test "MathTest, CRTHand":
  let res = crt(@[1, 2, 1], @[2, 3, 2])
  check 5 == res[0]
  check 6 == res[1]

test "MathTest, CRT2":
  for a in 1..20:
    for b in 1..20:
      for c in -10..10:
        for d in -10..10:
          let res = crt(@[c, d], @[a, b])
          if res[1] == 0:
            for x in 0 ..< a * b div gcd(a, b):
              check x mod a != c or x mod b != d
            continue
          check a * b div gcd(a, b) == res[1]
          check floorMod(c, a) == res[0] mod a
          check floorMod(d, b) == res[0] mod b

test "MathTest, CRT3":
  for a in 1..5:
    for b in 1..5:
      for c in 1..5:
        for d in -5..5:
          for e in -5..5:
            for f in -5..5:
              let res = crt(@[d, e, f], @[a, b, c])
              var lcm = a * b div gcd(a, b)
              lcm = lcm * c div gcd(lcm, c)
              if res[1] == 0:
                for x in 0..<lcm:
                  check x mod a != d or x mod b != e or x mod c != f
                continue
              check lcm == res[1]
              check floorMod(d, a) == res[0] mod a
              check floorMod(e, b) == res[0] mod b
              check floorMod(f, c) == res[0] mod c

test "MathTest, CRTOverflow":
  let
    r0 = 0
    r1 = 1_000_000_000_000.int - 2
    m0 = 900577
    m1 = 1_000_000_000_000.int
  let res = crt(@[r0, r1], @[m0, m1])
  check m0 * m1 == res[1]
  check r0 == res[0] mod m0
  check r1 == res[0] mod m1

test "MathTest, CRTBound":
  let INF = ll.high
  var pred = newSeq[ll]()
  for i in 1..10:
    pred.add(i)
    pred.add(INF - (i - 1))
  pred.add(998244353)
  pred.add(1_000_000_007)
  pred.add(1_000_000_009)

  for (a, b) in [(INF, INF), (1, INF), (INF, 1), (7, INF), (INF div 337, 337), (2, (INF - 1) div 2)]:
    var (a, b) = (a, b)
    for ph in 0..<2:
      for ans in pred:
        let res = crt(@[ans mod a, ans mod b], @[a, b])
        let lcm = a div gcd(a, b) * b
        check lcm == res[1]
        check ans mod lcm == res[0]
      swap(a, b)
  var factor_inf = [49, 73, 127, 337, 92737, 649657]
  while true:
    for ans in pred:
      var r, m = newSeq[ll]()
      for f in factor_inf:
        r.add(ans mod f)
        m.add(f)
      let res = crt(r, m)
      check ans mod INF == res[0]
      check INF == res[1]
    if not factor_inf.nextPermutation(): break
  var factor_infn1 = [2, 3, 715827883, 2147483647]
  while true:
    for ans in pred:
      var r, m = newSeq[ll]()
      for f in factor_infn1:
        r.add(ans mod f)
        m.add(f)
      let res = crt(r, m)
      check ans mod (INF - 1) == res[0]
      check INF - 1 == res[1]
    if not factor_infn1.nextPermutation(): break

#std::vector<int> factors(int m) {
#  std::vector<int> result;
#  for (int i = 2; (ll)(i)*i <= m; i++) {
#    if (m % i == 0) {
#      result.add(i);
#      while (m % i == 0) {
#        m /= i;
#      }
#    }
#  }
#  if (m > 1) result.add(m);
#  return result;
#}
#
#bool is_primitive_root(int m, int g) {
#  assert(1 <= g && g < m);
#  auto prs = factors(m - 1);
#  for (int x : factors(m - 1)) {
#    if (internal::pow_mod_constexpr(g, (m - 1) / x, m) == 1) return false;
#  }
#  return true;
#}
#
#bool is_primitive_root_naive(int m, int g) {
#  assert(1 <= g && g < m);
#  auto prs = factors(m - 1);
#  int x = 1;
#  for (int i = 1; i <= m - 2; i++) {
#    x = (int)((long long)(x)*g % m);
#    // x == n^i
#    if (x == 1) return false;
#  }
#  x = (int)((long long)(x)*g % m);
#  assert(x == 1);
#  return true;
#}
