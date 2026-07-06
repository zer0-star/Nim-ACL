# monoid

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/monoid/monoid

## 公開 API

    const ATCODER_EXTRA_MONOID_MONOID_HPP* = 1
    type Monoid* = concept C, type T
    type InversibleMonoid* = concept C, type T
    type ActedMonoid* = concept C, type T
    type MonoidBase*[E; op:static[proc], e:static[proc], inv:static[proc or bool]] = object
    template MonoidType*(E:typedesc, op0, e0: untyped, inv0: untyped):typedesc[MonoidBase] =
    template MonoidType*(E:typedesc, op0, e0: untyped):typedesc[MonoidBase] =
    template value_type*[T:MonoidBase](_: typedesc[T]):typedesc = T.E
    type ActedMonoidBase*[MS, MF; p:static[tuple]] = object
    template ActedMonoidType*(MS, MF: typedesc, mapping0: untyped):typedesc[ActedMonoidBase] =
    template S*[T:ActedMonoidBase](_: typedesc[T]):typedesc = T.MS.value_type
    template F*[T:ActedMonoidBase](_: typedesc[T]):typedesc = T.MF.value_type
    proc op*[T:ActedMonoidBase](_:typedesc[T], a, b:T.S):T.S = T.MS.op(a, b)
    proc e*[T:ActedMonoidBase](_:typedesc[T]):T.S = T.MS.e()
    proc composition*[T:ActedMonoidBase](_:typedesc[T], a, b:T.F):T.F = T.MF.op(a, b)
    proc id*[T:ActedMonoidBase](_:typedesc[T]):T.F = T.MF.e()
    proc mapping*[T:ActedMonoidBase](_:typedesc[T], f:T.F, s:T.S):T.S = T.p[0](f, s)

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
