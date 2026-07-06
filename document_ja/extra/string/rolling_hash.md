# rolling_hash

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/string/rolling_hash

## 公開 API

    const ATCODER_EXTRA_STRING_ROLLING_HASH_HPP* = 1
    template MASK*(n:static[int]):auto = (1'u shl n.uint) - 1
    type RH_Base* = distinct uint
    proc multRaw*[RH: RH_Base](a, b:RH):RH =
    proc calcMod*[RH: RH_Base](x:RH):RH =
    proc `*=`*[RH: RH_Base](a: var RH, b:RH) = a = calcMod(multRaw(a, b))
    proc `*`*[RH: RH_Base](a, b:RH):RH = result = a;result *= b
    proc `==`*[RH: RH_Base](a, b:RH):bool = a.uint == b.uint
    proc `+=`*[RH: RH_Base](a:var RH, b:RH) =
    proc `+`*[RH: RH_Base](a, b:RH):RH = result = a;result += b
    proc `-=`*[RH: RH_Base](a:var RH, b:RH) =
    proc `-`*[RH: RH_Base](a, b:RH):RH = result = a;result -= b
    proc `$`*[RH: RH_Base](a: RH):string =
    proc hash*[RH: RH_Base](a:RH):Hash = a.h.hash
    type RollingHash*[base: static[uint]] = object
    proc initRollingHash*(s:string, base: static[uint] = 1000000007'u):auto =
    type PartialRollingHash*[base: static[uint]] = object
    proc `==`*(a, b: PartialRollingHash): bool =
    proc `[]`*(self: RollingHash; s:RangeType):PartialRollingHash[RollingHash.base] =
    proc `&`*[T: PartialRollingHash](h1, h2: T):T =
    proc `&=`*(a:var PartialRollingHash, c:SomeInteger or char) =
    proc `&`*(a:PartialRollingHash, c:SomeInteger or char):PartialRollingHash = result = a;result &= c
    proc `&`*(c:SomeInteger or char, a:PartialRollingHash):PartialRollingHash =
    proc `&`*(a:PartialRollingHash, c:string):PartialRollingHash = a & initRollingHash(c)[0 .. ^1]
    proc `&`*(c:string, a:PartialRollingHash):PartialRollingHash = initRollingHash(c)[0 .. ^1] & a
    proc LCP*(self, b:RollingHash; p1, p2:RangeType):int =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
