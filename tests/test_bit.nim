import std/unittest
import atcoder/internal_bit

test "BitTest, CeilPow2":
  check 0 == ceil_pow2(0)
  check 0 == ceil_pow2(1)
  check 1 == ceil_pow2(2)
  check 2 == ceil_pow2(3)
  check 2 == ceil_pow2(4)
  check 3 == ceil_pow2(5)
  check 3 == ceil_pow2(6)
  check 3 == ceil_pow2(7)
  check 3 == ceil_pow2(8)
  check 4 == ceil_pow2(9)
  check 30 == ceil_pow2(1 shl 30)
  check 31 == ceil_pow2((1 shl 30) + 1)
  check 31 == ceil_pow2(int32.high)

test "BitTest, BSF":
  check 0 == bsf(1)
  check 1 == bsf(2)
  check 0 == bsf(3)
  check 2 == bsf(4)
  check 0 == bsf(5)
  check 1 == bsf(6)
  check 0 == bsf(7)
  check 3 == bsf(8)
  check 0 == bsf(9)
  check 30 == bsf(1.uint shl 30)
  check 0 == bsf((1.uint shl 31) - 1)
  check 31 == bsf(1.uint shl 31)
  check 0 == bsf(uint.high)
