#[
  mpfr wrapper (GNU MPFR 4.1.0)
  https://www.mpfr.org
]#


#import math


#{.passL: "-lmpfr -lgmp".} # libs required

{.passL: "/usr/lib/x86_64-linux-gnu/libmpfr.so.6 -lgmp".} # libs required

const mpfr_header* = "<mpfr.h>"

type csize_t {.importc: "size_t", nodecl.} = cuint

type
  mpfr_rnd_t = enum
    MPFR_RNDNA = -1 # round to nearest, with ties away from zero (mpfr_round)

    MPFR_RNDN = 0   # round to nearest, with ties to even
    MPFR_RNDZ = 1   # round toward zero
    MPFR_RNDU = 2   # round toward +Inf
    MPFR_RNDD = 3   # round toward -Inf
    MPFR_RNDA = 4   # round away from zero
    MPFR_RNDF = 5   # faithful rounding

  mpfr_kind_t = enum
    MPFR_NAN_KIND = 0
    MPFR_INF_KIND = 1
    MPFR_ZERO_KIND = 2
    MPFR_REGULAR_KIND = 3

var
  mpfr_precision*: int = 1024 # mantissa
  #mpfr_digits* = 1000
  mpfr_digits* = 5
  mpfr_rand* = MPFR_RNDZ      # default round method

type
  mpfr_prec_t = clong
  mpfr_sign_t = cint
  mpfr_exp_t = clong
  mp_limb_t = culong

  mpfr* = object # {.header : mpfr_header, importc: "__mpfr_struct".} =  object
    mpfr_prec: mpfr_prec_t
    mpfr_sign: mpfr_sign_t
    mpfr_exp: mpfr_exp_t
    mpfr_d: mp_limb_t

  mpfr_t = mpfr
  Decimal* = mpfr


# https://www.mpfr.org/mpfr-current/mpfr.html#MPFR-Basics

# init
proc mpfr_init2*(x: mpfr, prec: mpfr_prec_t) {.importc.}
proc mpfr_clear*(x: mpfr) {.importc.}
proc mpfr_free_cache*() {.importc.}
proc mpfr_set_prec*(x: mpfr_t, prec: mpfr_prec_t) {.importc.}

# exp
proc mpfr_get_emin*: mpfr_exp_t {.importc.}
proc mpfr_get_emax*: mpfr_exp_t {.importc.}

# assignment
proc mpfr_set*(rop: mpfr_t, op: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_set_zero*(x: mpfr, sign: cint = 0) {.importc.}
proc mpfr_swap*(x, y: mpfr_t) {.importc.}
proc mpfr_set_si*(rop: mpfr_t, op: clong, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_set_ui*(rop: mpfr_t, op: culong, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_set_d*(rop: mpfr_t, op: cdouble, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_set_str*(rop: mpfr_t, s: cstring, base: cint,
    rnd: mpfr_rnd_t): cint {.importc.}

# conversion
proc mpfr_get_flt*(rop: mpfr_t, rnd: mpfr_rnd_t): cfloat {.importc.}
proc mpfr_get_d*(rop: mpfr_t, rnd: mpfr_rnd_t): cdouble {.importc.}
proc mpfr_get_str*(str: cstring, expptr: ptr mpfr_exp_t, base: cint, n: csize_t,
    op: mpfr_t, rnd: mpfr_rnd_t): cstring {.importc.}

# arithmetics
proc mpfr_add*(rop, op1, op2: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_sub*(rop, op1, op2: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_neg*(rop, op1: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_mul*(rop, op1, op2: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_div*(rop, op1, op2: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_add_d*(rop, op1: mpfr_t, op2: cdouble, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_sub_d*(rop, op1: mpfr_t, op2: cdouble, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_mul_d*(rop, op1: mpfr_t, op2: cdouble, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_div_d*(rop, op1: mpfr_t, op2: cdouble, rnd: mpfr_rnd_t): cint {.importc.}

proc mpfr_signbit*(rop: mpfr_t): cint {.importc.}

# comparision
proc mpfr_cmp*(op1, op2: mpfr_t): cint {.importc.}
proc mpfr_cmp_d*(op1: mpfr_t, op2: cdouble): cint {.importc.}

# funcs
proc mpfr_abs*(rop, op: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_sqrt*(rop, op: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_rootn_ui*(rop, op: mpfr_t, n: culong, rnd: mpfr_rnd_t): cint {.importc.} # x ^ y
proc mpfr_fac_ui*(rop: mpfr_t, op: culong, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_atan2*(rop, y, x: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_pow*(rop, x, y: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_sin*(rop, x: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_cos*(rop, x: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_sinh*(rop, x: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_cosh*(rop, x: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_asin*(rop, x: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_acos*(rop, x: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_tan*(rop, x: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_log*(rop, x: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_exp*(rop, x: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}

# constants
proc mpfr_const_log2*(rop: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_const_euler*(rop: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_const_catalan*(rop: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
proc mpfr_const_pi*(rop: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}

# custom interface
proc mpfr_custom_get_size*(prec: mpfr_prec_t): csize_t {.importc.}
proc mpfr_custom_init*(significand: pointer, prec: mpfr_prec_t) {.importc.}
proc mpfr_custom_init_set*(x: mpfr_t, kind: mpfr_kind_t, exp: mpfr_exp_t,
    prec: mpfr_prec_t, significand: pointer) {.importc.}
proc mpfr_custom_get_kind*(x: mpfr_t): cint {.importc.}
proc mpfr_custom_get_significand*(x: mpfr_t): pointer {.importc.}
proc mpfr_custom_get_exp*(x: mpfr_t): mpfr_exp_t {.importc.}
proc mpfr_custom_move*(x: mpfr_t, new_position: pointer) {.importc.}

#[
  nim wrapper
]#

proc set_precision*(prec_in_bits: int) = mpfr_precision = prec_in_bits
proc set_digits*(n: int) = mpfr_digits = n

proc init_val*(x: mpfr_t, v: float) =
  mpfr_init2(x, mpfr_precision)
  discard mpfr_set_d(x, v.cdouble, mpfr_rand)
proc init_val*(x: mpfr_t, v: string) =
  mpfr_init2(x, mpfr_precision)
  discard mpfr_set_str(x, v.cstring, 10, mpfr_rand)

proc is_init*(x: mpfr): bool = x.mpfr_prec != 0
proc reset*(x: var mpfr) = x.mpfr_prec = 0
proc is_notinit*(x: mpfr): bool = x.mpfr_prec == 0

proc with_val*(x: mpfr, value: float = 0.0): mpfr = discard mpfr_set_d(x,
    value.cdouble, mpfr_rand)
proc set*(x: var mpfr, y: mpfr) = discard mpfr_set(x, y, mpfr_rand)
proc zero*(x: var mpfr) = mpfr_set_zero(x) # x=0
proc swap*(x, y: mpfr) = mpfr_swap(x, y)
proc `:=`*(x: var mpfr, y: mpfr) = discard mpfr_set(x, y, mpfr_rand)

#proc newMpfr*(): mpfr = init_val(result, 0.0)
proc newMpfr*(): mpfr =
  result.init_val("0")

#proc `=destroy`(x: var mpfr) =
#  if x.is_init():
#    mpfr_clear(x)
#  else: discard # raise "attempt destroy not init!"

# Nim 1.0.6ではコピーhookできない
#proc `=copy`*(a: var mpfr, b: mpfr) =
#  if a.mpfr_d == b.mpfr_d or b.is_notinit(): return # do nothing if (a==b or b.not_init)
#  if a.is_notinit(): a = newMpfr()
#  a.set b
# 代わりにコピーするときはcloneをつけよう
proc `=`*(a:var mpfr, b:mpfr) =
  a = newMpfr()
  a.set b
proc clone*(x: mpfr):mpfr =
  result = newMpfr()
  result.set x

proc newMpfr*(value: string): mpfr = init_val(result, value)
proc newMpfr*(value: float): mpfr = init_val(result, value)
proc newMpfr*(x: mpfr): mpfr = result = x

proc set_prec*(x: var mpfr, prec: int) = mpfr_set_prec(x, prec.mpfr_prec_t)

proc get_exp_range*: (int, int) = (mpfr_get_emin().int, mpfr_get_emax().int)

proc itom*(i: int): mpfr = result = newMpfr(); discard mpfr_set_si(result,i.clong, mpfr_rand)
proc ftom*(f: float): mpfr = result = newMpfr(); discard mpfr_set_d(result,
    f.cdouble, mpfr_rand)
proc stom*(s: string): mpfr = result = newMpfr(); discard mpfr_set_str(
    result, s.cstring, 10, mpfr_rand)

converter toMpfr*(i:int):mpfr = i.itom
converter toMpfr*(f:float):mpfr = f.ftom
converter toMpfr*(s:string):mpfr = s.stom
#converter mtof*(x: mpfr): float = mpfr_get_d(x, mpfr_rand).float
#converter mtof32*(x: mpfr): float32 = mpfr_get_flt(x, mpfr_rand).float32

proc toStr*(x: mpfr, d:int):string =
  if x.is_init():
    var
      str = newString(d + 1000).cstring
      exp: mpfr_exp_t

    discard mpfr_get_str(str, exp.unsafeAddr, 10.cint,
        d.csize_t, x, mpfr_rand)
    for i, c in str: result.add(c)
    result.insert("0.", 0)
    result &= "e" & $exp
  else:
    result = "**not init**"

proc `$`*(x: mpfr): string =
  toStr(x, mpfr_digits)

proc dump*(x: mpfr) =
  echo "prec:", x.mpfr_prec, ", sign:", x.mpfr_sign, ", exp:", x.mpfr_exp,
      ", limb:", x.mpfr_d

# custom
proc cinit*(x: var mpfr) =
  let p = alloc0(mpfr_custom_get_size(mpfr_precision))
  mpfr_custom_init(p, mpfr_precision)
  mpfr_custom_init_set(x, MPFR_ZERO_KIND, 0, mpfr_precision, p)

proc cfree*(x: var mpfr) =
  x.reset # so it's not destroyed
  dealloc(mpfr_custom_get_significand(x))


# arithmetics
proc `+`*(x, y: mpfr): mpfr = result = newMpfr(); discard mpfr_add(result, x, y, mpfr_rand)
proc `-`*(x, y: mpfr): mpfr = result = newMpfr(); discard mpfr_sub(result, x, y, mpfr_rand)
proc `-`*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_neg(result, x, mpfr_rand)
proc `*`*(x, y: mpfr): mpfr = result = newMpfr(); discard mpfr_mul(result, x, y, mpfr_rand)
proc `/`*(x, y: mpfr): mpfr = result = newMpfr(); discard mpfr_div(result, x, y, mpfr_rand)

proc `+`*(x: mpfr, y: float): mpfr = result = newMpfr(); discard mpfr_add_d(
    result, x, y, mpfr_rand)
proc `-`*(x: mpfr, y: float): mpfr = result = newMpfr(); discard mpfr_sub_d(
    result, x, y, mpfr_rand)
proc `*`*(x: mpfr, y: float): mpfr = result = newMpfr(); discard mpfr_mul_d(
    result, x, y, mpfr_rand)
proc `/`*(x: mpfr, y: float): mpfr = result = newMpfr(); discard mpfr_div_d(
    result, x, y, mpfr_rand)

proc `+`*(x: mpfr, y: string): mpfr = result = newMpfr(); discard mpfr_add(
    result, x, y.stom, mpfr_rand)
proc `-`*(x: mpfr, y: string): mpfr = result = newMpfr(); discard mpfr_sub(
    result, x, y.stom, mpfr_rand)
proc `*`*(x: mpfr, y: string): mpfr = result = newMpfr(); discard mpfr_mul(
    result, x, y.stom, mpfr_rand)
proc `/`*(x: mpfr, y: string): mpfr = result = newMpfr(); discard mpfr_div(
    result, x, y.stom, mpfr_rand)

proc `+=`*(x: var mpfr, y: mpfr) = discard mpfr_add(x, x, y, mpfr_rand)
proc `-=`*(x: var mpfr, y: mpfr) = discard mpfr_sub(x, x, y, mpfr_rand)
proc `*=`*(x: var mpfr, y: mpfr) = discard mpfr_mul(x, x, y, mpfr_rand)
proc `/=`*(x: var mpfr, y: mpfr) = discard mpfr_div(x, x, y, mpfr_rand)

proc `+=`*(x: var mpfr, y: float) = discard mpfr_add_d(x, x, y, mpfr_rand)
proc `-=`*(x: var mpfr, y: float) = discard mpfr_sub_d(x, x, y, mpfr_rand)
proc `*=`*(x: var mpfr, y: float) = discard mpfr_mul_d(x, x, y, mpfr_rand)
proc `/=`*(x: var mpfr, y: float) = discard mpfr_div_d(x, x, y, mpfr_rand)

proc `+=`*(x: var mpfr, y: string) = discard mpfr_add(x, x, y.stom, mpfr_rand)
proc `-=`*(x: var mpfr, y: string) = discard mpfr_sub(x, x, y.stom, mpfr_rand)
proc `*=`*(x: var mpfr, y: string) = discard mpfr_mul(x, x, y.stom, mpfr_rand)
proc `/=`*(x: var mpfr, y: string) = discard mpfr_div(x, x, y.stom, mpfr_rand)

# comparision
proc `==`*(x, y: mpfr): bool = mpfr_cmp(x, y) == 0
proc `!=`*(x, y: mpfr): bool = mpfr_cmp(x, y) != 0
proc `>=`*(x, y: mpfr): bool = mpfr_cmp(x, y) >= 0
proc `<=`*(x, y: mpfr): bool = mpfr_cmp(x, y) <= 0
proc `>`*(x, y: mpfr): bool = mpfr_cmp(x, y) > 0
proc `<`*(x, y: mpfr): bool = mpfr_cmp(x, y) < 0
proc cmp*(x, y: mpfr): int = mpfr_cmp(x, y).int

proc `==`*(x: mpfr, y: float): bool = mpfr_cmp_d(x, y) == 0
proc `!=`*(x: mpfr, y: float): bool = mpfr_cmp_d(x, y) != 0
proc `>=`*(x: mpfr, y: float): bool = mpfr_cmp_d(x, y) >= 0
proc `<=`*(x: mpfr, y: float): bool = mpfr_cmp_d(x, y) <= 0
proc `>`*(x: mpfr, y: float): bool = mpfr_cmp_d(x, y) > 0
proc `<`*(x: mpfr, y: float): bool = mpfr_cmp_d(x, y) < 0

proc `==`*(x: mpfr, y: string): bool = mpfr_cmp(x, y.stom) == 0
proc `!=`*(x: mpfr, y: string): bool = mpfr_cmp(x, y.stom) != 0
proc `>=`*(x: mpfr, y: string): bool = mpfr_cmp(x, y.stom) >= 0
proc `<=`*(x: mpfr, y: string): bool = mpfr_cmp(x, y.stom) <= 0
proc `>`*(x: mpfr, y: string): bool = mpfr_cmp(x, y.stom) > 0
proc `<`*(x: mpfr, y: string): bool = mpfr_cmp(x, y.stom) < 0

# funcs
proc `!`*(n: uint): mpfr = result = newMpfr(); discard mpfr_fac_ui(result,
    n.culong, mpfr_rand)
proc sqrt*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_sqrt(result, x, mpfr_rand)
proc abs*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_abs(result, x, mpfr_rand)
proc root*(x: mpfr, n: int): mpfr = result = newMpfr(); discard mpfr_rootn_ui(
    result, x, n.culong, mpfr_rand)
proc arctan2*(y, x: mpfr): mpfr = result = newMpfr(); discard mpfr_atan2(result,
    x, y, mpfr_rand)
proc pow*(x, y: mpfr): mpfr = result = newMpfr(); discard mpfr_pow(result, x, y, mpfr_rand)
proc sin*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_sin(result, x, mpfr_rand)
proc sinh*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_sinh(result, x, mpfr_rand)
proc arcsin*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_asin(result, x, mpfr_rand)
proc cos*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_cos(result, x, mpfr_rand)
proc cosh*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_cosh(result, x, mpfr_rand)
proc arccos*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_acos(result, x, mpfr_rand)
proc tan*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_tan(result, x, mpfr_rand)
proc log*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_log(result, x, mpfr_rand)
proc exp*(x: mpfr): mpfr = result = newMpfr(); discard mpfr_exp(result, x, mpfr_rand)
proc sign*(x: mpfr): cint = mpfr_signbit(x)

# consts
proc log2*(): mpfr = result = newMpfr(); discard mpfr_const_log2(result, mpfr_rand)
#proc e*(): mpfr = result = newMpfr(); discard mpfr_const_euler(result, mpfr_rand)
proc e*(): mpfr = exp(1.itom)
proc catalan*(): mpfr = result = newMpfr(); discard mpfr_const_catalan(result, mpfr_rand)
proc pi*(): mpfr = result = newMpfr(); discard mpfr_const_pi(result, mpfr_rand)

proc half*():mpfr = 1.itom / 2.itom

proc machine_epsilon*(): mpfr =
  var
    l = 0.itom
    r = 1.itom
  let
    one = 1.itom
    half = half()
  while l < r:
    let m = (l + r) * half
    let prev_d = r - l
    if one + m == one:
      l = m
    else:
      r = m
    if prev_d == r - l: break
  return r

## complex
type cmpfr* = object # complex mpfr
  re*, im*: mpfr

proc newCmpfr*(): cmpfr = cmpfr(re: newMpfr(), im: newMpfr())
proc newCmpfr*(re, im: mpfr): cmpfr = result = cmpfr(re: re, im: im)
proc newCmpfr*(z: cmpfr): cmpfr = newCmpfr(z.re, z.im)

proc dump*(z: cmpfr) =
  z.re.dump()
  z.im.dump()

#proc arg*(z: cmpfr): mpfr = arctan2(z.im, z.re)
proc arg*(z: cmpfr): mpfr = arctan2(z.re, z.im)
proc sqmag*(z: cmpfr): mpfr = z.re*z.re + z.im*z.im
proc abs*(z: cmpfr): mpfr = z.sqmag.sqrt

proc `+`*(x, y: cmpfr): cmpfr = cmpfr(re: x.re + y.re, im: x.im + y.im)
proc `-`*(x, y: cmpfr): cmpfr = cmpfr(re: x.re - y.re, im: x.im - y.im)
proc `-`*(x: cmpfr): cmpfr = cmpfr(re: -x.re, im: -x.im)
proc `*`*(x, y: cmpfr): cmpfr = cmpfr(re: x.re*y.re - x.im*y.im, im: x.re*y.im + x.im*y.re)
proc `/`*(x, y: cmpfr): cmpfr =
  let d = (y.re*y.re) + (y.im*y.im)
  result.re = (x.re*y.re)+(x.im*y.im)
  result.re/=d
  result.im = (x.im*y.re)-(x.re*y.im)
  result.im/=d

proc `+`*(x: cmpfr, y: float): cmpfr = cmpfr(re: x.re + y, im: x.im + y)
proc `-`*(x: cmpfr, y: float): cmpfr = cmpfr(re: x.re - y, im: x.im - y)
proc `*`*(x: cmpfr, y: float): cmpfr = cmpfr(re: x.re * y, im: x.im * y)
proc `/`*(x: cmpfr, y: float): cmpfr = cmpfr(re: x.re / y, im: x.im / y)

proc `+=`*(x: var cmpfr, y: cmpfr) = x = x+y
proc `-=`*(x: var cmpfr, y: cmpfr) = x = x-y
proc `*=`*(x: var cmpfr, y: cmpfr) = x = x*y
proc `/=`*(x: var cmpfr, y: cmpfr) = x = x/y

proc `+=`*(x: var cmpfr, y: float) = x.re+=y; x.im+=y
proc `-=`*(x: var cmpfr, y: float) = x.re-=y; x.im-=y
proc `*=`*(x: var cmpfr, y: float) = x.re*=y; x.im*=y
proc `/=`*(x: var cmpfr, y: float) = x.re/=y; x.im/=y

proc sqr*(z: cmpfr): cmpfr = z*z
proc pow3*(z: cmpfr): cmpfr = z*z*z
proc pow4*(z: cmpfr): cmpfr = z*z*z*z
proc pow5*(z: cmpfr): cmpfr = z*z*z*z*z
proc pown*(z: cmpfr, n: int): cmpfr =
  result = z
  for i in 1..n: result*=z

proc pow*(z: cmpfr, n: int): cmpfr =
  let
    rn = z.abs().pow(n.itom)
    na = z.arg() * n.itom
  cmpfr(re: rn * cos(na), im: rn * sin(na))

proc pow*(s, z: cmpfr): cmpfr = # s^z
  let
    c = z.re
    d = z.im
    m = pow(s.sqmag, c/2.itom) * exp(-d * s.arg)
    half = half()
    theta = c * s.arg + half * d * log(s.sqmag)
  result = cmpfr(re: m * cos(theta), im: m * sin(theta))

proc sqrt*(z: cmpfr): cmpfr =
  let a = z.abs()
  let half = half()
  cmpfr(re: sqrt((a+z.re) * half), im: sqrt((a-z.re) * half) * sign(z.im).float)

proc log*(z: cmpfr): cmpfr = cmpfr(re: z.abs.log, im: z.arg)
proc exp*(z: cmpfr): cmpfr = cmpfr(re: e(), im: 0.itom).pow(z)

proc cosh*(z: cmpfr): cmpfr = cmpfr(re: cosh(z.re) * cos(z.im), im: sinh(z.re) * sin(z.im))
proc sinh*(z: cmpfr): cmpfr = cmpfr(re: sinh(z.re) * cos(z.im), im: cosh(z.re) * sin(z.im))
proc sin*(z: cmpfr): cmpfr = cmpfr(re: sin(z.re) * cosh(z.im), im: cos(z.re) *
    sinh(z.im))
proc cos*(z: cmpfr): cmpfr = cmpfr(re: cos(z.re) * cosh(z.im), im: -sin(z.re) *
    sinh(z.im))
proc tan*(z: cmpfr): cmpfr = z.sin()/z.cos()

proc arcsinh*(z: cmpfr): cmpfr =
  let t = cmpfr(re: (z.re-z.im) * (z.re+z.im)+1.itom, im: 2.itom*z.re*z.im).sqrt
  (t + z).log

proc arcsin*(z: cmpfr): cmpfr =
  let t = cmpfr(re: -z.im, im: z.re).arcsinh
  cmpfr(re: t.im, im: -t.re)

# 小数使ってるから誤差ある問題はとりあえず放置
proc arccos*(z: cmpfr): cmpfr =
  let
    t = z.arcsin()
    #pi_2 = 1.7514
    pi_2 = pi() / 2.itom
  cmpfr(re: pi_2 - t.re, im: -t.im)

proc arctan*(z: cmpfr): cmpfr =
  let 
    half = half()
    quarter = half * half
  cmpfr(
    re: half * arctan2(2.itom*z.re, 1.itom - z.re*z.re - z.im*z.im),
    im: quarter * log((z.re*z.re + (z.im+1.itom)*(z.im+1.itom)) / (z.re*z.re + (
        z.im-1.itom)*(z.im-1.itom)))
  )

proc calcPi*[Real]():Real =
  var
    a = Real(1)
    b = Real(1) / sqrt(Real(2))
    c = Real(1) / Real(4)
    d = Real(1)

  var prev = Decimal(0)

  while true:
    let s = a + b
    let p = s * s / (Real(4) * c)
    if p == prev: break
    prev = p
    var
      na = (a + b) / Real(2)
      nb = sqrt(a * b)
      nc = c - d * (a - na) * (a - na)
      nd = Real(2) * d
    #swap(na, a)
    #swap(nb, b)
    #swap(nc, c)
    #swap(nd, d)
    a = na.move
    b = nb.move
    c = nc.move
    d = nd.move
  return prev

