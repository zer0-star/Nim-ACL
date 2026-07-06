# fft2d

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/fft2d

## 公開 API

    const ATCODER_FFT2d_HPP* = 1
    proc fft2d*[mint](a: var seq[FormalPowerSeries[mint]]) =
    proc ifft2d*[mint](a: var seq[FormalPowerSeries[mint]]) =
    proc multiply2d_naive*[mint](a, b: fps2d[mint]): fps2d[mint] =
    proc multiply2d_partially_naive*[mint](a, b: fps2d[mint]):fps2d[mint] =
    proc multiply2d*[mint](a, b: fps2d[mint]):fps2d[mint] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
