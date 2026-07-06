# cumulative_sum

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/dp/cumulative_sum

## 公開 API

    const ATCODER_CUMULATIVE_SUM_HPP* = 1
    type CumulativeSum*[T; reverse:static[bool]] = object
    proc initCumulativeSum*[T](n:int):CumulativeSum[T, false] =
    proc initCumulativeSumReverse*[T](n:int):CumulativeSum[T, true] =
    proc initCumulativeSum*[T](v:seq[T]):CumulativeSum[T, false] =
    proc initCumulativeSumReverse*[T](v:seq[T]):CumulativeSum[T, true] =
    proc `[]=`*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse], k:IndexType, x:T) =
    proc add*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse], k:IndexType, x:T) =
    proc propagate*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse]) =
    proc sum*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse], k:int):T =
    proc `[]`*[T;reverse:static[bool]](self: var CumulativeSum[T, reverse], s:RangeType):T =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
