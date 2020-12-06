when not defined ATCODER_COMBINATION_HPP:
  const ATCODER_COMBINATION_HPP* = 1
  import atcoder/element_concepts

  type Combination*[T] = object
    fact_a, rfact_a: seq[T]

  type CombinationC* = concept x
    x is typedesc[FieldElem] or x is var Combination

  proc enhance[T:FieldElem](cmb: var Combination[T], k:int):auto =
    if k >= cmb.fact_a.len:
      if cmb.fact_a.len == 0:
        cmb.fact_a = @[T(1)]
        cmb.rfact_a = @[T(1)]
      let sz_old = cmb.fact_a.len - 1
      let sz = max(sz_old * 2, k)
      cmb.fact_a.setlen(sz + 1)
      cmb.rfact_a.setlen(sz + 1)
      for i in sz_old + 1..sz: cmb.fact_a[i] = cmb.fact_a[i-1] * T(i)
      cmb.rfact_a[sz] = T(1) / cmb.fact_a[sz]
      for i in countdown(sz - 1, sz_old + 1): cmb.rfact_a[i] = cmb.rfact_a[i + 1] * T(i + 1)
    return cmb.addr

  proc enhance(T:typedesc[FieldElem], k:int):auto {.discardable.} =
    var cmb{.global.} = Combination[T]()
    return cmb.enhance(k)

  template zero*(T:typedesc[FieldElem]):T = T(0)
  template zero*[T:FieldElem](cmb:Combination[T]):T = T(0)
  
  template fact*(T:CombinationC, k:int):auto = T.enhance(k)[].fact_a[k]
  template rfact*(T:CombinationC, k:int):auto = T.enhance(k)[].rfact_a[k]
  template inv*(T:CombinationC, k:int):auto = T.fact(k - 1) * T.rfact(k)

  template resetCombination*(T:typedesc[FieldElem] or var Combination) =
    var p = T.enhance(-1)
    p[].fact_a.setLen(0)
    p[].rfact_a.setLen(0)

  template P*(T:CombinationC, n,r:int):auto =
    if r < 0 or n < r: T.zero()
    else: T.fact(n) * T.rfact(n - r)
  template C*(T:CombinationC, n,r:int):auto =
    if r < 0 or n < r: T.zero()
    else: T.fact(n) * T.rfact(r) * T.rfact(n - r)
  template H*(T:CombinationC, n,r:int):auto =
    if n < 0 or r < 0: T.zero()
    elif r == 0: T.zero() + 1
    else: T.C(n + r - 1, r)
  template P_large*(T:CombinationC, n,r:int):auto =
    if r < 0 or n < r: T.zero()
    else:
      var a = T(1)
      for i in 0..<r:a *= n - i
      a
  template C_large_impl*(T:CombinationC, n,r:int):auto =
    if r < 0 or n < r: T.zero()
    else: T.P_large(n, r) * T.rfact(r)
  template C_large*(T:CombinationC, n,r:int):auto =
    if n >= 0:
      T.C_large_impl(n, r)
    else:
      var N = -n
      var a = T.C_large_impl(N + r - 1, N - 1)
      if r mod 2 != 0: a *= -1
      a
  template H_large*(T:CombinationC, n,r:int):auto =
    if n < 0 or r < 0: T.zero()
    elif r == 0: T.zero() + 1
    else: T.C_large(n + r - 1, r)
