when not declared ATCODER_CONVOLUTION_HPP:
  const ATCODER_CONVOLUTION_HPP = 1

#include <algorithm>
#include <array>
#include <atcoder/internal_bit>
#include <atcoder/modint>
#include <cassert>
#include <type_traits>
#include <vector>
  import std/math
  import src/nim_acl/internal_math, src/nim_acl/internal_bit, src/nim_acl/modint
  
#  template <class mint, internal::is_static_modint_t<mint>* = nullptr>
  proc butterfly*[mint:StaticModInt](a:var seq[mint]) =
    const g = primitive_root[mint.M]()
    let
      n = a.len
      h = ceil_pow2(n)
    
    var 
      first {.global.} = true
      sum_e {.global.} :array[30, mint]   # sum_e[i] = ies[0] * ... * ies[i - 1] * es[i]
    if first:
      first = false
      var es, ies:array[30, mint] # es[i]^(2^(2+i)) == 1
      let cnt2 = bsf(mint.M - 1)
      var
        e = mint(g).pow((mint.M - 1) shr cnt2)
        ie = e.inv()
      for i in countdown(cnt2, 2):
        # e^(2^i) == 1
        es[i - 2] = e
        ies[i - 2] = ie
        e *= e
        ie *= ie
      var now = mint(1)
      for i in 0..<cnt2 - 2:
        sum_e[i] = es[i] * now
        now *= ies[i]
    for ph in 1..h:
      let
        w = 1 shl (ph - 1)
        p = 1 shl (h - ph)
      var now = mint(1)
      for s in 0..<w:
        let offset = s shl (h - ph + 1)
        for i in 0..<p:
          let
            l = a[i + offset]
            r = a[i + offset + p] * now
          a[i + offset] = l + r
          a[i + offset + p] = l - r
        now *= sum_e[bsf(not s.uint)]
  
  proc butterfly_inv*[mint:StaticModInt](a:var seq[mint]) =
    const g = primitive_root[mint.M]()
    let
      n = a.len
      h = ceil_pow2(n)
    var
      first{.global.} = true
      sum_ie{.global.}:array[30, mint]  # sum_ie[i] = es[0] * ... * es[i - 1] * ies[i]
    if first:
      first = false
      var es, ies: array[30, mint] # es[i]^(2^(2+i)) == 1
      let cnt2 = bsf(mint.M - 1)
      var
        e = mint(g).pow((mint.M - 1) shr cnt2)
        ie = e.inv()
      for i in countdown(cnt2, 2):
        # e^(2^i) == 1
        es[i - 2] = e
        ies[i - 2] = ie
        e *= e
        ie *= ie
      var now = mint(1)
      for i in 0..<cnt2 - 2:
        sum_ie[i] = ies[i] * now
        now *= es[i]
  
    for ph in countdown(h, 1):
      let
        w = 1 shl (ph - 1)
        p = 1 shl (h - ph)
      var inow = mint(1)
      for s in 0..<w:
        let offset = s shl (h - ph + 1)
        for i in 0..<p:
          let
            l = a[i + offset]
            r = a[i + offset + p]
          a[i + offset] = l + r
          a[i + offset + p] = mint.init((mint.umod.uint + l.uint - r.uint) * uint(inow))
        inow *= sum_ie[bsf(not s.uint)]

#  template <class mint, internal::is_static_modint_t<mint>* = nullptr>
  proc convolution*[mint:StaticModInt](a, b:seq[mint]):seq[mint] =
    var
      n = a.len
      m = b.len
    if n == 0 or m == 0: return newSeq[mint]()
    var (a, b) = (a, b)
    if min(n, m) <= 60:
      if n < m:
        swap(n, m)
        swap(a, b)
      var ans = newSeq[mint](n + m - 1)
      for i in 0..<n:
        for j in 0..<m:
          ans[i + j] += a[i] * b[j]
      return ans
    let z = 1 shl ceil_pow2(n + m - 1)
    a.setlen(z)
    butterfly(a)
    b.setlen(z)
    butterfly(b);
    for i in 0..<z:
      a[i] *= b[i]
    butterfly_inv(a)
    a.setlen(n + m - 1)
    let iz = mint(z).inv()
    for i in 0..<n+m-1: a[i] *= iz
    return a
  
#  template <unsigned int mod = 998244353,
#      class T,
#      std::enable_if_t<internal::is_integral<T>::value>* = nullptr>
  proc convolution*[M:static[uint] = 998244353, T:SomeInteger](a, b:seq[T]):seq[T] =
    let (n, m) = (a.len, b.len)
    if n == 0 or m == 0: return newSeq[T]()
  
    type mint = StaticModInt[M.int]
    var
      a2 = newSeq[mint](n)
      b2 = newSeq[mint](m)
    for i in 0..<n:
      a2[i] = mint(a[i])
    for i in 0..<m:
      b2[i] = mint(b[i])
#    let c2 = convolution(move(a2), move(b2))
    let c2 = convolution(a2, b2)
    var c = newSeq[T](n + m - 1)
    for i in 0..<n + m - 1:
      c[i] = c2[i].val()
    return c
  proc convolution_ll*(a, b:seq[int]):seq[int] =
    let (n, m) = (a.len, b.len)
    if n == 0 or m == 0: return newSeq[int]()
    const
      MOD1:uint = 754974721  # 2^24
      MOD2:uint = 167772161  # 2^25
      MOD3:uint = 469762049  # 2^26
      M2M3 = MOD2 * MOD3
      M1M3 = MOD1 * MOD3
      M1M2 = MOD1 * MOD2
      M1M2M3 = MOD1 * MOD2 * MOD3

      i1 = inv_gcd((MOD2 * MOD3).int, MOD1.int)[1].uint
      i2 = inv_gcd((MOD1 * MOD3).int, MOD2.int)[1].uint
      i3 = inv_gcd((MOD1 * MOD2).int, MOD3.int)[1].uint
    
    let
      c1 = convolution[MOD1,int](a, b)
      c2 = convolution[MOD2,int](a, b)
      c3 = convolution[MOD3,int](a, b)
  
    var c = newSeq[int](n + m - 1)
    for i in 0..<n + m - 1:
      var x = 0.uint
      x += (c1[i].uint * i1) mod MOD1 * M2M3
      x += (c2[i].uint * i2) mod MOD2 * M1M3
      x += (c3[i].uint * i3) mod MOD3 * M1M2
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
      var diff = c1[i] - floorMod(x.int, MOD1.int)
      if diff < 0: diff += MOD1.int
      const offset = [0'u, 0'u, M1M2M3, 2'u * M1M2M3, 3'u * M1M2M3]
      x -= offset[diff mod 5]
      c[i] = x.int
    return c
