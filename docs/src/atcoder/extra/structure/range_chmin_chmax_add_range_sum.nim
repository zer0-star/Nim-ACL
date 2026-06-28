when not declared ATCODER_EXTRA_RANGE_CHMIN_CHMAX_ADD_RANGE_SUM_HPP:
  import atcoder/extra/structure/universal_segtree
  const ATCODER_EXTRA_RANGE_CHMIN_CHMAX_ADD_RANGE_SUM_HPP* = 1
  import std/options
  import std/sugar
#    static_assert(std::is_signed<Num>::value, "Num must be signed");
  type
    RCCARS_S*[Num] = object
      lo, hi, lo2, hi2, sum: Num
      sz, nlo, nhi: int
    RCCARS_F*[Num] = object
      lb, ub, bias: Num
    RCCARS_Base[Num; INF: static[Num]; S, F] = object

  proc initS*[CLS: RCCARS_Base](cls: typedesc[CLS]):CLS.S =
    const INF = CLS.INF
    RCCARS_S[CLS.Num](lo: INF, hi: -INF, lo2: INF, hi2: -INF, sum: 0, sz: 0, nlo: 0, nhi: 0)
  proc initS*[CLS: RCCARS_Base](cls: typedesc[CLS], x:CLS.Num, sz: int):CLS.S =
    const INF = CLS.INF
    RCCARS_S[CLS.Num](lo: x, hi: x, lo2: INF, hi2: -INF, sum: x * sz, sz: sz, nlo: sz, nhi: sz)

  #template <class OStream> friend OStream &operator<<(OStream &os, const S s) {
  #  return os << "[(" << s.lo << "x" << s.nlo << ", " << s.lo2 << ", " << s.hi2 << ", "
  #        << s.hi << "x" << s.nhi << "), sz=" << s.sz << ", sum=" << s.sum << "]";
  #}
  proc second_lowest[CLS: RCCARS_Base](cls: typedesc[CLS], a, a2, c, c2: CLS.Num): CLS.Num =
    assert a <= a2 # a < a2 or a == a2 == INF
    assert c <= c2 # c < c2 or c == c2 == -INF
    return if a == c: min(a2, c2) else:
      if a2 <= c: a2 else:
        if c2 <= a: c2 else: max(a, c)
  
  proc second_highest[CLS: RCCARS_Base](cls: typedesc[CLS], a, a2, b, b2: CLS.Num): CLS.Num =
    assert a >= a2 # a > a2 or a == a2 == -INF
    assert b >= b2 # b > b2 or b == b2 == INF
    return if a == b: max(a2, b2) else:
          if a2 >= b: a2 else: 
            if b2 >= a: b2 else: min(a, b)
  
  proc e[CLS: RCCARS_Base](): CLS.S = return CLS.initS()
  proc op[CLS: RCCARS_Base](l, r: CLS.S): CLS.S =
    if l.lo > l.hi: return r
    if r.lo > r.hi: return l
    result.lo = min(l.lo, r.lo)
    result.hi = max(l.hi, r.hi)
    result.lo2 = CLS.second_lowest(l.lo, l.lo2, r.lo, r.lo2)
    result.hi2 = CLS.second_highest(l.hi, l.hi2, r.hi, r.hi2)
    result.sum = l.sum + r.sum
    result.sz = l.sz + r.sz
    result.nlo = l.nlo * (if l.lo <= r.lo: 1 else: 0) + r.nlo * (if r.lo <= l.lo: 1 else: 0)
    result.nhi = l.nhi * (if l.hi >= r.hi: 1 else: 0) + r.nhi * (if r.hi >= l.hi: 1 else: 0)
 
  proc initF[CLS: RCCARS_Base](cls: typedesc[CLS]): CLS.F = CLS.F(lb: -CLS.INF, ub: CLS.INF, bias: 0)
  proc initF[CLS: RCCARS_Base](cls: typedesc[CLS], chmax, chmin, add: CLS.Num): CLS.F = CLS.F(lb: chmax, ub: chmin, bias: add)
 
  proc composition[CLS: RCCARS_Base](fnew, fold: CLS.F): CLS.F =
    result = CLS.initF()
    result.lb = max(min(fold.lb + fold.bias, fnew.ub), fnew.lb) - fold.bias
    result.ub = min(max(fold.ub + fold.bias, fnew.lb), fnew.ub) - fold.bias
    result.bias = fold.bias + fnew.bias;
  
  proc id[CLS: RCCARS_Base](): CLS.F = CLS.initF()
  
  proc mapping[CLS: RCCARS_Base](f: CLS.F, x: CLS.S): Option[CLS.S] =
    if x.sz == 0: return e[CLS]().some
  
    # f の作用後 x の要素が 1 種類だけになるケース
    if x.lo == x.hi or f.lb == f.ub or f.lb >= x.hi or f.ub <= x.lo:
      return CLS.initS(min(max(x.lo, f.lb), f.ub) + f.bias, x.sz).some
    var x = x
  
    # 2 種類 -> 1 種類
    if x.lo2 == x.hi:
      x.lo = max(x.lo, f.lb) + f.bias
      x.hi2 = x.lo
      x.hi = min(x.hi, f.ub) + f.bias
      x.lo2 = x.hi
      x.sum = x.lo * CLS.Num(x.nlo) + x.hi * CLS.Num(x.nhi)
      return x.some
  
    # lo と lo2, hi と hi2 が潰れないケース
    if f.lb < x.lo2 and f.ub > x.hi2:
      let
        nxt_lo = max(x.lo, f.lb)
        nxt_hi = min(x.hi, f.ub)
      x.sum += (nxt_lo - x.lo) * CLS.Num(x.nlo) - (x.hi - nxt_hi) * CLS.Num(x.nhi) + f.bias * CLS.Num(x.sz)
      x.lo = nxt_lo + f.bias
      x.hi = nxt_hi + f.bias
      x.lo2 += f.bias
      x.hi2 += f.bias
      return x.some
    return CLS.S.none

  type RangeChminChmaxAddRangeSum*[Num; INF: static[Num]; S, F, base, ST] = object
    st: ST

  proc Chmin*[CLS: RCCARS_Base](cls: typedesc[CLS], x: CLS.Num): CLS.F = return CLS.initF(-CLS.INF, x, CLS.Num(0))
  proc Chmax*[CLS: RCCARS_Base](cls: typedesc[CLS], x: CLS.Num): CLS.F = return CLS.initF(x, CLS.INF, CLS.Num(0))
  proc Add*[CLS: RCCARS_Base](cls: typedesc[CLS], x: CLS.Num): CLS.F = return CLS.initF(-CLS.INF, CLS.INF, x)
  proc Gen*[CLS: RCCARS_Base](cls: typedesc[CLS], x: CLS.Num, sz = 1):CLS.S = CLS.initS(x, sz)

  proc initRangeChminChmaxAddRangeSum*[Num](v: int or seq[Num], INF: static[Num] = int.high div 2): auto =
    type
      S = RCCARS_S[Num]
      F = RCCARS_F[Num]
      base = RCCARS_Base[Num, INF, S, F]
      ST = SegTreeBeatsType[base.S, base.F](op[base], e[base], mapping[base], composition[base], id[base])
    var
      st:ST 
    when v is seq[Num]:
      var v = collect(newSeq):
        for a in v:
          base.Gen(a)
    st.init(v)
    return RangeChminChmaxAddRangeSum[Num, INF, S, F, base, ST](st:st)
  proc chmin*[CLS: RangeChminChmaxAddRangeSum](self: var CLS, p:Slice[int], x: CLS.Num) =
    self.st.apply(p, CLS.base.Chmin(x))
  proc chmax*[CLS: RangeChminChmaxAddRangeSum](self: var CLS, p:Slice[int], x: CLS.Num) =
    self.st.apply(p, CLS.base.Chmax(x))
  proc add*[CLS: RangeChminChmaxAddRangeSum](self: var CLS, p:Slice[int], x: CLS.Num) =
    self.st.apply(p, CLS.base.Add(x))
  proc `[]`*[CLS: RangeChminChmaxAddRangeSum](self: var CLS, p:Slice[int]): CLS.Num =
    self.st.prod(p).sum
