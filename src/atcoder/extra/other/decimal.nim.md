---
data:
  _extendedDependsOn:
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
  - icon: ':question:'
    path: atcoder/element_concepts.nim
    title: atcoder/element_concepts.nim
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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.8/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "import atcoder/extra/other/decimal_gmp\nimport atcoder/extra/other/floatutils\n\
    import atcoder/extra/other/static_var\n\n#converter toDecimal*(a:int):Decimal\
    \ = Decimal(a)\n#converter toDecimal*(s:string):Decimal = Decimal(s)\n\nproc calcPi*[Real]():Real\
    \ =\n  var\n    a = Real(1)\n    b = Real(1) / sqrt(Real(2))\n    c = Real(1)\
    \ / Real(4)\n    d = Real(1)\n\n  var prev = Decimal(0)\n\n  while true:\n   \
    \ let s = a + b\n    let p = s * s / (Real(4) * c)\n    if p == prev: break\n\
    \    prev = p\n    var\n      na = (a + b) / Real(2)\n      nb = sqrt(a * b)\n\
    \      nc = c - d * (a - na) * (a - na)\n      nd = Real(2) * d\n    #swap(na,\
    \ a)\n    #swap(nb, b)\n    #swap(nc, c)\n    #swap(nd, d)\n    a = na.move\n\
    \    b = nb.move\n    c = nc.move\n    d = nd.move\n  return prev\n\nproc exp*(x:Decimal):Decimal\
    \ =\n  result = Decimal(0)\n  var\n    p = Decimal(1)\n    i = 0\n  while true:\n\
    \    var result_old = result.clone()\n    result += p\n    if result == result_old:\
    \ break\n    p *= x\n    i.inc\n    p /= Decimal(i)\n\nproc initPrec*(Real:typedesc[Decimal],\
    \ n:int) =\n  setPrec(n)\n  # \u3068\u308A\u3042\u3048\u305AINF\u306F\u547C\u3070\
    \u306A\u3044\u3088\u3046\u306B\n  var INF_VAL = Decimal(0)\n  #mpd_setspecial(INF_VAL[],\
    \ MPD_POS, MPD_INF)\n  #Decimal$.pi = calcPi[Real]()\n  #Decimal$.eps = Decimal(10)^(-(n\
    \ div 5 - 5))\n  #Decimal$.eps = Decimal(1) / Decimal(10)^(n div 4)\n  #Decimal$.inf\
    \ = INF_VAL\n  #echo \"eps: \", Decimal$.eps\n\n  Decimal.getParameters()[] =\
    \ (n, calcPi[Real](), machine_epsilon() * Decimal(10)^10, INF_VAL)\n\nproc sin_impl*(x:Decimal):Decimal\
    \ =\n  result = Decimal(0)\n  let mx2 = - x * x\n  var\n    i = 1\n    p = x\n\
    \  while true:\n    var next = result + p\n    if next == result: break\n    result\
    \ = next.move()\n    p *= mx2 / ((i + 1) * (i + 2))\n    i += 2\n\nproc sin*(x:Decimal):Decimal\
    \ =\n  let r = rem(x, ((Decimal$.pi) * 2))\n  return sin_impl(r)\n\nproc cos_impl(x:Decimal):Decimal\
    \ =\n  result = Decimal(0)\n  let mx2 = - x * x\n  var\n    i = 0\n    p = Decimal(1)\n\
    \  while true:\n    var next = result + p\n    if next == result: break\n    result\
    \ = next.move()\n    p *= mx2 / ((i + 1) * (i + 2))\n    i += 2\n\nproc cos*(x:Decimal):Decimal\
    \ =\n  let r = rem(x, ((Decimal$.pi) * 2))\n  return cos_impl(r)\n\nproc tan*(x:Decimal):Decimal\
    \ = sin(x) / cos(x)\n\nproc sinh*(x:Decimal):Decimal =\n  return (exp(x) - exp(-x))\
    \ / Decimal(2)\n\nproc cosh*(x:Decimal):Decimal =\n  return (exp(x) + exp(-x))\
    \ / Decimal(2)\n\nproc hypot*(x, y:Decimal):Decimal = sqrt(x * x + y * y)\n\n\
    #proc pow*(a, b:Decimal):Decimal = a ^ b\n\nproc arcsin*(x:Decimal):Decimal =\n\
    \  result = Decimal(0)\n  var\n    n = 0\n    p = x\n    t = 1 / Decimal(2)\n\
    \    x2 = x * x\n  while true:\n    var next = result + p / (2 * n + 1)\n    if\
    \ next == result: break\n    swap(next, result)\n\n    p *= t\n    p *= x2\n \
    \   t += 1\n    n.inc\n    p /= n\n\nproc arccos*(x:Decimal):Decimal =\n  (Decimal$.pi)\
    \ / Decimal(2) - arcsin(x)\n\nproc arctan2*(y, x:Decimal):Decimal =\n  var\n \
    \   a = x / sqrt(x * x + y * y)\n    b = Decimal(1)\n  while true:\n    var\n\
    \      na = (a + b) / 2\n      nb = sqrt(na * b)\n    if na == a:break\n    a\
    \ = na.move\n    b = nb.move\n  return y / (a * sqrt(x * x + y * y))\nproc arctan*(x:Decimal):Decimal\
    \ =\n  return arctan2(x, Decimal(1))\n\n#proc round*(x:Decimal):Decimal = round_to_int(x)\n"
  dependsOn:
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/element_concepts.nim
  - atcoder/element_concepts.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/static_var.nim
  - atcoder/extra/other/floatutils.nim
  - atcoder/extra/other/static_var.nim
  isVerificationFile: false
  path: atcoder/extra/other/decimal.nim
  requiredBy: []
  timestamp: '2022-10-23 18:37:31+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/other/decimal.nim
layout: document
redirect_from:
- /library/atcoder/extra/other/decimal.nim
- /library/atcoder/extra/other/decimal.nim.html
title: atcoder/extra/other/decimal.nim
---
