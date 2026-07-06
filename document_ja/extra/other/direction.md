# direction

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/direction

## 公開 API

    const ATCODER_DIRECTION* = 1
    let dir4* = [(1, 0), (0, 1), (-1, 0), (0, -1)]
    let dir8* = [(1, 0), (1, 1), (0, 1), (-1, 1), (-1, 0), (-1, -1), (0, -1), (1, -1)]
    iterator neighbor*(p:(int, int), d:openArray[(int, int)]):(int, int) =
    iterator neighbor*(p:(int, int), d:openArray[(int, int)], limit:(Slice[int], Slice[int])):(int, int) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
