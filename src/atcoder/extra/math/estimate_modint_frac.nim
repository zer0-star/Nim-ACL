# {{{ estimate fcaction
when not declared ESTIMATE_FRACTION_HPP:
  const ESTIMATE_FRACTION_HPP* = 1
  import std/math, std/strutils

  proc estimate[ModInt](f:ModInt):string =
    var P = sqrt(ModInt.mod.float).int
    for d in 1..P:
      var f = f * d
      if f.int <= P:
        return $f & "/" & $d
    return "(estimation failed)"
# }}}
