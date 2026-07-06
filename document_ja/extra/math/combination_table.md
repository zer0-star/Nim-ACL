# combination_table

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/combination_table

## 公開 API

    const ATCODER_EXTRA_MATH_COMBINATION_TABLE_HPP* = 1
    type Combination*[T:RingElem] = object
    type CombinationC* = concept x
    template zero*(T:typedesc[RingElem]):T = T(0)
    template zero*[T:RingElem](cmb:Combination[T]):T = T(0)
    template fact*(T:CombinationC, k:int):auto =
    template resetCombination*(T:typedesc[RingElem] or var Combination) =
    template C_impl*(C:CombinationC, n, r:int):auto =
    template C*(T:CombinationC, n,r:int):auto =
    template H*(T:CombinationC, n,r:int):auto =
    template P*(T:CombinationC, n,r:int):auto =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
