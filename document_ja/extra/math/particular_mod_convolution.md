# particular_mod_convolution

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/particular_mod_convolution

## 公開 API

    const ATCODER_PARTICULAR_MOD_CONVOLUTION* = 1
    type ParticularModConvolution* = object
    proc fft*[T:FiniteFieldElem](t:typedesc[ParticularModConvolution], a:seq[T]):seq[T] {.inline.} =
    proc inplace_fft*[T:FiniteFieldElem](t:typedesc[ParticularModConvolution], a:var seq[T]) {.inline.} =
    proc inplace_partial_dot*[T](t:typedesc[ParticularModConvolution], a:var seq[T], b:seq[T], p:Slice[int]) =
    proc dot*[T](t:typedesc[ParticularModConvolution], a, b:seq[T]):seq[T] =
    proc ifft*[T](t:typedesc[ParticularModConvolution], a:seq[T]):seq[T] {.inline.} =
    proc inplace_ifft*[T](t:typedesc[ParticularModConvolution], a:var seq[T]) {.inline.} =
    proc convolution*[T:FiniteFieldElem](t:typedesc[ParticularModConvolution], a, b:seq[T]):auto {.inline.} = convolution(a, b)
    proc ntt_doubling*[T](t:typedesc[ParticularModConvolution], a:var seq[T]) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
