# bigint

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/bigint

## 公開 API

    const ATCODER_MULTIPRECISION_HPP* = 1
    type bigint* = object
    proc initbigint*(): bigint =
    proc initbigint*(n:bool, d:seq[int32]): bigint =
    proc initbigint*(x:SomeInteger): bigint =
    proc initbigint*(S:string):bigint =
    converter toBigInt*(x: SomeInteger): bigint = initbigint(x)
    converter toBigInt*(S: string): bigint = initbigint(S)
    proc size*(a:bigint):int = a.dat.len
    proc `+`*(lhs, rhs: bigint): bigint =
    proc `-`*(a: bigint):bigint =
    proc `-`*(lhs, rhs: bigint):bigint = return lhs + (-rhs)
    proc inner_mul_fft*(a, b: seq[int32]):seq[int32] =
    proc inner_mul_naive*(a, b: seq[int32]):seq[int32] =
    let p = int(a[i]) * int(b[j])
    proc inner_mul*(a, b: seq[int32]): seq[int32] =
    proc `*`*(lhs, rhs: bigint):bigint =
    proc divmod*(lhs, rhs:bigint):tuple[d, m: bigint] =
    proc `div`*(lhs, rhs: bigint):bigint = return divmod(lhs, rhs)[0]
    proc `mod`*(lhs, rhs: bigint):bigint = return divmod(lhs, rhs)[1]
    proc `+=`*(this: var bigint, rhs: bigint) = this = this + rhs
    proc `-=`*(this: var bigint, rhs: bigint) = this = this - rhs
    proc `*=`*(this: var bigint, rhs: bigint) = this = this * rhs
    proc `div=`*(this: var bigint, rhs: bigint) = this = this div rhs
    proc `mod=`*(this: var bigint, rhs: bigint) = this = this mod rhs
    proc `+`*(this: bigint):bigint = this
    proc abs*(m: bigint):bigint = result = m;result.neg = false
    proc `==`*(lhs, rhs:bigint):bool =
    proc `!=`*(lhs, rhs:bigint):bool =
    proc `<`*(lhs, rhs: bigint):bool =
    proc `<=`*(lhs, rhs: bigint):bool =
    proc `>`*(lhs, rhs: bigint):bool =
    proc `>=`*(lhs, rhs: bigint):bool =
    proc `$`*(self: bigint):string =
    proc to_int*(self: bigint):int =
    proc to_i128*(self: bigint): Int128 =
    proc nextBigInt*():bigint =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
