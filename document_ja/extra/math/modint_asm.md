# modint_asm

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/modint_asm

## 公開 API

    const ATCODER_MODINT_ASM_HPP* = 1
    type ModInt*[Mod: static[int]] = object
    proc initModInt*(a:SomeInteger, Mod:static[int]):ModInt[Mod] =
    macro declareModInt*(Mod:static[int], t: untyped):untyped =
    type {t.repr}* = ModInt[{Mod.repr}]
    proc init{t.repr}*(a:SomeInteger):{t.repr} = initModInt(a, {Mod.repr})
    converter to{t.repr}*(a:SomeInteger):{t.repr} = initModInt(a, {Mod.repr})
    type DMint* = object
    proc setModSub*(self:typedesc[not ModInt], m:int = -1, update = false):int32 =
    proc fastMod*(a:int,m:uint32):uint32{.inline.} =
    proc initDMint*(a:SomeInteger, Mod:int):DMint =
    proc getMod*[T:not ModInt](self: T):int32 = T.type.setModSub()
    proc getMod*(self: typedesc[not ModInt]):int32 = self.setModSub()
    proc setMod*(self: typedesc[not ModInt], m:int) = discard self.setModSub(m, update = true)
    type ModIntC* = concept x, type T
    type SomeIntC* = concept x
    proc Identity*(self:ModIntC):auto = result = self;result.v = 1
    proc init*[Mod:static[int]](self:ModInt[Mod], a:SomeIntC):ModInt[Mod] =
    proc init*(self:ModIntC and not ModInt, a:SomeIntC):auto =
    macro declareDMintConverter*(tt:untyped) =
    converter to{t.repr}*(a:SomeInteger):{t.repr} =
    macro declareDMint*(tt:untyped) =
    proc `*=`*(self:var ModIntC, a:SomeIntC) =
    proc `==`*(a:ModIntC, b:SomeIntC):bool = a.v == a.init(b).v
    proc `!=`*(a:ModIntC, b:SomeIntC):bool = a.v != a.init(b).v
    proc `-`*(self:ModIntC):auto =
    proc `$`*(a:ModIntC):string = return $(a.v)
    proc `+=`*(self:var ModIntC; a:SomeIntC) =
    proc `-=`*(self:var ModIntC, a:SomeIntC) =
    proc `^=`*(self:var ModIntC, n:SomeInteger) =
    proc inv*(self: ModIntC):auto =
    proc `/=`*(a:var ModIntC,b:SomeIntC) = a *= a.init(b).inv()
    proc `+`*(a:ModIntC,b:SomeIntC):auto = result = a;result += b
    proc `-`*(a:ModIntC,b:SomeIntC):auto = result = a;result -= b
    proc `*`*(a:ModIntC,b:SomeIntC):auto = result = a;result *= b
    proc `/`*(a:ModIntC,b:SomeIntC):auto = result = a;result /= b
    proc `^`*(a:ModIntC,b:SomeInteger):auto = result = a;result ^= b

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
