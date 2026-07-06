# decimal_mpfr

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/decimal_mpfr

## 公開 API

    const mpfr_header* = "<mpfr.h>"
    proc mpfr_init2*(x: mpfr, prec: mpfr_prec_t) {.importc.}
    proc mpfr_clear*(x: mpfr) {.importc.}
    proc mpfr_free_cache*() {.importc.}
    proc mpfr_set_prec*(x: mpfr_t, prec: mpfr_prec_t) {.importc.}
    proc mpfr_get_emin*: mpfr_exp_t {.importc.}
    proc mpfr_get_emax*: mpfr_exp_t {.importc.}
    proc mpfr_set*(rop: mpfr_t, op: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
    proc mpfr_set_zero*(x: mpfr, sign: cint = 0) {.importc.}
    proc mpfr_swap*(x, y: mpfr_t) {.importc.}
    proc mpfr_set_si*(rop: mpfr_t, op: clong, rnd: mpfr_rnd_t): cint {.importc.}
    proc mpfr_set_ui*(rop: mpfr_t, op: culong, rnd: mpfr_rnd_t): cint {.importc.}
    proc mpfr_set_d*(rop: mpfr_t, op: cdouble, rnd: mpfr_rnd_t): cint {.importc.}
    proc mpfr_set_str*(rop: mpfr_t, s: cstring, base: cint, rnd: mpfr_rnd_t): cint {.importc.}
    proc mpfr_get_flt*(rop: mpfr_t, rnd: mpfr_rnd_t): cfloat {.importc.}
    proc mpfr_get_d*(rop: mpfr_t, rnd: mpfr_rnd_t): cdouble {.importc.}
    proc mpfr_get_str*(str: cstring, expptr: ptr mpfr_exp_t, base: cint, n: csize_t, op: mpfr_t, rnd: mpfr_rnd_t): cstring {.importc.}
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
    proc mpfr_cmp*(op1, op2: mpfr_t): cint {.importc.}
    proc mpfr_cmp_d*(op1: mpfr_t, op2: cdouble): cint {.importc.}
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
    proc mpfr_const_log2*(rop: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
    proc mpfr_const_euler*(rop: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
    proc mpfr_const_catalan*(rop: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
    proc mpfr_const_pi*(rop: mpfr_t, rnd: mpfr_rnd_t): cint {.importc.}
    proc mpfr_custom_get_size*(prec: mpfr_prec_t): csize_t {.importc.}
    proc mpfr_custom_init*(significand: pointer, prec: mpfr_prec_t) {.importc.}
    proc mpfr_custom_init_set*(x: mpfr_t, kind: mpfr_kind_t, exp: mpfr_exp_t, prec: mpfr_prec_t, significand: pointer) {.importc.}
    proc mpfr_custom_get_kind*(x: mpfr_t): cint {.importc.}
    proc mpfr_custom_get_significand*(x: mpfr_t): pointer {.importc.}
    proc mpfr_custom_get_exp*(x: mpfr_t): mpfr_exp_t {.importc.}
    proc mpfr_custom_move*(x: mpfr_t, new_position: pointer) {.importc.}
    proc set_precision*(prec_in_bits: int) = mpfr_precision = prec_in_bits
    proc set_digits*(n: int) = mpfr_digits = n
    proc init_val*(x: mpfr_t, v: float) =
    proc init_val*(x: mpfr_t, v: string) =
    proc is_init*(x: mpfr): bool = x.mpfr_prec != 0
    proc reset*(x: var mpfr) = x.mpfr_prec = 0
    proc is_notinit*(x: mpfr): bool = x.mpfr_prec == 0
    proc with_val*(x: mpfr, value: float = 0.0): mpfr = discard mpfr_set_d(x, value.cdouble, mpfr_rand)
    proc set*(x: var mpfr, y: mpfr) = discard mpfr_set(x, y, mpfr_rand)
    proc zero*(x: var mpfr) = mpfr_set_zero(x) # x=0
    proc swap*(x, y: mpfr) = mpfr_swap(x, y)
    proc `:=`*(x: var mpfr, y: mpfr) = discard mpfr_set(x, y, mpfr_rand)
    proc newMpfr*(): mpfr =
    proc `=`*(a:var mpfr, b:mpfr) =
    proc clone*(x: mpfr):mpfr =
    proc newMpfr*(value: string): mpfr = init_val(result, value)
    proc newMpfr*(value: float): mpfr = init_val(result, value)
    proc newMpfr*(x: mpfr): mpfr = result = x
    proc set_prec*(x: var mpfr, prec: int) = mpfr_set_prec(x, prec.mpfr_prec_t)
    proc get_exp_range*: (int, int) = (mpfr_get_emin().int, mpfr_get_emax().int)
    proc itom*(i: int): mpfr = result = newMpfr(); discard mpfr_set_si(result,i.clong, mpfr_rand)
    proc ftom*(f: float): mpfr = result = newMpfr(); discard mpfr_set_d(result, f.cdouble, mpfr_rand)
    proc stom*(s: string): mpfr = result = newMpfr(); discard mpfr_set_str( result, s.cstring, 10, mpfr_rand)
    converter toMpfr*(i:int):mpfr = i.itom
    converter toMpfr*(f:float):mpfr = f.ftom

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
