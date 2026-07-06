# arbitrary_mod_convolution

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/arbitrary_mod_convolution

## 公開 API

    const ATCODER_ARBITRARY_MOD_CONVOLUTION* = 1
    type ArbitraryModConvolution* = object
    type ArbitraryModFFTElem* = (mint0, mint1, mint2)
    proc setLen*(v:var (seq[mint0], seq[mint1], seq[mint2]), n:int) =
    proc `*=`(a:var ArbitraryModFFTElem, b:ArbitraryModFFTElem) =
    proc fft*[T:ModInt](t:typedesc[ArbitraryModConvolution], a:seq[T]):auto {.inline.} =
    proc inplace_partial_dot*(t:typedesc[ArbitraryModConvolution], a:var (seq[mint0], seq[mint1], seq[mint2]), b:(seq[mint0], seq[mint1], seq[mint2]), p:Slice[int]):auto =
    proc dot*(t:typedesc[ArbitraryModConvolution], a, b:(seq[mint0], seq[mint1], seq[mint2])):auto =
    proc ifft*[T:ModInt](t:typedesc[ArbitraryModConvolution], a:(seq[mint0], seq[mint1], seq[mint2]), deg = -1):auto {.inline.} =
    proc convolution*[T:ModInt](t:typedesc[ArbitraryModConvolution], a, b:seq[T]):seq[T] {.inline.} =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
