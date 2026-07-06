# bitset

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/bitset

## 公開 API

    const ATCODER_BITSET_HPP* = 1
    type BitSet*[N:static[int]] = object
    var initBitSet*: initBitSetType
    template `[]`*(t:initBitSetType, N:static[int]):auto =
    proc `()`*[N:static[int]](self:initBitSetTypeN[N]):BitSet[N] =
    proc `()`*[N:static[int]](self:initBitSetTypeN[N], b:SomeInteger):BitSet[N] =
    proc initBitSet1*(N:static[int]): BitSet[N] =
    proc init*[N:static[int]](self: BitSet[N] or typedesc[BitSet[N]]):BitSet[N] = initBitSet[N]()
    proc init*[N:static[int]](self: BitSet[N] or typedesc[BitSet[N]], q:SomeInteger):BitSet[N] = initBitSet[N](q)
    proc init1*[N:static[int]](self: BitSet[N] or typedesc[BitSet[N]]):BitSet[N] = initBitSet1(N)
    proc getSize*[N:static[int]](self: BitSet[N] or typedesc[BitSet[N]]):int = N
    type DynamicBitSet* = object
    proc initDynamicBitSet*(N:int): DynamicBitSet =
    proc initDynamicBitSet1*(N:int): DynamicBitSet =
    proc init*(self: DynamicBitSet):DynamicBitSet = initDynamicBitSet(self.N)
    proc init1*(self: DynamicBitSet):DynamicBitSet = initDynamicBitSet1(self.N)
    proc getSize*(self: DynamicBitSet):int = self.N
    type SomeBitSet* = BitSet | DynamicBitSet
    proc toBin*(b:uint64, n: int): string =
    proc toStr*(a: SomeBitSet, n:int = -1):string =
    proc `not`*(a: SomeBitSet): auto =
    proc `or=`*[BS:SomeBitSet](a: var BS, b: BS): auto =
    proc `or`*(a, b: SomeBitSet): auto =
    proc `and=`*[BS:SomeBitSet](a: var BS, b: BS): auto =
    proc `and`*(a, b: SomeBitSet): auto =
    proc `xor=`*[BS:SomeBitSet](a: var BS, b: BS): auto =
    proc `xor`*(a, b: SomeBitSet): auto =
    proc any*(a: SomeBitSet): bool =
    proc all*(a: SomeBitSet): bool =
    proc count*(a: SomeBitSet): int =
    proc firstSetBit*(a: SomeBitSet):int =
    proc fastLog2*(a:SomeBitSet):int =
    proc `[]`*(b:SomeBitSet,n:int):int =
    proc `[]=`*(b:var SomeBitSet, n:int, t:int) =
    proc `shl`*(a: SomeBitSet, n:int): auto =
    proc `shr`*(a: SomeBitSet, n:int): auto = a shl (-n)
    proc `<`*(a, b:SomeBitSet):bool =
    proc `<=`*(a, b:SomeBitSet):bool =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
