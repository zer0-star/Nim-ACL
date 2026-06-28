when not declared ATCODER_MODINT61_HPP:
  const ATCODER_MODINT61_HPP* = 1
  import atcoder/extra/math/int128
  import std/sugar
  const MOD = (1'u shl 61) - 1
  type modint61* = object
    val: uint
  proc init*(_: typedesc[modint61], x:uint32):modint61 = modint61(val: x)
  proc init*(_: typedesc[modint61], x:uint64):modint61 = modint61(val: x mod MOD)
  proc init*(_: typedesc[modint61], x:int32):modint61 =
    modint61(val: uint(if x < 0: x + int(MOD) else: x))
  proc init*(_: typedesc[modint61], x:int):modint61 =
    var x = x mod int(MOD)
    modint61(val: uint(if x < 0: x + int(MOD) else: x))
  proc getMod*(_: modint61 or typedesc[modint61]): uint = MOD
  proc `+=`*(self: var modint61, a: modint61):modint61 {.discardable.} =
    var val = self.val + a.val
    val = if val >= MOD: (val - MOD) else: val
    self.val = val
    return self
  proc `-=`*(self: var modint61, a: modint61):modint61 {.discardable.} =
    var val = self.val - a.val
    val = if val >= MOD: (val + MOD) else: val
    self.val = val
    return self
  proc `*=`*(self: var modint61, a: modint61): modint61 {.discardable.} =
    let y = Uint128(self.val) * a.val;
    self.val = (y shr 61).toUint + (y and MOD).toUint
    self.val = if self.val >= MOD: self.val - MOD else: self.val
    return self
  proc `-`*(self: modint61):modint61 = modint61.init(if self.val != 0: MOD - self.val else: uint(0))
  proc inv*(self: modint61):modint61 =
    var
      a = int(self.val)
      b = int(MOD)
      u = 1
      v = 0
      t: int
    while b > 0:
      t = a div b
      a -= t * b
      swap a, b
      u -= t * v
      swap u, v
    return modint61.init(u)

  proc `/=`*(self: var modint61, a:modint61): modint61 {.discardable.} = self *= a.inv()
  proc `+`*(self, p: modint61):modint61 = self.dup(+= p)
  proc `-`*(self, p: modint61):modint61 = self.dup(-= p)
  proc `*`*(self, p: modint61):modint61 = self.dup(*= p)
  proc `/`*(self, p: modint61):modint61 = self.dup(/= p)
  proc `<`*(a, b: modint61):bool = a.val < b.val
  proc `==`*(a, b: modint61):bool = a.val == b.val
  proc `!=`*(a, b: modint61):bool = a.val != b.val
  proc pow*(self: modint61, n:int): modint61 =
    assert n >= 0
    result.val = 1
    var
      n = n
      mul = self
    while n > 0:
      if (n and 1) != 0: result *= mul
      mul *= mul; n = n shr 1
  proc `$`*(self: modint61):string = $(self.val)

