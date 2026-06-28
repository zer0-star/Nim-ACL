when not declared ATCODER_DECIMAL_GMP_HPP:
  const ATCODER_DECIMAL_GMP_HPP* = 1
  import gmp

  const DEFAULT_DECIMAL_PREC = 200

  type Decimal* = ref mpf_t
  
  proc setPrec*(n:int) =
    mpf_set_default_prec(n.culong)

  setPrec(DEFAULT_DECIMAL_PREC)
  
  proc finalizeDecimal*(z: Decimal) =
    # Finalizer - release the memory allocated to the mpf.
    mpf_clear(z[])
  
  proc init*(z:var Decimal, prec = -1) =
    new(z, finalizeDecimal)
    if prec == -1:
      mpf_init(z[])
    else:
      mpf_init2(z[], prec.culong)
  proc clone*(x: Decimal):Decimal =
    result.init
    mpf_set(result[], x[])

  proc newDecimal*(a:float, prec = -1):Decimal =
    result.init
    mpf_set_d(result[], a)

  proc `=copy`*(a: var Decimal, b: Decimal) =
    #if a.mpfr_d == b.mpfr_d or b.is_notinit(): return # do nothing if (a==b or b.not_init)
    if a.addr == b.unsafeAddr: return # do nothing if (a==b or b.not_init)
    a = b.clone()

  proc `-`*(a: Decimal):Decimal =
    result.init
    mpf_neg(result[], a[])

  proc `+=`*(a: var Decimal, b:Decimal):Decimal {.discardable.} =
    result = a
    mpf_add(result[], a[], b[])

  proc `-=`*(a: var Decimal, b:Decimal):Decimal {.discardable.} =
    result = a
    mpf_sub(result[], a[], b[])

  proc `*=`*(a: var Decimal, b:Decimal):Decimal {.discardable.} =
    result = a
    mpf_mul(result[], a[], b[])

  proc `/=`*(a: var Decimal, b:Decimal):Decimal {.discardable.} =
    result = a
    mpf_div(result[], a[], b[])

  proc `+`*(a, b:Decimal):Decimal =
    result.init
    mpf_add(result[], a[], b[])

  proc `-`*(a, b:Decimal):Decimal =
    result.init
    mpf_sub(result[], a[], b[])

  proc `*`*(a, b:Decimal):Decimal =
    result.init
    mpf_mul(result[], a[], b[])

  proc `/`*(a, b:Decimal):Decimal =
    result.init
    mpf_div(result[], a[], b[])

  proc `<`*(a, b:Decimal):bool =
    let t = mpf_cmp(a[], b[])
    return t < 0
  proc `>`*(a, b:Decimal):bool =
    let t = mpf_cmp(a[], b[])
    return t > 0

  proc `<=`*(a, b:Decimal):bool =
    let t = mpf_cmp(a[], b[])
    return t <= 0
  proc `>=`*(a, b:Decimal):bool =
    let t = mpf_cmp(a[], b[])
    return t >= 0

  proc `==`*(a, b:Decimal):bool =
    let t = mpf_cmp(a[], b[])
    return t == 0

  proc `$`*(a:Decimal):string =
    $(mpf_get_d(a[]))

  converter toDecimal*(x:int):Decimal =
    result.init
    mpf_set_si(result[], x)
  converter toDecimal*(x:float):Decimal =
    result.init
    mpf_set_d(result[], x)

  proc sqrt*(a:Decimal):Decimal =
    result.init
    mpf_sqrt(result[], a[])
  proc rem*(a, b:Decimal):Decimal =
    var q:Decimal
    q.init
    mpf_floor(q[], (a / b)[])
    return a - q * b
  proc `^`*(a:Decimal, k:int):Decimal =
    result.init
    mpf_pow_ui(result[], a[], k.culong)
  proc floor*(a:Decimal):Decimal =
    result.init
    mpf_floor(result[], a[])

  proc machine_epsilon*(): Decimal =
    var
      l = Decimal(0)
      r = Decimal(1)
      one = Decimal(1)
    while l < r:
      let m = (l + r) / Decimal(2)
      let prev_d = r - l
      if one + m == one:
        l = m
      else:
        r = m
      if prev_d == r - l: break
    return r
