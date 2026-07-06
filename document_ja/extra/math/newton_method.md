# newton_method

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/newton_method

## 公開 API

    const ATCODER_EXTRA_NEWTON_METHOD_HPP* = 1
    proc newtonMethod*[mint](calc_g: proc(F:FormalPowerSeries[mint], d:int):tuple[g, dgdf: FormalPowerSeries[mint]], f0:mint, deg:int):FormalPowerSeries[mint] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
