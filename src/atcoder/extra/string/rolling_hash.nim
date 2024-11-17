when not declared ATCODER_ROLLING_HASH_HPP:
  const ATCODER_ROLLING_HASH_HPP* = 1
  import std/sequtils
  import atcoder/rangeutils
  
  template MASK*(n:static[int]):auto = (1'u shl n.uint) - 1
  
  const base0* = 1000000007'u
  
  type RH_Base*[Mod:static[uint], base:static[uint]] = object
    h* :uint
    len* :int
  
  type RH* = RH_Base[(1'u shl 61) - 1, base0]
  
  converter toRH*(t:SomeInteger or char):RH = RH(h:t.uint, len: 1)
 
  proc multRaw*(a, b:uint):uint =
    let
      au = a shr 31
      ad = a and MASK(31)
      bu = b shr 31
      bd = b and MASK(31)
      mid = ad * bu + au * bd
      midu = mid shr 30
      midd = mid and MASK(30)
    au * bu * 2 + midu + (midd shl 31) + ad * bd
  
  proc calcMod*(x:uint):uint =
    let
      xu = x shr 61
      xd = x and MASK(61)
    result = xu + xd
    if result >= RH.Mod: result -= RH.Mod
  
  proc `*=`*(a: var RH, b:uint) =  a.h = calcMod(multRaw(a.h, b))
  proc `*`*(a:RH, b:uint):RH = result = a;result *= b
  proc `==`*(a, b:RH):bool = a.h == b.h and a.len == b.len
  proc `+=`*(a:var RH, b:uint) =
    a.h += b
    if a.h >= RH.Mod: a.h -= RH.Mod
  proc `+`*(a:RH, b:uint):RH = result = a;result += b
  proc `-=`*(a:var RH, b:uint) =
    a.h += RH.Mod - b
    if a.h >= RH.Mod: a.h -= RH.Mod
  proc `-`*(a:RH, b:uint):RH = result = a;result -= b
  proc `&=`*(a:var RH, c:int or char) =
    a.h = multRaw(a.h, RH.base)
    a.h += RH(c).h
    a.h = calcMod(a.h)
    a.len.inc
  proc `&`*(a:RH, c:int or char):RH = result = a;result &= c

  converter toRH*(s:string):RH =
    result = RH(h: 0, len: 0)
    for i in 0 ..< s.len:
      result &= s[i]

  proc calcPow*[T: RH_Base](n:int):uint =
    var powData {.global.} = @[1'u]
    # n < powData.lenにしたい
    while n >= powData.len:
      powData.add calcMod(multRaw(powData[^1], T.base))
    return powData[n]

  proc `&`*(h1, h2:RH):RH =
    let h2len = h2.len
    result.h = calcMod(multRaw(h1.h, calcPow[RH](h2len)) + h2.h)
    result.len = h1.len + h2.len

  import hashes
  proc hash*(a:RH):Hash = a.h.hash
  
  type RollingHash*[RH] = object
    len*: int
    hashed: seq[RH]
  
  proc initRollingHash*(s:string):auto =
    var
      sz = s.len
      hashed = newSeqWith(sz + 1, RH(0))
    for i in 0..<sz:
      #hashed[i + 1] = calcMod(multRaw(hashed[i], RH.base) + RH(s[i]))
      hashed[i + 1] = hashed[i] & s[i]
  #    if hashed[i + 1] >= MOD: hashed[i + 1] -= MOD
    return RollingHash[RH](hashed: hashed, len: sz)
  
  proc `[]`*(self: RollingHash; s:RangeType):RH =
    let (l, r) = self.halfOpenEndpoints(s)
    result.h = self.hashed[r].h + (RH.MOD shl 2) - multRaw(self.hashed[l].h, calcPow[RH](r - l))
    result.h = result.h.calcMod()
    result.len = r - l

  proc LCP*(self, b:RollingHash; p1, p2:RangeType):int =
    let
      (l1, r1) = self.halfOpenEndpoints(p1)
      (l2, r2) = b.halfOpenEndpoints(p2)
    var
      low = -1
      high = min(r1 - l1, r2 - l2) + 1
    while high - low > 1:
      let mid = (low + high) div 2
      if self[l1 ..< l1 + mid] == b[l2 ..< l2 + mid]: low = mid
      else: high = mid
    return low
