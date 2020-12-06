when not declared ESTIMATE_FRACTION_HPP:
  const ESTIMATE_FRACTION_HPP* = 1
  import std/math

  proc estimate*[ModInt](f:ModInt):string =
    var P = sqrt(ModInt.mod.float).int
    for d in 1..P:
      var f = f * d
      if f.val() <= P:
        return $f & "/" & $d
    return "(estimation failed)"
