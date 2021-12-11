when not declared ATCODER_HEADER_HPP:
  const ATCODER_HEADER_HPP* = 1
  {.hints:off checks:off assertions:on optimization:speed.}
  {. warning[UnusedImport]:off .}
  import std/algorithm as algorithm_lib, std/sequtils as sequils_lib, std/tables as tables_lib, std/macros as macros_lib, std/math as math_lib, std/sets as sets_lib, std/strutils as strutils_lib, std/streams as streams_lib, std/strformat as strformat_lib

  proc scanf*(formatstr: cstring){.header: "<stdio.h>", varargs.}
  proc getchar*(): char {.header: "<stdio.h>", varargs.}
  proc nextInt*(base:int = 0): int =
    scanf("%lld",addr result)
    result -= base
  proc nextFloat*(): float = scanf("%lf",addr result)
  proc nextString*(): string =
    var get = false;result = ""
    while true:
      var c = getchar()
      if int(c) > int(' '): get = true;result.add(c)
      elif get: break
  template `max=`*(x,y:typed):void = x = max(x,y)
  template `min=`*(x,y:typed):void = x = min(x,y)
  template inf*(T): untyped = 
    when T is SomeFloat: T(Inf)
    elif T is SomeInteger: T.high div 2
    else: assert(false)

