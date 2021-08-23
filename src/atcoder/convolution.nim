when not declared ATCODER_CONVOLUTION_HPP:
  const ATCODER_CONVOLUTION_HPP* = 1

  import std/math, std/sequtils, std/sugar
  import atcoder/internal_math, atcoder/internal_bit
  import atcoder/element_concepts


#  template <class mint,
#            int g = internal::primitive_root<mint::mod()>,
#            internal::is_static_modint_t<mint>* = nullptr>
  type fft_info*[mint:FiniteFieldElem; g, rank2:static[int]] = object
#    static constexpr int rank2 = bsf_constexpr(mint::mod() - 1);
    root, iroot: array[rank2 + 1, mint]

    #std::array<mint, rank2 + 1> root;   # root[i]^(2^i) == 1
    #std::array<mint, rank2 + 1> iroot;  # root[i] * iroot[i] == 1
    rate2, irate2: array[max(0, rank2 - 2 + 1), mint]
    #std::array<mint, std::max(0, rank2 - 2 + 1)> rate2;
    #std::array<mint, std::max(0, rank2 - 2 + 1)> irate2;
    rate3, irate3: array[max(0, rank2 - 3 + 1), mint]
  
    #std::array<mint, std::max(0, rank2 - 3 + 1)> rate3;
    #std::array<mint, std::max(0, rank2 - 3 + 1)> irate3;
  
  proc initFFTInfo*[mint:FiniteFieldElem]():auto =
    const g = primitive_root[mint.mod]()
    const rank2 = bsf(mint.mod - 1)
    var root, iroot:array[rank2 + 1, mint]
    var rate2, irate2: array[max(0, rank2 - 2 + 1), mint]
    var rate3, irate3: array[max(0, rank2 - 3 + 1), mint]
    mixin init, inv

    root[rank2] = mint.init(g).pow((mint.mod - 1) shr rank2)
    iroot[rank2] = root[rank2].inv()
    for i in countdown(rank2 - 1, 0):
      root[i] = root[i + 1] * root[i + 1];
      iroot[i] = iroot[i + 1] * iroot[i + 1];
  
    block:
      var
        prod = mint.init(1)
        iprod = mint.init(1)
      for i in 0..rank2 - 2:
        rate2[i] = root[i + 2] * prod
        irate2[i] = iroot[i + 2] * iprod
        prod *= iroot[i + 2]
        iprod *= root[i + 2]
    block:
      var
        prod = mint.init(1)
        iprod = mint.init(1)
      for i in 0..rank2 - 3:
        rate3[i] = root[i + 3] * prod;
        irate3[i] = iroot[i + 3] * iprod;
        prod *= iroot[i + 3];
        iprod *= root[i + 3];
    return fft_info[mint, g, rank2](root:root, iroot:iroot, rate2:rate2, irate2:irate2, rate3: rate3, irate3:irate3)
  
  proc butterfly*[mint:FiniteFieldElem](a:var seq[mint]) =
    mixin init
    let n = a.len
    let h = ceil_pow2(n)

    const info = initFFTInfo[mint]()

    var len = 0  # a[i, i+(n>>len), i+2*(n>>len), ..] is transformed
    while len < h:
      if h - len == 1:
        let p = 1 shl (h - len - 1)
        var rot = mint.init(1)
        for s in 0..<(1 shl len):
          var offset = s shl (h - len)
          for i in 0..<p:
            let l = a[i + offset]
            let r = a[i + offset + p] * rot
            a[i + offset] = l + r
            a[i + offset + p] = l - r
          if s + 1 != (1 shl len):
            rot *= info.rate2[bsf(not s.uint)]
        len.inc
      else:
        # 4-base
        let p = 1 shl (h - len - 2)
        var
          rot = mint.init(1)
          imag = info.root[2]
        for s in 0..<(1 shl len):
          let
            rot2 = rot * rot
            rot3 = rot2 * rot
            offset = s shl (h - len)
          for i in 0..<p:
            let
              mod2 = (mint.mod() * mint.mod()).uint
              a0 = (a[i + offset].val()).uint
              a1 = (a[i + offset + p].val() * rot.val()).uint
              a2 = (a[i + offset + 2 * p].val() * rot2.val()).uint
              a3 = (a[i + offset + 3 * p].val() * rot3.val()).uint
              a1na3imag = (mint.init(a1 + mod2 - a3).val() * imag.val()).uint
              na2 = mod2 - a2
            a[i + offset] = mint.init(a0 + a2 + a1 + a3)
            a[i + offset + 1 * p] = mint.init(a0 + a2 + (2.uint * mod2 - (a1 + a3)))
            a[i + offset + 2 * p] = mint.init(a0 + na2 + a1na3imag)
            a[i + offset + 3 * p] = mint.init(a0 + na2 + (mod2 - a1na3imag))
          if s + 1 != (1 shl len):
            rot *= info.rate3[bsf(not s.uint)]
        len += 2
  
  proc butterfly_inv*[mint:FiniteFieldElem](a:var seq[mint]) =
    let n = a.len
    let h = ceilpow2(n)
    mixin init

    const info = initFFTInfo[mint]()
  
    var len = h;  # a[i, i+(n>>len), i+2*(n>>len), ..] is transformed
    while len > 0:
      if len == 1:
        let p = 1 shl (h - len)
        var irot = mint.init(1)
        for s in 0..<(1 shl (len - 1)):
          let offset = s shl (h - len + 1)
          for i in 0..<p:
            let
              l = a[i + offset]
              r = a[i + offset + p]
            a[i + offset] = l + r
            a[i + offset + p] = mint.init((mint.mod() + l.val() - r.val()) * irot.val())
          if s + 1 != (1 shl (len - 1)):
            irot *= info.irate2[bsf(not s.uint)]
        len.dec
      else:
        # 4-base
        let p = 1 shl (h - len);
        var irot = mint.init(1)
        let iimag = info.iroot[2]
        for s in 0..<(1 shl (len - 2)):
          let
            irot2 = irot * irot
            irot3 = irot2 * irot
            offset = s shl (h - len + 2)
          for i in 0..<p:
            let
              a0 = a[i + offset + 0 * p].val().uint
              a1 = a[i + offset + 1 * p].val().uint
              a2 = a[i + offset + 2 * p].val().uint
              a3 = a[i + offset + 3 * p].val().uint
              a2na3iimag = mint.init((mint.mod.uint + a2 - a3) * iimag.val().uint).val().uint
  
            a[i + offset] = mint.init(a0 + a1 + a2 + a3)
            a[i + offset + 1 * p] = mint.init((a0 + (mint.mod().uint - a1) + a2na3iimag) * irot.val().uint)
            a[i + offset + 2 * p] = mint.init((a0 + a1 + (mint.mod().uint - a2) + (mint.mod().uint - a3)) * irot2.val().uint)
            a[i + offset + 3 * p] = mint.init((a0 + (mint.mod().uint - a1) + (mint.mod().uint - a2na3iimag)) * irot3.val().uint)
          if s + 1 != (1 shl (len - 2)):
            irot *= info.irate3[bsf(not s.uint)]
        len -= 2

  proc convolution_naive*[mint:FiniteFieldElem](a, b:seq[mint]):seq[mint] =
    mixin `+=`
    let (n, m) = (a.len, b.len)
    result = newSeq[mint](n + m - 1)
#    result = newSeqWith(n + m - 1, mint(0))
    if n < m:
      for j in 0..<m:
        for i in 0..<n:
          result[i + j] += a[i] * b[j]
    else:
      for i in 0..<n:
        for j in 0..<m:
          result[i + j] += a[i] * b[j]

  proc convolution_fft*[mint:FiniteFieldElem](a, b:seq[mint]):seq[mint] =
    mixin init, inv
    let
      (n, m) = (a.len, b.len)
      z = 1 shl ceil_pow2(n + m - 1)
    var (a, b) = (a, b)
    a.setLen(z)
    butterfly(a)
    b.setLen(z)
    butterfly(b)
    for i in 0..<z:
      a[i] *= b[i];
    butterfly_inv(a)
    a.setLen(n + m - 1)
    let iz = mint.init(z).inv()
    for i in 0..<n + m - 1: a[i] *= iz
    return a

  proc convolution*[mint:FiniteFieldElem](a, b:seq[mint]):seq[mint] =
    let (n, m) = (a.len, b.len)
    if n == 0 or m == 0: return
    if min(n, m) <= 60: return convolution_naive(a, b)
    return convolution_fft(a, b)
  
#  template <class mint, internal::is_static_modint_t<mint>* = nullptr>
#  std::vector<mint> convolution(const std::vector<mint>& a,
#                                const std::vector<mint>& b) {
#    int n = int(a.size()), m = int(b.size());
#    if (!n || !m) return {};
#    if (std::min(n, m) <= 60) return convolution_naive(a, b);
#    return internal::convolution_fft(a, b);
#  }


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
