when not declared ATCODER_LONGDOUBLE_HPP:
  const ATCODER_LONGDOUBLE_HPP* = 1
  {.passL: "-lquadmath" .}

  {.emit:"""
  //typedef __float128 NF128;
  #include<quadmath.h>
  """.}
  # these probably don't work right
  #type float128* {.importc: "__float128", nodecl.} = clongdouble
  #type float128* {.importc: "NF128", nodecl.} = object
  type float128* {.importc: "__float128", nodecl.} = object
    hi, lo: uint64
  #type float128* {.importc: "__float128", nodecl.} = distinct clongdouble
  #type float128* {.importc: "__float128", nodecl.} = object

  proc getfloat128*(a:SomeNumber):float128 {.importcpp: "((long double)(#))", nodecl.}
  proc initfloat128*(a:float):float128 = getfloat128(a.cdouble)
  converter tofloat128*(a:int):float128 = getfloat128(a.clonglong)
  converter tofloat128*(a:float):float128 = getfloat128(a.cdouble)
#  converter tofloat128*(a:float128):float128 = a
  proc toCDouble*(a:float128):cdouble {.importcpp: "((double)(#))", nodecl.}
  #converter toFloat*(a:float128):float = toCDouble(a).float
  #converter toFloat64*(a:float128):float64 = toCDouble(a).float64
  #converter toFloat32*(a:float128):float32 = toCDouble(a).float32
  proc init*(T:typedesc[float128], a:SomeNumber):float128 = float128(a)
  
  proc `+` *[T:float128](a, b:T):T {.importcpp: "((#) + (@))", nodecl.}
  proc `-` *[T:float128](a, b:T):T {.importcpp: "((#) - (@))", nodecl.}
  proc `*` *[T:float128](a, b:T):T {.importcpp: "((#) * (@))", nodecl.}
  proc `/` *[T:float128](a, b:T):T {.importcpp: "((#) / (@))", nodecl.}
  proc `+=`*[T:float128](a:var T, b:T) {.importcpp: "((#) += (@))", nodecl.}
  proc `-=`*[T:float128](a:var T, b:T) {.importcpp: "((#) -= (@))", nodecl.}
  proc `*=`*[T:float128](a:var T, b:T) {.importcpp: "((#) *= (@))", nodecl.}
  proc `/=`*[T:float128](a:var T, b:T) {.importcpp: "((#) /= (@))", nodecl.}
  proc `==`*[T:float128](a, b:T):bool {.importcpp: "((#) == (@))", nodecl.}
  proc `<` *[T:float128](a, b:T):bool {.importcpp: "((#) < (@))", nodecl.}
  proc `<=`*[T:float128](a, b:T):bool {.importcpp: "((#) <= (@))", nodecl.}
  proc `>` *[T:float128](a, b:T):bool {.importcpp: "((#) > (@))", nodecl.}
  proc `>=`*[T:float128](a, b:T):bool {.importcpp: "((#) >= (@))", nodecl.}
  proc `-` *[T:float128](a:T):T {.importcpp: "(-(#))", nodecl.}
  proc getString*(a:float128, s:var cstring) {.header:"<string>", importcpp: "(@) = (char*)(std::to_string((long double)#).c_str())", nodecl.}
  proc `$`*[T:float128](a:T):string =
    var s:cstring
    getString(a, s)
    return $s
  proc `abs` *[T:float128](a:T):T {.header: "<quadmath.h>", importcpp: "fabsq((long double)#)", nodecl.}
  proc `sqrt`*[T:float128](a:T):T {.header: "<quadmath.h>", importcpp: "sqrtq(#)", nodecl.}
  proc `exp` *[T:float128](a:T):T {.header: "<quadmath.h>", importcpp: "expq(#)", nodecl.}
  proc `log` *[T:float128](a:T):T {.header: "<quadmath.h>", importcpp: "logq(#)", nodecl.}
  proc `logb`*[T:float128](b:SomeNumber, x:T):T {.header: "<quadmath.h>", importcpp: "logbq(((long double)#), (@))", nodecl.}
  proc `sin` *[T:float128](a:T):T {.header: "<quadmath.h>", importcpp: "sinq(#)", nodecl.}
  proc `cos` *[T:float128](a:T):T {.header: "<quadmath.h>", importcpp: "cosq(#)", nodecl.}
  proc `tan` *[T:float128](a:T):T {.header: "<quadmath.h>", importcpp: "tanq(#)", nodecl.}
  proc `arccos`*[T:float128](a:T):T {.header: "<quadmath.h>", importcpp: "acosq(#)", nodecl.}
  proc `arcsin`*[T:float128](a:T):T {.header: "<quadmath.h>", importcpp: "asinq(#)", nodecl.}
  proc `arctan`*[T:float128](a:T):T {.header: "<quadmath.h>", importcpp: "atanq(#)", nodecl.}
  proc `arctan2`*[T:float128](a, b:T):T {.header: "<quadmath.h>", importcpp: "atan2q(#, @)", nodecl.}
  proc `llround`*[T:float128](a:T):int {.header: "<quadmath.h>", importcpp: "llroundq(#)", nodecl.}
  proc `pow`*[T:float128](a:T, b:SomeNumber):T {.header: "<quadmath.h>", importcpp: "powq((#), (long double)(@))", nodecl.}
  proc inf*(self:typedesc[float128]):float128 {.header: "<limits>", importcpp: "std::numeric_limits<long double>::infinity()", nodecl.}
  
  proc machineEpsilonFloat128*():float128 =
    let one = float128(1)
    var eps = one
    var c = 0
    while not (one + eps == one):
      eps = eps / float128(2)
      c.inc
    echo "times: ", c
    return eps
