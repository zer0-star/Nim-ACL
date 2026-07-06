# modint61

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/modint61

## 公開 API

    const ATCODER_MODINT61_HPP* = 1
    type modint61* = object
    proc init*(_: typedesc[modint61], x:uint32):modint61 = modint61(val: x)
    proc init*(_: typedesc[modint61], x:uint64):modint61 = modint61(val: x mod MOD)
    proc init*(_: typedesc[modint61], x:int32):modint61 =
    proc init*(_: typedesc[modint61], x:int):modint61 =
    proc getMod*(_: modint61 or typedesc[modint61]): uint = MOD
    proc `+=`*(self: var modint61, a: modint61):modint61 {.discardable.} =
    proc `-=`*(self: var modint61, a: modint61):modint61 {.discardable.} =
    proc `*=`*(self: var modint61, a: modint61): modint61 {.discardable.} =
    let y = Uint128(self.val) * a.val;
    proc `-`*(self: modint61):modint61 = modint61.init(if self.val != 0: MOD - self.val else: uint(0))
    proc inv*(self: modint61):modint61 =
    proc `/=`*(self: var modint61, a:modint61): modint61 {.discardable.} = self *= a.inv()
    proc `+`*(self, p: modint61):modint61 = self.dup(+= p)
    proc `-`*(self, p: modint61):modint61 = self.dup(-= p)
    proc `*`*(self, p: modint61):modint61 = self.dup(*= p)
    proc `/`*(self, p: modint61):modint61 = self.dup(/= p)
    proc `<`*(a, b: modint61):bool = a.val < b.val
    proc `==`*(a, b: modint61):bool = a.val == b.val
    proc `!=`*(a, b: modint61):bool = a.val != b.val
    proc pow*(self: modint61, n:int): modint61 =
    proc `$`*(self: modint61):string = $(self.val)

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
