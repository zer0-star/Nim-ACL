when not declared ATCODER_CONVOLUTION_HPP:
  const ATCODER_CONVOLUTION_HPP* = 1

  import std/math, std/sequtils, std/sugar
  import atcoder/internal_math, atcoder/internal_bit
  import atcoder/element_concepts

#  template <class mint, internal::is_static_modint_t<mint>* = nullptr>
  proc butterfly*[mint:FiniteFieldElem](a:var seq[mint]) =
    const g = primitive_root[mint.mod]()
    let
      n = a.len
      h = ceil_pow2(n)
    var
      first {.global.} = true
      sum_e {.global.} :array[30, mint]   # sum_e[i] = ies[0] * ... * ies[i - 1] * es[i]
    if first:
      first = false
      var es, ies:array[30, mint] # es[i]^(2^(2+i)) == 1
      let cnt2 = bsf(mint.mod - 1)
      mixin inv, init
      var
        e = mint.init(g).pow((mint.mod - 1) shr cnt2)
        ie = e.inv()
      for i in countdown(cnt2, 2):
        # e^(2^i) == 1
        es[i - 2] = e
        ies[i - 2] = ie
        e *= e
        ie *= ie
      var now = mint.init(1)
      for i in 0..cnt2 - 2:
        sum_e[i] = es[i] * now
        now *= ies[i]
    for ph in 1..h:
      let
        w = 1 shl (ph - 1)
        p = 1 shl (h - ph)
      var now = mint.init(1)
      for s in 0..<w:
        let offset = s shl (h - ph + 1)
        for i in 0..<p:
          let
            l = a[i + offset]
            r = a[i + offset + p] * now
          a[i + offset] = l + r
          a[i + offset + p] = l - r
        now *= sum_e[bsf(not s)]
  
  proc butterfly_inv*[mint:FiniteFieldElem](a:var seq[mint]) =
    mixin val
    const g = primitive_root[mint.mod]()
    let
      n = a.len
      h = ceil_pow2(n)
    var
      first{.global.} = true
      sum_ie{.global.}:array[30, mint]  # sum_ie[i] = es[0] * ... * es[i - 1] * ies[i]
    mixin inv, init
    if first:
      first = false
      var es, ies: array[30, mint] # es[i]^(2^(2+i)) == 1
      let cnt2 = bsf(mint.mod - 1)
      var
        e = mint.init(g).pow((mint.mod - 1) shr cnt2)
        ie = e.inv()
      for i in countdown(cnt2, 2):
        # e^(2^i) == 1
        es[i - 2] = e
        ies[i - 2] = ie
        e *= e
        ie *= ie
      var now = mint.init(1)
      for i in 0..cnt2 - 2:
        sum_ie[i] = ies[i] * now
        now *= es[i]
    for ph in countdown(h, 1):
      let
        w = 1 shl (ph - 1)
        p = 1 shl (h - ph)
      var inow = mint.init(1)
      for s in 0..<w:
        let offset = s shl (h - ph + 1)
        for i in 0..<p:
          let
            l = a[i + offset]
            r = a[i + offset + p]
          a[i + offset] = l + r
          a[i + offset + p] = mint.init((mint.mod + l.val - r.val) * inow.val)
        inow *= sum_ie[bsf(not s)]

#  template <class mint, internal::is_static_modint_t<mint>* = nullptr>
  proc convolution*[mint:FiniteFieldElem](a, b:seq[mint]):seq[mint] =
    var
      n = a.len
      m = b.len
    mixin inv, init
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
    butterfly(b)
    for i in 0..<z:
      a[i] *= b[i]
    butterfly_inv(a)
    a.setlen(n + m - 1)
    let iz = mint.init(z).inv()
    for i in 0..<n+m-1: a[i] *= iz
    return a


  import atcoder/modint
#  template <unsigned int mod = 998244353,
#      class T,
#      std::enable_if_t<internal::is_integral<T>::value>* = nullptr>
  proc convolution*[T:SomeInteger](a, b:seq[T], M:static[uint] = 998244353):seq[T] =
    let (n, m) = (a.len, b.len)
    if n == 0 or m == 0: return newSeq[T]()
  
    type mint = StaticModInt[M.int]
    static:
      assert mint is FiniteFieldElem
    return convolution(
      a.map((x:T) => mint.init(x)), 
      b.map((x:T) => mint.init(x))
    ).map((x:mint) => T(x.val()))

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
      c1 = convolution(a, b, MOD1)
      c2 = convolution(a, b, MOD2)
      c3 = convolution(a, b, MOD3)
  
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
