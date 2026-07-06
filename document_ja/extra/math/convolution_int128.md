# convolution_int128

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/convolution_int128

## 公開 API

    const ATCODER_EXTRA_CONVOLUTION128_HPP* = 1
    proc convolution_int128*[T:SomeInteger](a, b:seq[T]):seq[Int128] =
    let offset = [Int128(0), Int128(0), M1M2M3, M1M2M3 * Int128(2), M1M2M3 * Int128(3)]

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
