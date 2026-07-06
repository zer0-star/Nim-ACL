# convolution_universal

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/convolution_universal

## 公開 API

    const ATCODER_CONVOLUTION_UNIVERSAL_HPP* = 1
    type fft_info*[mint:FiniteFieldElem; rank2:static[int]] = object
    proc initFFTInfo*[mint:FiniteFieldElem]():auto =
    proc butterfly*[mint:FiniteFieldElem](a:var seq[mint]) =
    var len = 0 # a[i, i+(n>>len), i+2*(n>>len), ..] is transformed
    let r = a[i + offset + p] * rot
    proc butterfly_inv*[mint:FiniteFieldElem](a:var seq[mint]) =
    var len = h; # a[i, i+(n>>len), i+2*(n>>len), ..] is transformed
    proc convolution_naive*[mint:FiniteFieldElem](a, b:seq[mint]):seq[mint] =
    proc convolution_fft*[mint:FiniteFieldElem](a, b:seq[mint]):seq[mint] =
    proc convolution*[mint:FiniteFieldElem](a, b:seq[mint]):seq[mint] =
    proc convolution*[T:SomeInteger](a, b:seq[T], M:static[uint] = 998244353):seq[T] =
    proc convolution_ll*(a, b:seq[int]):seq[int] =
    const offset = [0'u, 0'u, M1M2M3, 2'u * M1M2M3, 3'u * M1M2M3]

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
