when not declared ATCODER_EXTRA_SQRT_INT_HPP:
  const ATCODER_EXTRA_SQRT_INT_HPP* = 1
  import std/bitops

  proc sqrt_int*(s:int):int =
    if s <= 1: return s
    var
      #x0 = s shr 1
      x0 = 1 shl (fastLog2(s) div 2 + 1)
      x1 = (x0 + s div x0) shr 1
    while x1 < x0:
      x0 = x1
      x1 = (x0 + s div x0) shr 1
    return x0
