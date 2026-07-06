# floor_sum_general

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/math/floor_sum_general

## 公開 API

    const ATCODER_FLOOR_SUM_GENERAL_HPP* = 1
    proc monoid_pow*[Monoid, U](x: Monoid, exp: U): Monoid =
    proc floor_monoid_product*[Monoid; X, U](x, y: X, N, a, b, m:U):X =
    let d = (m * c - b - 1) div a + 1
    type MonoidForFloorSum*[T; K1, K2: static[int]] = object
    proc op*[CLASS: MonoidForFloorSum](class: typedesc[CLASS], a, b: CLASS):CLASS =
    proc unit*[CLASS: MonoidForFloorSum](class: typedesc[CLASS]): CLASS =
    proc to_x*[CLASS: MonoidForFloorSum](class: typedesc[CLASS]):CLASS =
    proc to_y*[CLASS: MonoidForFloorSum](class: typedesc[CLASS]):CLASS =
    proc floor_sum_of_linear_polynomial_nonnegative*[T;K1, K2: static[int]; U](N, a, b, md: U): array[K1 + 1, array[K2 + 1, T]] =
    proc floor_sum_of_linear_polynomial*[T;K1, K2: static[int];I](rg: Slice[I], a, b, md: I): array[K1 + 1, array[K2 + 1, T]] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
