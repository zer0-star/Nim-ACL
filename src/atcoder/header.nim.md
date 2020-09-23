---
data:
  _extendedDependsOn: []
  _extendedRequiredBy: []
  _extendedVerifiedWith: []
  _pathExtension: nim
  _verificationStatusIcon: ':warning:'
  attributes:
    links: []
  bundledCode: "Traceback (most recent call last):\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/documentation/build.py\"\
    , line 70, in _render_source_code_stat\n    bundled_code = language.bundle(stat.path,\
    \ basedir=basedir).decode()\n  File \"/opt/hostedtoolcache/Python/3.8.5/x64/lib/python3.8/site-packages/onlinejudge_verify/languages/nim.py\"\
    , line 86, in bundle\n    raise NotImplementedError\nNotImplementedError\n"
  code: "when not declared ATCODER_HEADER_HPP:\n  const ATCODER_HEADER_HPP* = 1\n\
    \  {.hints:off checks:off assertions:on checks:off optimization:speed.}\n  import\
    \ std/algorithm as algorithm_lib, std/sequtils as sequils_lib, std/tables as tables_lib,\
    \ std/macros as macros_lib, std/math as math_lib, std/sets as sets_lib, std/strutils\
    \ as strutils_lib, std/streams as streams_lib, std/strformat as strformat_lib,\
    \ std/sugar as sugar_lib\n  \n  proc scanf*(formatstr: cstring){.header: \"<stdio.h>\"\
    , varargs.}\n  proc getchar*(): char {.header: \"<stdio.h>\", varargs.}\n  proc\
    \ nextInt*(base:int = 0): int =\n    scanf(\"%lld\",addr result)\n    result -=\
    \ base\n  proc nextFloat*(): float = scanf(\"%lf\",addr result)\n  proc nextString*():\
    \ string =\n    var get = false;result = \"\"\n    while true:\n      var c =\
    \ getchar()\n      if int(c) > int(' '): get = true;result.add(c)\n      elif\
    \ get: break\n  template `max=`*(x,y:typed):void = x = max(x,y)\n  template `min=`*(x,y:typed):void\
    \ = x = min(x,y)\n  template inf*(T): untyped = \n    when T is SomeFloat: T(Inf)\n\
    \    elif T is SomeInteger: ((T(1) shl T(sizeof(T)*8-2)) - (T(1) shl T(sizeof(T)*4-1)))\n\
    \    else: assert(false)\n"
  dependsOn: []
  isVerificationFile: false
  path: src/atcoder/header.nim
  requiredBy: []
  timestamp: '2020-09-22 00:56:23+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/atcoder/header.nim
layout: document
redirect_from:
- /library/src/atcoder/header.nim
- /library/src/atcoder/header.nim.html
title: src/atcoder/header.nim
---
