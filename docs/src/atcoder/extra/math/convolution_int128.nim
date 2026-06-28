when not declared ATCODER_EXTRA_CONVOLUTION128_HPP:
  const ATCODER_EXTRA_CONVOLUTION128_HPP* = 1
  #import std/math, std/sequtils, std/sugar
  import atcoder/internal_math
  #atcoder/internal_bit
  #import atcoder/element_concepts

  import atcoder/extra/math/int128
  import atcoder/convolution
  import atcoder/modint

  proc convolution_int128*[T:SomeInteger](a, b:seq[T]):seq[Int128] =
    let (n, m) = (a.len, b.len)
    if n == 0 or m == 0: return newSeq[Int128]()
    const
      MOD1:uint = 754974721  # 2^24
      MOD2:uint = 167772161  # 2^25
      MOD3:uint = 469762049  # 2^26
      M2M3 = MOD2 * MOD3
      M1M3 = MOD1 * MOD3
      M1M2 = MOD1 * MOD2
      i1 = inv_gcd((MOD2 * MOD3).int, MOD1.int)[1].uint
      i2 = inv_gcd((MOD1 * MOD3).int, MOD2.int)[1].uint
      i3 = inv_gcd((MOD1 * MOD2).int, MOD3.int)[1].uint
    let
      M1M2M3 = Int128(MOD1 * MOD2) * Int128(MOD3)
    #mixin convolution
    let
      c1 = convolution(a, b, MOD1)
      c2 = convolution(a, b, MOD2)
      c3 = convolution(a, b, MOD3)
    doAssert (i1 * ((MOD2 * MOD3) mod MOD1)) mod MOD1 == 1
    doAssert (i2 * ((MOD3 * MOD1) mod MOD2)) mod MOD2 == 1
    doAssert (i3 * ((MOD1 * MOD2) mod MOD3)) mod MOD3 == 1
    var c = newSeq[Int128](n + m - 1)
    for i in 0..<n + m - 1:
      var x = Int128(0)
      x += Int128((c1[i].uint * i1) mod MOD1) * Int128(M2M3)
      x += Int128((c2[i].uint * i2) mod MOD2) * Int128(M1M3)
      x += Int128((c3[i].uint * i3) mod MOD3) * Int128(M1M2)
      # B = 2^63, -B <= x, r(real value) < B
      # (x, x - M, x - 2M, or x - 3M) = r (mod 2B)
      # r = c1[i] (mod MOD1)
      # focus on MOD1
      # r = x, x - M', x - 2M', x - 3M' (M' = M % 2^64) (mod 2B)
      # r = x,
      #   x - M' + (0 or 2B),
      #   x - 2M' + (0, 2B or 4B),
      #   x - 3M' + (0, 2B, 4B or 6B) (without mod!)
      # (r - x) = 0, (0)
      #       - M' + (0 or 2B), (1)
      #       -2M' + (0 or 2B or 4B), (2)
      #       -3M' + (0 or 2B or 4B or 6B) (3) (mod MOD1)
      # we checked that
      #   ((1) mod MOD1) mod 5 = 2
      #   ((2) mod MOD1) mod 5 = 3
      #   ((3) mod MOD1) mod 5 = 4
      #let v = toUInt((x << 64) >> 64)
      var diff = c1[i] - x mod MOD1
      if diff < 0: diff += MOD1.int
      #const offset = [0'u, 0'u, M1M2M3, 2'u * M1M2M3, 3'u * M1M2M3]
      let offset = [Int128(0), Int128(0), M1M2M3, M1M2M3 * Int128(2), M1M2M3 * Int128(3)]
      x -= offset[to_int(diff mod 5)]
      c[i] = x
      doAssert to_int(x mod Int128(MOD1)) == c1[i]
      doAssert to_int(x mod Int128(MOD2)) == c2[i]
      doAssert to_int(x mod Int128(MOD3)) == c3[i]
    return c

