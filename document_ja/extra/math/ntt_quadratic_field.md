# ntt_quadratic_field

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/ntt_quadratic_field

## 公開 API

    const ATCODER_NTT_QUADRATIC_FIELD_HPP* = 1
    proc inplace_fft*[T: QF](a: var seq[T]) =
    proc fft*[T:QF](a:seq[T]):seq[T] =
    proc inplace_ifft*[T: QF](a: var seq[T]) =
    proc ifft*[T: QF](a:seq[T], td:typedesc[T]):auto =
    proc dot*(a, b:auto, T:typedesc[FiniteFieldElem]):auto = # TODO: このdotがorcでばぐる特にaを変数ではなくfft(f)みたいに関数で読んだ場合
    proc inplace_partial_dot*(a:var auto, b:auto, p:Slice[int], T:typedesc[FiniteFieldElem]) =
    proc multiply_fft*[T:QF](a, b:seq[T]):seq[T] =
    proc multiply_naive*[T:QF](a, b:seq[T]):seq[T] =
    proc multiply*[T:QF](a, b:seq[T]):seq[T] =
    proc inplace_fft_doubling*[T:QF](a:var seq[T]) =
    proc fft_doubling*[T:QF](a:seq[T]):seq[T] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
