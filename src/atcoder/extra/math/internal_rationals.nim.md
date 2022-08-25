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
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 71, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir, options={'include_paths': [basedir]}).decode()\n  File \"/opt/hostedtoolcache/Python/3.10.6/x64/lib/python3.10/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared(ATCODER_INTERNAL_RATIONALS):\n  const ATCODER_INTERNAL_RATIONALS*\
    \ = 1\n  # Nim\u306E\u5143\u306ERational\u3067\u306F\u7121\u9650\u5927\u306E\u8A08\
    \u7B97\u304C\u3067\u304D\u306A\u3044\n  # \u3053\u308C\u3092\u7121\u9650\u5927\
    \u306F1/0, \u30DE\u30A4\u30CA\u30B9\u7121\u9650\u5927\u3092-1/0\u3068\u3057\u3066\
    \u5BFE\u5FDC\n  # \u221E+\u6709\u9650=\u221E, -\u221E+\u6709\u9650=-\u221E, \u221E\
    -\u221E=\u30A8\u30E9\u30FC\u3068\u306A\u3063\u3066\u308B\u306F\u305A\n  # 1 /\
    \ \u221E = 0\u3068\u306A\u308B\u306F\u305A\n  # \u3042\u3068\u3001\u591A\u500D\
    \u9577\u6574\u6570\u3068\u304B\u3082\u8F09\u305B\u3089\u308C\u308B\u3088\u3046\
    \u306BT: SomeInteger\u3092\u64A4\u5EC3\n  # //\u304CfloorDiv\u3068\u30D0\u30C3\
    \u30C6\u30A3\u30F3\u30B0\u3059\u308B\u306E\u3067///\u306B\u3057\u3088\u3046\u304B\
    \n  # rationals\u3068\u3053\u308C\u3092\u4E21\u65B9import\u3059\u308B\u3068\u305F\
    \u3076\u3093\u30D0\u30B0\u308B\u306E\u3067\u6CE8\u610F\n\n  runnableExamples:\n\
    \    let\n      r1 = 1 /// 2\n      r2 = -3 /// 4\n\n    doAssert r1 + r2 == -1\
    \ /// 4\n    doAssert r1 - r2 ==  5 /// 4\n    doAssert r1 * r2 == -3 /// 8\n\
    \    doAssert r1 / r2 == -2 /// 3\n\n  import math, hashes\n\n  type Rational*[T]\
    \ = object\n    ## A rational number, consisting of a numerator `num` and a denominator\
    \ `den`.\n    num*, den*: T\n\n  func reduce*[T](x: var Rational[T]) =\n    ##\
    \ Reduces the rational number `x`, so that the numerator and denominator\n   \
    \ ## have no common divisors other than 1 (and -1).\n    ## If `x` is 0, raises\
    \ `DivByZeroDefect`.\n    ##\n    ## **Note:** This is called automatically by\
    \ the various operations on rationals.\n    runnableExamples:\n      var r = Rational[int](num:\
    \ 2, den: 4) # 1/2\n      reduce(r)\n      doAssert r.num == 1\n      doAssert\
    \ r.den == 2\n  \n    let common = gcd(x.num, x.den)\n    if x.den > 0:\n    \
    \  x.num = x.num div common\n      x.den = x.den div common\n    elif x.den <\
    \ 0:\n      x.num = -x.num div common\n      x.den = -x.den div common\n    else:\n\
    \      if x.num > 0:\n        x.num = 1\n      elif x.num < 0:\n        x.num\
    \ = -1\n      else:\n        doAssert false, \"0 / 0\"\n      #raise newException(DivByZeroDefect,\
    \ \"division by zero\")\n  \n  func initRational*[T](num, den: T): Rational[T]\
    \ =\n    ## Creates a new rational number with numerator `num` and denominator\
    \ `den`.\n    ## `den` must not be 0.\n    ##\n    ## **Note:** `den != 0` is\
    \ not checked when assertions are turned off.\n    #assert(den != 0, \"a denominator\
    \ of zero is invalid\")\n    result.num = num\n    result.den = den\n    reduce(result)\n\
    \n  converter rationalConverter*[T:not Rational](a:T):Rational[T] =\n    initRational(a,\
    \ T(1))\n\n  func `///`*[T](num, den: T): Rational[T] =\n    ## A friendlier version\
    \ of `initRational <#initRational,T,T>`_.\n    runnableExamples:\n      let x\
    \ = 1 /// 3 + 1 /// 5\n      doAssert x == 8 /// 15\n  \n    initRational[T](num,\
    \ den)\n  \n  func `$`*[T](x: Rational[T]): string =\n    ## Turns a rational\
    \ number into a string.\n    runnableExamples:\n      doAssert $(1 /// 2) == \"\
    1/2\"\n  \n    result = $x.num & \"/\" & $x.den\n  \n  func toRational*[T](x:\
    \ T): Rational[T] =\n    ## Converts some integer `x` to a rational number.\n\
    \    runnableExamples:\n      doAssert toRational(42) == 42 /// 1\n  \n    result.num\
    \ = x\n    result.den = 1\n  \n  func toRational*(x: float,\n                \
    \   n: int = high(int) shr (sizeof(int) div 2 * 8)): Rational[int] =\n    ## Calculates\
    \ the best rational approximation of `x`,\n    ## where the denominator is smaller\
    \ than `n`\n    ## (default is the largest possible `int` for maximal resolution).\n\
    \    ##\n    ## The algorithm is based on the theory of continued fractions.\n\
    \    # David Eppstein / UC Irvine / 8 Aug 1993\n    # With corrections from Arno\
    \ Formella, May 2008\n    runnableExamples:\n      let x = 1.2\n      doAssert\
    \ x.toRational.toFloat == x\n  \n    var\n      m11, m22 = 1\n      m12, m21 =\
    \ 0\n      ai = int(x)\n      x = x\n    while m21 * ai + m22 <= n:\n      swap\
    \ m12, m11\n      swap m22, m21\n      m11 = m12 * ai + m11\n      m21 = m22 *\
    \ ai + m21\n      if x == float(ai): break # division by zero\n      x = 1 / (x\
    \ - float(ai))\n      if x > float(high(int32)): break # representation failure\n\
    \      ai = int(x)\n    result = m11 /// m21\n  \n  func toFloat*[T](x: Rational[T]):\
    \ float =\n    ## Converts a rational number `x` to a `float`.\n    x.num / x.den\n\
    \  \n  func toInt*[T](x: Rational[T]): int =\n    ## Converts a rational number\
    \ `x` to an `int`. Conversion rounds towards 0 if\n    ## `x` does not contain\
    \ an integer value.\n    x.num div x.den\n  \n  proc getRate[T](a, b:T):T =\n\
    \    if b == T(0):\n      doAssert a == T(0)\n      return T(1)\n    else:\n \
    \     return a div b\n\n  func `+`*[T](x, y: Rational[T]): Rational[T] =\n   \
    \ ## Adds two rational numbers.\n    let common = lcm(x.den, y.den)\n    result.num\
    \ = getRate(common, x.den) * x.num + getRate(common, y.den) * y.num\n    result.den\
    \ = common\n    reduce(result)\n  \n  func `+`*[T](x: Rational[T], y: T): Rational[T]\
    \ =\n    ## Adds the rational `x` to the int `y`.\n    result.num = x.num + y\
    \ * x.den\n    result.den = x.den\n  \n  func `+`*[T](x: T, y: Rational[T]): Rational[T]\
    \ =\n    ## Adds the int `x` to the rational `y`.\n    result.num = x * y.den\
    \ + y.num\n    result.den = y.den\n  \n  func `+=`*[T](x: var Rational[T], y:\
    \ Rational[T]) =\n    ## Adds the rational `y` to the rational `x` in-place.\n\
    \    let common = lcm(x.den, y.den)\n    x.num = getRate(common, x.den) * x.num\
    \ + getRate(common, y.den) * y.num\n    x.den = common\n    reduce(x)\n  \n  func\
    \ `+=`*[T](x: var Rational[T], y: T) =\n    ## Adds the int `y` to the rational\
    \ `x` in-place.\n    x.num += y * x.den\n  \n  func `-`*[T](x: Rational[T]): Rational[T]\
    \ =\n    ## Unary minus for rational numbers.\n    result.num = -x.num\n    result.den\
    \ = x.den\n  \n  func `-`*[T](x, y: Rational[T]): Rational[T] =\n    ## Subtracts\
    \ two rational numbers.\n    let common = lcm(x.den, y.den)\n    result.num =\
    \ getRate(common, x.den) * x.num - getRate(common, y.den) * y.num\n    result.den\
    \ = common\n    reduce(result)\n  \n  func `-`*[T](x: Rational[T], y: T): Rational[T]\
    \ =\n    ## Subtracts the int `y` from the rational `x`.\n    result.num = x.num\
    \ - y * x.den\n    result.den = x.den\n  \n  func `-`*[T](x: T, y: Rational[T]):\
    \ Rational[T] =\n    ## Subtracts the rational `y` from the int `x`.\n    result.num\
    \ = x * y.den - y.num\n    result.den = y.den\n  \n  func `-=`*[T](x: var Rational[T],\
    \ y: Rational[T]) =\n    ## Subtracts the rational `y` from the rational `x` in-place.\n\
    \    let common = lcm(x.den, y.den)\n    x.num = getRate(common, x.den) * x.num\
    \ - getRate(common, y.den) * y.num\n    x.den = common\n    reduce(x)\n  \n  func\
    \ `-=`*[T](x: var Rational[T], y: T) =\n    ## Subtracts the int `y` from the\
    \ rational `x` in-place.\n    x.num -= y * x.den\n  \n  func `*`*[T](x, y: Rational[T]):\
    \ Rational[T] =\n    ## Multiplies two rational numbers.\n    result.num = x.num\
    \ * y.num\n    result.den = x.den * y.den\n    reduce(result)\n  \n  func `*`*[T](x:\
    \ Rational[T], y: T): Rational[T] =\n    ## Multiplies the rational `x` with the\
    \ int `y`.\n    result.num = x.num * y\n    result.den = x.den\n    reduce(result)\n\
    \  \n  func `*`*[T](x: T, y: Rational[T]): Rational[T] =\n    ## Multiplies the\
    \ int `x` with the rational `y`.\n    result.num = x * y.num\n    result.den =\
    \ y.den\n    reduce(result)\n  \n  func `*=`*[T](x: var Rational[T], y: Rational[T])\
    \ =\n    ## Multiplies the rational `x` by `y` in-place.\n    x.num *= y.num\n\
    \    x.den *= y.den\n    reduce(x)\n  \n  func `*=`*[T](x: var Rational[T], y:\
    \ T) =\n    ## Multiplies the rational `x` by the int `y` in-place.\n    x.num\
    \ *= y\n    reduce(x)\n  \n  func reciprocal*[T](x: Rational[T]): Rational[T]\
    \ =\n    ## Calculates the reciprocal of `x` (`1/x`).\n    ## If `x` is 0, raises\
    \ `DivByZeroDefect`.\n    if x.num >= 0:\n      result.num = x.den\n      result.den\
    \ = x.num\n    elif x.num < 0:\n      result.num = -x.den\n      result.den =\
    \ -x.num\n    #else:\n    #  raise newException(DivByZeroDefect, \"division by\
    \ zero\")\n  \n  func `/`*[T](x, y: Rational[T]): Rational[T] =\n    ## Divides\
    \ the rational `x` by the rational `y`.\n    result.num = x.num * y.den\n    result.den\
    \ = x.den * y.num\n    reduce(result)\n  \n  func `/`*[T](x: Rational[T], y: T):\
    \ Rational[T] =\n    ## Divides the rational `x` by the int `y`.\n    result.num\
    \ = x.num\n    result.den = x.den * y\n    reduce(result)\n  \n  func `/`*[T](x:\
    \ T, y: Rational[T]): Rational[T] =\n    ## Divides the int `x` by the rational\
    \ `y`.\n    result.num = x * y.den\n    result.den = y.num\n    reduce(result)\n\
    \  \n  func `/=`*[T](x: var Rational[T], y: Rational[T]) =\n    ## Divides the\
    \ rational `x` by the rational `y` in-place.\n    x.num *= y.den\n    x.den *=\
    \ y.num\n    reduce(x)\n  \n  func `/=`*[T](x: var Rational[T], y: T) =\n    ##\
    \ Divides the rational `x` by the int `y` in-place.\n    x.den *= y\n    reduce(x)\n\
    \  \n  func cmp*(x, y: Rational): int =\n    ## Compares two rationals. Returns\n\
    \    ## * a value less than zero, if `x < y`\n    ## * a value greater than zero,\
    \ if `x > y`\n    ## * zero, if `x == y`\n    (x - y).num\n  \n  func `<`*(x,\
    \ y: Rational): bool =\n    ## Returns true if `x` is less than `y`.\n    (x -\
    \ y).num < 0\n  \n  func `<=`*(x, y: Rational): bool =\n    ## Returns tue if\
    \ `x` is less than or equal to `y`.\n    (x - y).num <= 0\n  \n  func `==`*(x,\
    \ y: Rational): bool =\n    ## Compares two rationals for equality.\n    (x -\
    \ y).num == 0\n\n  # SomeInteger\u3092not Rational\u307E\u3067\u62E1\u5F35\u3057\
    \u305F\u3044\u3051\u3069\u30D0\u30B0\u308B\n  # \u7121\u5370\u3060\u3068\u306A\
    \u305C\u304B\u30D0\u30C3\u30C6\u30A3\u30F3\u30B0\u3059\u308B\n  func `<` *[T:SomeInteger](x:Rational[T],\
    \ y:T): bool = (x - y).num <  T(0)\n  func `<` *[T:SomeInteger](x:T, y:Rational[T]):\
    \ bool = (x - y).num <  T(0)\n  func `<=`*[T:SomeInteger](x:T, y:Rational[T]):\
    \ bool = (x - y).num <= T(0)\n  func `<=`*[T:SomeInteger](x:Rational[T], y:T):\
    \ bool = (x - y).num <= T(0)\n  func `==`*[T:SomeInteger](x:T, y:Rational[T]):\
    \ bool = (x - y).num == T(0)\n  func `==`*[T:SomeInteger](x:Rational[T], y:T):\
    \ bool = (x - y).num == T(0)\n\n  func abs*[T](x: Rational[T]): Rational[T] =\n\
    \    ## Returns the absolute value of `x`.\n    runnableExamples:\n      doAssert\
    \ abs(1 /// 2) == 1 /// 2\n      doAssert abs(-1 /// 2) == 1 /// 2\n  \n    result.num\
    \ = abs x.num\n    result.den = abs x.den\n  \n  func `div`*[T](x, y: Rational[T]):\
    \ T =\n    ## Computes the rational truncated division.\n    (x.num * y.den) div\
    \ (y.num * x.den)\n  \n  func `mod`*[T](x, y: Rational[T]): Rational[T] =\n  \
    \  ## Computes the rational modulo by truncated division (remainder).\n    ##\
    \ This is same as `x - (x div y) * y`.\n    result = ((x.num * y.den) mod (y.num\
    \ * x.den)) /// (x.den * y.den)\n    reduce(result)\n  \n  func floorDiv*[T](x,\
    \ y: Rational[T]): T =\n    ## Computes the rational floor division.\n    ##\n\
    \    ## Floor division is conceptually defined as `floor(x / y)`.\n    ## This\
    \ is different from the `div` operator, which is defined\n    ## as `trunc(x /\
    \ y)`. That is, `div` rounds towards 0 and `floorDiv`\n    ## rounds down.\n \
    \   floorDiv(x.num * y.den, y.num * x.den)\n  \n  func floorMod*[T](x, y: Rational[T]):\
    \ Rational[T] =\n    ## Computes the rational modulo by floor division (modulo).\n\
    \    ##\n    ## This is same as `x - floorDiv(x, y) * y`.\n    ## This func behaves\
    \ the same as the `%` operator in Python.\n    result = floorMod(x.num * y.den,\
    \ y.num * x.den) /// (x.den * y.den)\n    reduce(result)\n  \n  func hash*[T](x:\
    \ Rational[T]): Hash =\n    ## Computes the hash for the rational `x`.\n    #\
    \ reduce first so that hash(x) == hash(y) for x == y\n    var copy = x\n    reduce(copy)\n\
    \  \n    var h: Hash = 0\n    h = h !& hash(copy.num)\n    h = h !& hash(copy.den)\n\
    \    result = !$h\n"
  dependsOn: []
  isVerificationFile: false
  path: atcoder/extra/math/internal_rationals.nim
  requiredBy: []
  timestamp: '2022-08-25 23:07:59+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: atcoder/extra/math/internal_rationals.nim
layout: document
redirect_from:
- /library/atcoder/extra/math/internal_rationals.nim
- /library/atcoder/extra/math/internal_rationals.nim.html
title: atcoder/extra/math/internal_rationals.nim
---
