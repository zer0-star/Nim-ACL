---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _isVerificationFailed: false
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.9.6/x64/lib/python3.9/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "# LongDouble {{{\nwhen not declared ATCODER_LONGDOUBLE_HPP:\n  const ATCODER_LONGDOUBLE_HPP*\
    \ = 1\n  type LongDouble* {.importcpp: \"long double\", nodecl .} = object\n \
    \   discard\n  \n  proc getLongDouble*(a:SomeNumber):LongDouble {.importcpp: \"\
    (long double)(#)\", nodecl.}\n  proc initLongDouble*(a:float):LongDouble = getLongDouble(a.cdouble)\n\
    \  converter toLongDouble*(a:int):LongDouble = getLongDouble(a.cint)\n  converter\
    \ toLongDouble*(a:float):LongDouble = getLongDouble(a.cdouble)\n#  converter toLongDouble*(a:LongDouble):LongDouble\
    \ = a\n  proc toCDouble*(a:LongDouble):cdouble {.importcpp: \"(double)(#)\", nodecl.}\n\
    \  converter toFloat*(a:LongDouble):float = toCDouble(a).float\n  converter toFloat64*(a:LongDouble):float64\
    \ = toCDouble(a).float64\n  converter toFloat32*(a:LongDouble):float32 = toCDouble(a).float32\n\
    \  proc init*(T:typedesc[LongDouble], a:SomeNumber):LongDouble = LongDouble(a)\n\
    \  \n  proc `+`*(a, b:LongDouble):LongDouble {.importcpp: \"(#) + (@)\", nodecl.}\n\
    \  proc `-`*(a, b:LongDouble):LongDouble {.importcpp: \"(#) - (@)\", nodecl.}\n\
    \  proc `*`*(a, b:LongDouble):LongDouble {.importcpp: \"(#) * (@)\", nodecl.}\n\
    \  proc `/`*(a, b:LongDouble):LongDouble {.importcpp: \"(#) / (@)\", nodecl.}\n\
    \  proc `+=`*(a:var LongDouble, b:LongDouble) {.importcpp: \"(#) += (@)\", nodecl.}\n\
    \  proc `-=`*(a:var LongDouble, b:LongDouble) {.importcpp: \"(#) -= (@)\", nodecl.}\n\
    \  proc `*=`*(a:var LongDouble, b:LongDouble) {.importcpp: \"(#) *= (@)\", nodecl.}\n\
    \  proc `/=`*(a:var LongDouble, b:LongDouble) {.importcpp: \"(#) /= (@)\", nodecl.}\n\
    \  proc `<`*(a, b:LongDouble):bool {.importcpp: \"(#) < (@)\", nodecl.}\n  proc\
    \ `<=`*(a, b:LongDouble):bool {.importcpp: \"(#) <= (@)\", nodecl.}\n  proc `>`*(a,\
    \ b:LongDouble):bool {.importcpp: \"(#) > (@)\", nodecl.}\n  proc `>=`*(a, b:LongDouble):bool\
    \ {.importcpp: \"(#) >= (@)\", nodecl.}\n  proc `-`*(a:LongDouble):LongDouble\
    \ {.importcpp: \"-(#)\", nodecl.}\n  proc getString*(a:LongDouble, s:var cstring)\
    \ {.header:\"<string>\", importcpp: \"(@) = std::to_string(#).c_str()\", nodecl.}\n\
    \  proc `$`*(a:LongDouble):string =\n    var s:cstring\n    getString(a, s)\n\
    \    return $s\n  proc `abs`*(a:LongDouble):LongDouble {.header: \"<cmath>\",\
    \ importcpp: \"abs(#)\", nodecl.}\n  proc `sqrt`*(a:LongDouble):LongDouble {.header:\
    \ \"<cmath>\", importcpp: \"sqrtl(#)\", nodecl.}\n  proc `exp`*(a:LongDouble):LongDouble\
    \ {.header: \"<cmath>\", importcpp: \"expl(#)\", nodecl.}\n  proc `sin`*(a:LongDouble):LongDouble\
    \ {.header: \"<cmath>\", importcpp: \"sinl(#)\", nodecl.}\n  proc `cos`*(a:LongDouble):LongDouble\
    \ {.header: \"<cmath>\", importcpp: \"cosl(#)\", nodecl.}\n  proc `acos`*(a:LongDouble):LongDouble\
    \ {.header: \"<cmath>\", importcpp: \"acosl(#)\", nodecl.}\n  proc `llround`*(a:LongDouble):int\
    \ {.header: \"<cmath>\", importcpp: \"llround(#)\", nodecl.}\n  proc `pow`*(a:LongDouble,\
    \ b:SomeNumber):LongDouble {.header: \"<cmath>\", importcpp: \"powl((#), (long\
    \ double)(@))\", nodecl.}\n# }}}\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/longdouble.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/longdouble.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/longdouble.nim
- /library/atcoder/extra/math/longdouble.nim.html
title: atcoder/extra/math/longdouble.nim
---