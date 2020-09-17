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
  code: "# {{{ header\nwhen not declared ATCODER_CHAEMON_HEADER_HPP:\n  const ATCODER_CHAEMON_HEADER_HPP*\
    \ = 1\n  {.hints:off checks:off warnings:off assertions:on optimization:speed.}\n\
    \  import std/algorithm, std/sequtils, std/tables, std/macros, std/math, std/sets,\
    \ std/strutils, std/strformat, std/sugar\n  \n  import streams\n  proc scanf*(formatstr:\
    \ cstring){.header: \"<stdio.h>\", varargs.}\n  #proc getchar(): char {.header:\
    \ \"<stdio.h>\", varargs.}\n  proc nextInt*(): int = scanf(\"%lld\",addr result)\n\
    \  proc nextFloat*(): float = scanf(\"%lf\",addr result)\n  proc nextString*[F](f:F):\
    \ string =\n    var get = false\n    result = \"\"\n    while true:\n  #    let\
    \ c = getchar()\n      let c = f.readChar\n      if c.int > ' '.int:\n       \
    \ get = true\n        result.add(c)\n      elif get: return\n  proc nextInt*[F](f:F):\
    \ int = parseInt(f.nextString)\n  proc nextFloat*[F](f:F): float = parseFloat(f.nextString)\n\
    \  proc nextString*():string = stdin.nextString()\n  \n  template `max=`*(x,y:typed):void\
    \ = x = max(x,y)\n  template `min=`*(x,y:typed):void = x = min(x,y)\n  template\
    \ inf*(T): untyped = \n    when T is SomeFloat: T(Inf)\n    elif T is SomeInteger:\
    \ ((T(1) shl T(sizeof(T)*8-2)) - (T(1) shl T(sizeof(T)*4-1)))\n    else: assert(false)\n\
    \  \n  proc discardableId*[T](x: T): T {.discardable.} =\n    return x\n  \n \
    \ macro `:=`*(x, y: untyped): untyped =\n    var strBody = \"\"\n    if x.kind\
    \ == nnkPar:\n      for i,xi in x:\n        strBody &= fmt\"\"\"\n{xi.repr} :=\
    \ {y[i].repr}\n\"\"\"\n    else:\n      strBody &= fmt\"\"\"\nwhen declaredInScope({x.repr}):\n\
    \  {x.repr} = {y.repr}\nelse:\n  var {x.repr} = {y.repr}\n\"\"\"\n    strBody\
    \ &= fmt\"discardableId({x.repr})\"\n    parseStmt(strBody)\n  \n  \n  proc toStr*[T](v:T):string\
    \ =\n    proc `$`[T](v:seq[T]):string =\n      v.mapIt($it).join(\" \")\n    return\
    \ $v\n  \n  proc print0*(x: varargs[string, toStr]; sep:string):string{.discardable.}\
    \ =\n    result = \"\"\n    for i,v in x:\n      if i != 0: addSep(result, sep\
    \ = sep)\n      add(result, v)\n    result.add(\"\\n\")\n    stdout.write result\n\
    \  \n  var print*:proc(x: varargs[string, toStr])\n  print = proc(x: varargs[string,\
    \ toStr]) =\n    discard print0(@x, sep = \" \")\n  \n  template makeSeq*(x:int;\
    \ init):auto =\n    when init is typedesc: newSeq[init](x)\n    else: newSeqWith(x,\
    \ init)\n  \n  macro Seq*(lens: varargs[int]; init):untyped =\n    var a = fmt\"\
    {init.repr}\"\n    for i in countdown(lens.len - 1, 0): a = fmt\"makeSeq({lens[i].repr},\
    \ {a})\"\n    parseStmt(fmt\"\"\"  \nblock:\n  {a}\"\"\")\n  \n  template makeArray*(x:int;\
    \ init):auto =\n    var v:array[x, init.type]\n    when init isnot typedesc:\n\
    \      for a in v.mitems: a = init\n    v\n  \n  macro Array*(lens: varargs[typed],\
    \ init):untyped =\n    var a = fmt\"{init.repr}\"\n    for i in countdown(lens.len\
    \ - 1, 0):\n      a = fmt\"makeArray({lens[i].repr}, {a})\"\n    parseStmt(fmt\"\
    \"\"\nblock:\n  {a}\"\"\")\n# }}}\n"
  dependsOn: []
  isVerificationFile: false
  path: src/nim_acl/extra/header/chaemon_header.nim
  requiredBy: []
  timestamp: '2020-09-16 23:07:19+09:00'
  verificationStatus: LIBRARY_NO_TESTS
  verifiedWith: []
documentation_of: src/nim_acl/extra/header/chaemon_header.nim
layout: document
redirect_from:
- /library/src/nim_acl/extra/header/chaemon_header.nim
- /library/src/nim_acl/extra/header/chaemon_header.nim.html
title: src/nim_acl/extra/header/chaemon_header.nim
---
