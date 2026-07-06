# modint_montgomery

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/modint_montgomery

## 公開 API

    const ATCODER_MONTGOMERY_MODINT_HPP* = 1
    type StaticLazyMontgomeryModInt*[M:static[uint32]] = object
    type DynamicLazyMontgomeryModInt*[T:static[int]] = object
    proc isStaticModInt*(T:typedesc[LazyMontgomeryModInt]):bool = T is StaticLazyMontgomeryModInt
    proc isDynamicModInt*(T:typedesc[LazyMontgomeryModInt]):bool = T is DynamicLazyMontgomeryModInt
    proc isStatic*(T:typedesc[LazyMontgomeryModInt]):bool = T is StaticLazyMontgomeryModInt
    proc get_r*(M:uint32):auto =
    proc get_n2*(M:uint32):auto = (((not M.uint) + 1.uint) mod M.uint).uint32
    proc getParameters*[T:static[int]](t:typedesc[DynamicLazyMontgomeryModInt[T]]):ptr[tuple[M, r, n2:uint32]] =
    proc setMod*[T:static[int]](self:typedesc[DynamicLazyMontgomeryModInt[T]], M:SomeInteger) =
    template getMod*[T:StaticLazyMontgomeryModInt](self:T or typedesc[T]):uint32 = T.M.uint32
    template getMod*[T:static[int]](self:typedesc[DynamicLazyMontgomeryModInt[T]] or DynamicLazyMontgomeryModInt[T]):uint32 =
    template `mod`*[T:LazyMontgomeryModInt](self:T or typedesc[T]):int = T.get_mod.int
    proc init*[T:LazyMontgomeryModInt](t:typedesc[T], b:T or SomeInteger):auto {.inline.} =
    proc unit*[T:LazyMontgomeryModInt](t:typedesc[T] or T):T = T.init(1)
    proc val*[T:LazyMontgomeryModInt](self: T):int =
    proc `+=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    proc `-=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    proc inc*[T:LazyMontgomeryModInt](self: var T):T {.discardable, inline.} =
    proc dec*[T:LazyMontgomeryModInt](self: var T):T {.discardable, inline.} =
    proc `*=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    proc inv*[T:LazyMontgomeryModInt](self: T):T = self.pow(T.mod - 2)
    proc `/=`*[T:LazyMontgomeryModInt](self: var T, b:T):T {.discardable, inline.} =
    proc `$`*(m: LazyMontgomeryModInt): string {.inline.} = $(m.val())
    proc `-`*[T:LazyMontgomeryModInt](self:T):T = T.init(0) - self
    template useStaticMontgomery*(name, M) =
    template useDynamicMontgomery*(name, M) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
