# ntt

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/ntt

## 公開 API

    const ATCODER_NTT_HPP* = 1
    template get_fft_type*[T:FiniteFieldElem](self: typedesc[T]):typedesc =
    proc fft*[T:FiniteFieldElem](a:seq[T]):auto =
    proc ifft*(a:auto, T:typedesc[FiniteFieldElem]):auto =
    proc dot*(a, b:auto, T:typedesc[FiniteFieldElem]):auto = # TODO: このdotがorcでばぐる特にaを変数ではなくfft(f)みたいに関数で読んだ場合
    proc inplace_partial_dot*(a:var auto, b:auto, p:Slice[int], T:typedesc[FiniteFieldElem]) =
    proc multiply*[T:FiniteFieldElem](a, b:seq[T]):seq[T] =
    proc fft_doubling*[T: FiniteFieldElem](a: seq[T]):seq[T] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
