when not declared ATCODER_MULTIPRECISION_HPP:
  const ATCODER_MULTIPRECISION_HPP* = 1
  import atcoder/extra/math/int128, atcoder/modint
  import atcoder/extra/math/convolution_int128
  import atcoder/convolution
  import std/sequtils, std/unicode
  #const offset = 30
  #type TENS = object
  #  constexpr TENS() : _tend() {
  #    _tend[offset] = 1;
  #    for (int i = 1; i <= offset; i++) {
  #      _tend[offset + i] = _tend[offset + i - 1] * 10.0;
  #      _tend[offset - i] = 1.0 / _tend[offset + i];
  #    }
  #  }
  #  long double ten_ld(int n) const {
  #    assert(-offset <= n and n <= offset);
  #    return _tend[n + offset];
  #  }
  #
  # private:
  #  long double _tend[offset * 2 + 1];
  #};
  #}  // namespace bigintImpl
  
  # 0 は neg=false, dat={} として扱う
  type bigint* = object
    #using M = bigint;
    #inline constexpr static bigintImpl::TENS tens = {};
    neg: bool
    dat: seq[int32]

  const
    D = 1000000000
    logD = 9

  proc initbigint*(): bigint =
    bigint(neg:false)
  
  proc initbigint*(n:bool, d:seq[int32]): bigint =
    bigint(neg:n, dat:d)
  
  proc initbigint*(x:SomeInteger): bigint =
    var
      neg = false
      dat = newSeq[int32]()
      x = x
    when x is SomeSignedInt:
      if x < 0:
        neg = true
        x = -x
    while x != 0: dat.add(int32(x mod D)); x = x div D
    return bigint(neg: neg, dat:dat)
  
  proc initbigint*(S:string):bigint =
    assert S.len > 0
    if S.len == 1 and S[0] == '0': return bigint(neg: false)
    var
      l = 0
      neg = false
      dat = newSeq[int32]()
    if S[0] == '-': l.inc; neg = true
    block:
      var ie = S.len
      while l < ie:
        var
          istart = max(l, ie - logD)
          x = 0'i32
        for i in istart ..< ie: x = x * 10'i32 + int32(S[i].ord) - int32('0'.ord)
        dat.add(x)
        ie -= logD
    while dat.len > 0 and dat[^1] == 0: discard dat.pop()
    return bigint(neg: neg, dat:dat)
  converter toBigInt*(x: SomeInteger): bigint = initbigint(x)
  converter toBigInt*(S: string): bigint = initbigint(S)
  
  # 内部の関数をテスト
  #static void _test_private_function(const M&, const M&);
  
  # size
  proc size*(a:bigint):int = a.dat.len
  # a == b
  proc inner_eq(a, b: seq[int32]):bool = a == b
  # a < b
  proc inner_lt(a, b: seq[int32]):bool =
    if a.len != b.len: return a.len < b.len
    for i in countdown(a.len - 1, 0):
      if a[i] != b[i]: return a[i] < b[i]
    return false
  # a <= b
  proc inner_leq(a, b: seq[int32]):bool =
    return inner_eq(a, b) or inner_lt(a, b)
  # a < b (s.t. a != b)
  proc inner_neq_lt(lhs, rhs: bigint):bool =
    assert(lhs != rhs);
    if lhs.neg != rhs.neg: return lhs.neg
    var f = inner_lt(lhs.dat, rhs.dat)
    if f: return not lhs.neg
    return lhs.neg
  # a == 0
  proc inner_is_zero(a:seq[int32]):bool = a.len == 0
  # a == 1
  proc inner_is_one(a:seq[int32]):bool =
    return a.len == 1 and a[0] == 1
  # 末尾 0 を削除
  proc inner_shrink(a: var seq[int32]) =
    while a.len > 0 and a[^1] == 0: discard a.pop()
  # 末尾 0 を削除
  proc inner_shrink(a: var bigint) =
    while a.size > 0 and a.dat[^1] == 0: discard a.dat.pop()
  # a + b
  proc inner_add(a, b:seq[int32]):seq[int32] =
    var c = newSeq[int32](max(a.len, b.len) + 1)
    for i in 0 ..< a.len: c[i] += a[i]
    for i in 0 ..< b.len: c[i] += b[i]
    for i in 0 ..< c.len - 1:
      if c[i] >= D: c[i] -= D; c[i + 1].inc
    inner_shrink(c)
    return c
  # a - b
  proc inner_sub(a, b: seq[int32]):seq[int32] =
    assert inner_leq(b, a)
    var
      c = a
      borrow:int32 = 0
    for i in 0 ..< a.len:
      if i < b.len: borrow += b[i]
      c[i] -= borrow
      borrow = 0
      if c[i] < 0: c[i] += D; borrow = 1
    assert borrow == 0
    inner_shrink(c)
    return c

  proc `+`*(lhs, rhs: bigint): bigint =
    if lhs.neg == rhs.neg: return initbigint(lhs.neg, inner_add(lhs.dat, rhs.dat))
    if inner_leq(lhs.dat, rhs.dat):
      # |l| <= |r|
      var
        c = inner_sub(rhs.dat, lhs.dat)
        n = if inner_is_zero(c): false else: rhs.neg
      return initbigint(n, c)
    var
      c = inner_sub(lhs.dat, rhs.dat)
      n = if inner_is_zero(c): false else: lhs.neg
    return initbigint(n, c)
  proc is_zero(a: bigint):bool = a.dat.inner_is_zero
  proc  `-`*(a: bigint):bigint =
    if a.is_zero(): return a
    result = a
    result.neg = not result.neg

  proc `-`*(lhs, rhs: bigint):bigint = return lhs + (-rhs)
  #proc convolution_int128_naive(a, b: seq[int32]):seq[Int128] =
  #  result = newSeqWith(a.len + b.len - 1, Int128(0))
  #  for i in a.len:
  #    for j in b.len:
  #      result[i + j] += Int128(a[i]) * b[j]

  # a * b (fft)
  proc inner_mul_fft*(a, b: seq[int32]):seq[int32] =
    if a.len == 0 or b.len == 0: return
    var m = convolution_int128(a, b)
    #doAssert m == convolution_int128_naive(a, b)
    #auto m = ArbitraryNTT::multiply_u128(a, b);
    result = newSeqOfCap[int32](m.len + 3)
    var x = Int128(0)
    block:
      var i = 0
      while true:
        if i >= m.len and x == 0: break
        if i < m.len: x += m[i]
        result.add(to_int32(x mod D))
        x = x div D
        i.inc
    result.inner_shrink()
  # a * b (naive)
  proc inner_mul_naive*(a, b: seq[int32]):seq[int32] =
    if a.len == 0 or b.len == 0: return
    var prod = newSeq[int](a.len + b.len - 1 + 1)
    for i in 0 ..< a.len:
      for j in 0 ..< b.len:
        let p = int(a[i]) * int(b[j])
        prod[i + j] += p
        if prod[i + j] >= 4 * D * D:
          prod[i + j] -= 4 * D * D
          prod[i + j + 1] += 4 * D
    result = newSeq[int32](prod.len + 1)
    var
      x = 0
      i = 0
    while i < prod.len:
      x += prod[i]
      result[i] = int32(x mod D)
      x = x div D
      i.inc
    while x > 0:
      result[i] = int32(x mod D)
      x = x div D
      i.inc
    inner_shrink(result)
  # a * b
  proc inner_mul*(a, b: seq[int32]): seq[int32] =
    if inner_is_zero(a) or inner_is_zero(b): return
    if inner_is_one(a): return b
    if inner_is_one(b): return a
    if min(a.len, b.len) <= 128:
      return if a.len < b.len: inner_mul_naive(b, a) else: inner_mul_naive(a, b)
    return inner_mul_fft(a, b)

  proc `*`*(lhs, rhs: bigint):bigint =
    let
      c = inner_mul(lhs.dat, rhs.dat)
      n = if inner_is_zero(c): false else: lhs.neg xor rhs.neg
    return initbigint(n, c)

  proc inner_to_int(a:seq[int32]):int =
    result = 0
    for i in countdown(a.len - 1, 0):
      result = result * D + a[i]
  
  proc inner_to_i128(a:seq[int32]):Int128 =
    result = 0
    for i in countdown(a.len - 1, 0):
      result = result * D + a[i]

  # convert ll to vec
  proc inner_integer_to_vec(x:int):seq[int32] =
    assert x >= 0
    var x = x
    #if constexpr (internal::is_broadly_signed_v<I>) {
    #  assert(x >= 0);
    #}
    while x > 0:
      result.add(int32(x mod D)); x = x div D

  # 0 <= A < 1e18, 1 <= B < 1e9
  proc inner_divmod_li(a, b: seq[int32]): (seq[int32], seq[int32]) =
    assert 0 <= a.len and a.len <= 2
    assert b.len == 1
    let
      va = inner_to_int(a)
      vb = b[0]
    return (inner_integer_to_vec(va div vb), inner_integer_to_vec(va mod vb))

  # 0 <= A < 1e18, 1 <= B < 1e18
  proc inner_divmod_ll(a, b: seq[int32]): (seq[int32], seq[int32]) =
    assert 0 <= a.len and a.len <= 2
    assert 1 <= b.len and b.len <= 2
    let
      va = inner_to_int(a)
      vb = inner_to_int(b)
    return (inner_integer_to_vec(va div vb), inner_integer_to_vec(va mod vb))

  # 1 <= B < 1e9
  proc inner_divmod_1e9(a, b:seq[int32]): (seq[int32], seq[int32]) =
    assert b.len == 1
    if b[0] == 1:
      result[0] = a
      return
    if a.len <= 2: return inner_divmod_li(a, b)
    var
      quo = newSeq[int32](a.len)
      d = 0
      b0 = b[0]
    for i in countdown(a.len - 1, 0):
      d = d * D + a[i]
      assert d < D * int(b0)
      var
        q = d div b0
        r = d mod b0
      quo[i] = int32(q)
      d = r
    inner_shrink(quo)
    result[0] = quo
    if d != 0: result[1] = @[int32(d)]
    return
  # 0 <= A, 1 <= B
  proc inner_divmod_naive(a, b: seq[int32]):(seq[int32], seq[int32]) =
    if inner_is_zero(b):
      echo "Divide by Zero Exception"
      quit(1)
    assert 1 <= b.len
    if b.len == 1: return inner_divmod_1e9(a, b)
    if max(a.len, b.len) <= 2: return inner_divmod_ll(a, b)
    if inner_lt(a, b):
      result[1] = a
      return
    # B >= 1e9, A >= B
    let
      norm = int32(D div (b[^1] + 1))
      x = inner_mul(a, @[norm])
      y = inner_mul(b, @[norm])
      yb = y[^1]
    var
      quo = newSeq[int32](x.len - y.len + 1)
      rem = x[^y.len .. ^1]
      #(x.end() - y.len, x.end());
    for i in countdown(quo.len - 1, 0):
      if rem.len < y.len:
        discard
      elif rem.len == y.len:
        if inner_leq(y, rem):
          quo[i] = 1; rem = inner_sub(rem, y)
      else:
        assert y.len + 1 == rem.len
        let
          rb = int(rem[rem.len - 1]) * D + rem[rem.len - 2]
        var
          q = int32(rb div yb)
          yq = inner_mul(y, @[q])
        # 真の商は q-2 以上 q+1 以下だが自信が無いので念のため while を回す
        while inner_lt(rem, yq): q.dec; yq = inner_sub(yq, y)
        rem = inner_sub(rem, yq)
        while inner_leq(y, rem): q.inc; rem = inner_sub(rem, y)
        quo[i] = q;
      #if i > 0: rem.insert(begin(rem), x[i - 1]);
      if i > 0: rem.insert(x[i - 1], 0)
    inner_shrink(quo); inner_shrink(rem)
    let (q2, r2) = inner_divmod_1e9(rem, @[norm])
    assert inner_is_zero(r2)
    return (quo, q2)
  
  #// 0 <= A, 1 <= B
  #static pair<seq[int32], seq[int32]> _divmod_dc(const seq[int32]& a,
  #                                                 const seq[int32]& b);
  #
  # 1 / a を 絶対誤差 B^{-deg} で求める
  proc inner_calc_inv(a: seq[int32], deg:int): seq[int32] =
    assert a.len > 0 and D div 2 <= a[^1] and a[^1] < D
    var
      k = deg
      c = a.len
    while k > 64: k = (k + 1) div 2
    var z = newSeq[int32](c + k + 1)
    z[^1] = 1
    z = inner_divmod_naive(z, a)[0]
    while k < deg:
      var s = inner_mul(z, z)
      s.insert(int32(0), 0)
      let
        d = min(c, 2 * k + 1)
        t = a[^d .. ^1]
      var
        u = inner_mul(s, t)
      u.delete(0 ..< d)
      var
        w2 = inner_add(z, z)
        w = newSeq[int32](k + 1) & w2
      #copy(begin(w2), end(w2), back_inserter(w));
      z = inner_sub(w, u)
      z.delete(0 .. 0)
      k *= 2
    z.delete(0 ..< k - deg)
    return z

  proc inner_divmod_newton(a, b: seq[int32]): (seq[int32], seq[int32]) =
    if inner_is_zero(b):
      echo "Divide by Zero Exception"
      quit(1)
    if b.len <= 64: return inner_divmod_naive(a, b)
    if a.len - b.len <= 64: return inner_divmod_naive(a, b)
    let
      norm = int32(D div (b[^1] + 1))
      x = inner_mul(a, @[norm])
      y = inner_mul(b, @[norm])
      s = x.len
      t = y.len
      deg = s - t + 2
      z = inner_calc_inv(y, deg)
    var q = inner_mul(x, z)
    q.delete(0 ..< t + deg)
    var yq = inner_mul(y, q);
    while inner_lt(x, yq):
      q = inner_sub(q, @[int32(1)]); yq = inner_sub(yq, y)
    var r = inner_sub(x, yq)
    while inner_leq(y, r): q = inner_add(q, @[int32(1)]); r = inner_sub(r, y)
    inner_shrink(q); inner_shrink(r)
    let (q2, r2) = inner_divmod_1e9(r, @[norm])
    assert(inner_is_zero(r2))
    return (q, q2)

  # int -> string
  # 先頭かどうかに応じて zero padding するかを決める
  proc inner_itos(x:int, zero_padding:bool):string =
    assert 0 <= x and x < D
    var x = x
    result = ""
    for i in 0 ..< logD:
      result.add(('0'.ord + x mod 10).chr); x = x div 10
    if not zero_padding:
      var i = result.len - 1
      while i >= 0 and result[i] == '0': i.dec
      result = result[0 .. i]
      assert result.len > 0
    result = result.reversed

  proc divmod*(lhs, rhs:bigint):tuple[d, m: bigint] =
    let
      dm = inner_divmod_newton(lhs.dat, rhs.dat)
      dn = if inner_is_zero(dm[0]): false else: lhs.neg != rhs.neg
      mn = if inner_is_zero(dm[1]): false else: lhs.neg
    return (initbigint(dn, dm[0]), initbigint(mn, dm[1]))
  proc `div`*(lhs, rhs: bigint):bigint = return divmod(lhs, rhs)[0]
  proc `mod`*(lhs, rhs: bigint):bigint = return divmod(lhs, rhs)[1]
  
  proc `+=`*(this: var bigint, rhs: bigint) = this = this + rhs
  proc `-=`*(this: var bigint, rhs: bigint) = this = this - rhs
  proc `*=`*(this: var bigint, rhs: bigint) = this = this * rhs
  proc `div=`*(this: var bigint, rhs: bigint) = this = this div rhs
  proc `mod=`*(this: var bigint, rhs: bigint) = this = this mod rhs
  
  proc `+`*(this: bigint):bigint = this
  proc abs*(m: bigint):bigint = result = m;result.neg = false
 
  proc `==`*(lhs, rhs:bigint):bool =
    return lhs.neg == rhs.neg and lhs.dat == rhs.dat
  proc `!=`*(lhs, rhs:bigint):bool =
    return lhs.neg != rhs.neg or lhs.dat != rhs.dat
  proc `<`*(lhs, rhs: bigint):bool =
    if lhs == rhs: return false
    return inner_neq_lt(lhs, rhs)
  proc `<=`*(lhs, rhs: bigint):bool =
    if lhs == rhs: return true
    return inner_neq_lt(lhs, rhs);
  proc `>`*(lhs, rhs: bigint):bool =
    if lhs == rhs: return false
    return inner_neq_lt(rhs, lhs)
  proc `>=`*(lhs, rhs: bigint):bool =
    if lhs == rhs: return true
    return inner_neq_lt(rhs, lhs)
  #
  ##// a * 10^b (1 <= |a| < 10) の形で渡す
  ##// 相対誤差：10^{-16} ~ 10^{-19} 程度 (処理系依存)
  ##pair<long double, int> dfp() const {
  ##  if (is_zero()) return {0, 0};
  ##  int l = max<int>(0, _len - 3);
  ##  int b = logD * l;
  ##  string prefix{};
  ##  for (int i = _len - 1; i >= l; i--) {
  ##    prefix += _itos(dat[i], i != _len - 1);
  ##  }
  ##  b += prefix.len - 1;
  ##  long double a = 0;
  ##  for (auto& c : prefix) a = a * 10.0 + (c - '0');
  ##  a *= tens.ten_ld(-((int)prefix.len) + 1);
  ##  a = clamp<long double>(a, 1.0, nextafterl(10.0, 1.0));
  ##  if (neg) a = -a;
  ##  return {a, b};
  ##}
  proc `$`*(self: bigint):string =
    if self.is_zero(): return "0"
    result = ""
    if self.neg: result.add('-')
    for i in countdown(self.dat.len - 1, 0):
      result &= inner_itos(self.dat[i], i != self.dat.len - 1)
  ##long double to_ld() const {
  ##  auto [a, b] = dfp();
  ##  if (-tens.offset <= b and b <= tens.offset) {
  ##    return a * tens.ten_ld(b);
  ##  }
  ##  return a * powl(10, b);
  ##}
  #long long to_ll() const {
  #  long long res = _to_ll(dat);
  #  return neg ? -res : res;
  #}
  #__int128_t to_i128() const {
  #  __int128_t res = _to_i128(dat);
  #  return neg ? -res : res;
  #}
  #
  #friend istream& operator>>(istream& is, M& m) {
  #  string s;
  #  is >> s;
  #  m = M{s};
  #  return is;
  #}
  #
  #friend ostream& operator<<(ostream& os, const M& m) {
  #  return os << m.to_string();
  #}
  
  
#  static void _dump(const seq[int32]& a, string s = "") {
#    if (!s.empty()) cerr << s << " : ";
#    cerr << "{ ";
#    for (int i = 0; i < (int)a.len; i++) cerr << a[i] << ", ";
#    cerr << "}" << endl;
#  }
#  
#
#using bigint = bigint;
#
#


