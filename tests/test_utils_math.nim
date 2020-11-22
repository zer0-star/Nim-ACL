import std/unittest
import atcoder/internal_math
import ../test/utils/math

test "UtilsMathTest, FactorsTest":
  for m in 1..50000:
    var m2 = m
    for x in factors(m):
      check 0 == m mod x
      while m2 mod x == 0: m2 = m2 div x
    check 1 == m2

proc is_primitive_root_naive(m, g:int):bool =
  assert 1 <= g and g < m
#  auto prs = factors(m - 1);
  var x = 1
  for i in 1..m-2:
    x = x * g mod m
    # x == n^i
    if x == 1: return false
  x = x * g mod m
  assert x == 1
  return true

test "UtilsMathTest, IsPrimitiveRootTest":
  for m in 2..500:
    if not is_prime_constexpr(m): continue
    for g in 1..<m:
      check is_primitive_root_naive(m, g) == is_primitive_root(m, g)
