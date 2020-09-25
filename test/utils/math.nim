import atcoder/internal_math
#include <atcoder/internal_math>
#include <atcoder/math>
#include <vector>

proc factors*(m:int):seq[int] =
  var m = m
  result = newSeq[int]()
  var i = 2
  while i * i <= m:
    if m mod i == 0:
      result.add(i)
      while m mod i == 0:
        m = m div i
    i.inc
  if m > 1: result.add(m)

proc is_primitive_root*(m, g:int):bool =
  assert 1 <= g and g < m
  for x in factors(m - 1):
    if pow_mod_constexpr(g, (m - 1) div x, m) == 1: return false
  return true
