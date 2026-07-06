# element_concepts

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/element_concepts

## 公開 API

    const ATCODER_ELEMENT_CONCEPTS_HPP* = 1
    proc inv*[T:SomeFloat](a:T):auto = T(1) / a
    proc init*(self:typedesc[SomeFloat], a:SomeNumber):auto = self(a)
    type HasInitInt* = concept x, type T
    type HasIntConverter* = concept x, type T
    type AdditiveGroupElem* = concept x, y, type T
    type MultiplicativeGroupElem* = concept x, y, type T
    type RingElem* = concept x, y, type T
    type FieldElem* = concept x, y, type T
    type FiniteFieldElem* = concept x, type T
    type hasInf* = concept x, type T

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
