# combination {{{
when not declared ATCODER_COMBINATION_HPP:
  const ATCODER_COMBINATION_HPP* = 1
  import atcoder/extra/math/element_concepts

  type Combination*[T] = object
    fact_a, rfact_a: seq[T]
  
  type CombinationC* = concept x
    x is typedesc[FieldElem] or x is var Combination
  
  proc getVal*[T:FieldElem](cmb: var Combination[T], t:static[int], k:int):auto {.discardable.} =
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
    when t == 0: return cmb.fact_a[k]
    elif t == 1: return cmb.rfact_a[k]
    elif t == 2: # reset
      cmb.fact_a.setLen(0)
      cmb.rfact_a.setLen(0)
      return T(0)
  template resetCombination*(T:typedesc[FieldElem] or var Combination) = T.getVal(2, 0)
  
  proc getVal*(T:typedesc[FieldElem], t:static[int], k:int):auto {.discardable.} =
    var cmb{.global.} = Combination[T]()
    return cmb.getVal(t, k)
  
  template zero*(T:typedesc[FieldElem]):T = T(0)
  template zero*[T](cmb:Combination[T]):T = T(0)
  
  template fact*(T:CombinationC, k:int):auto = T.getVal(0, k)
  template rfact*(T:CombinationC, k:int):auto = T.getVal(1, k)
  template inv*(T:CombinationC, k:int):auto = T.fact_a(k - 1) * T.rfact(k)
  
  template P*(T:CombinationC, n,r:int):auto =
    if r < 0 or n < r: T.zero()
    else: T.fact(n) * T.rfact(n - r)
  template C*(T:CombinationC, n,r:int):auto =
    if r < 0 or n < r: T(0)
    else: T.fact(n) * T.rfact(r) * T.rfact(n - r)
  template H*(T:CombinationC, n,r:int):auto =
    if n < 0 or r < 0: T(0)
    elif r == 0: T(1)
    else: T.C(n + r - 1, r)
  # }}}
