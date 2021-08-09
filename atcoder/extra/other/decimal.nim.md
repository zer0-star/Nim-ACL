---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/floatutils.nim
    title: atcoder/extra/other/floatutils.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
  - icon: ':heavy_check_mark:'
    path: atcoder/extra/other/static_var.nim
    title: atcoder/extra/other/static_var.nim
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
  code: "import \"~/git/nim-decimal/decimal/decimal\"\nimport \"~/git/nim-decimal/decimal/decimal_lowlevel\"\
    \nimport atcoder/extra/other/floatutils\nimport atcoder/extra/other/static_var\n\
    \nconverter toDecimal*(a:int):DecimalType = newDecimal(a)\nconverter toDecimal*(s:string):DecimalType\
    \ = newDecimal(s)\n\nproc calcPi*[Real]():Real =\n  var\n    a = Real(1)\n   \
    \ b = Real(1) / sqrt(Real(2))\n    c = Real(1) / Real(4)\n    d = Real(1)\n\n\
    \  var prev = newDecimal(0)\n\n  while true:\n    let p = (a + b)^2/(Real(4) *\
    \ c)\n    if p == prev: break\n    prev = p\n    var\n      na = (a + b) / Real(2)\n\
    \      nb = sqrt(a * b)\n      nc = c - d * (a - na)^2\n      nd = Real(2) * d\n\
    \    swap(na, a)\n    swap(nb, b)\n    swap(nc, c)\n    swap(nd, d)\n  return\
    \ prev\n\nproc initPrec*(Real:typedesc[DecimalType], n:int) =\n  setPrec(n)\n\
    \  var INF_VAL = newDecimal()\n  mpd_setspecial(INF_VAL[], MPD_POS, MPD_INF)\n\
    \  DecimalType$.pi = calcPi[Real]()\n  DecimalType$.eps = newDecimal(10)^(-(n\
    \ - 5))\n  DecimalType$.inf = INF_VAL\n\n#  DecimalType.getParameters()[] = (n,\
    \ calcPi[Real](), newDecimal(10)^(-(n - 5)), INF_VAL)\n\nproc sin_impl*(x:DecimalType):DecimalType\
    \ =\n  result = newDecimal(0)\n  let mx2 = - x * x\n  var\n    i = 1\n    p =\
    \ x\n  while true:\n    var next = result + p\n    if next == result: break\n\
    \    result = next.move()\n    p *= mx2 / ((i + 1) * (i + 2))\n    i += 2\n\n\
    proc sin*(x:DecimalType):DecimalType =\n  let r = rem(x, ((DecimalType$.pi) *\
    \ 2))\n  return sin_impl(r)\n\nproc cos_impl(x:DecimalType):DecimalType =\n  result\
    \ = newDecimal(0)\n  let mx2 = - x * x\n  var\n    i = 0\n    p = newDecimal(1)\n\
    \  while true:\n    var next = result + p\n    if next == result: break\n    result\
    \ = next.move()\n    p *= mx2 / ((i + 1) * (i + 2))\n    i += 2\n\nproc cos*(x:DecimalType):DecimalType\
    \ =\n  let r = rem(x, ((DecimalType$.pi) * 2))\n  return cos_impl(r)\n\nproc tan*(x:DecimalType):DecimalTYpe\
    \ = sin(x) / cos(x)\n\nproc sinh*(x:DecimalType):DecimalType =\n  return (exp(x)\
    \ - exp(-x)) / newDecimal(2)\n\nproc cosh*(x:DecimalType):DecimalType =\n  return\
    \ (exp(x) + exp(-x)) / newDecimal(2)\n\nproc hypot*(x, y:DecimalType):DecimalType\
    \ = sqrt(x * x + y * y)\n\nproc pow*(a, b:DecimalType):DecimalType = a ^ b\n\n\
    proc arcsin*(x:DecimalType):DecimalType =\n  result = newDecimal(0)\n  var\n \
    \   n = 0\n    p = x\n    t = 1 / newDecimal(2)\n    x2 = x * x\n  while true:\n\
    \    var next = result + p / (2 * n + 1)\n    if next == result: break\n    swap(next,\
    \ result)\n\n    p *= t\n    p *= x2\n    t += 1\n    n.inc\n    p /= n\n\nproc\
    \ arccos*(x:DecimalType):DecimalType =\n  (DecimalType$.pi) / newDecimal(2) -\
    \ arcsin(x)\n\nproc arctan2*(y, x:DecimalType):DecimalType =\n  var\n    a = x\
    \ / sqrt(x * x + y * y)\n    b = newDecimal(1)\n  while true:\n    var\n     \
    \ na = (a + b) / 2\n      nb = sqrt(na * b)\n    if na == a:break\n    a = na.move\n\
    \    b = nb.move\n  return y / (a * sqrt(x * x + y * y))\nproc arctan*(x:DecimalType):DecimalType\
    \ =\n  return arctan2(x, newDecimal(1))\n\nproc round*(x:DecimalType):DecimalType\
    \ = round_to_int(x)\n"
  dependsOn:
  - atcoder/element_concepts.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/static_var.nim
  isVerificationFile: false
  path: atcoder/extra/other/decimal.nim
  requiredBy: []
  timestamp: '1970-01-01 00:00:00+00:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/decimal.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/decimal.nim
- /library/atcoder/extra/other/decimal.nim.html
title: atcoder/extra/other/decimal.nim
---
