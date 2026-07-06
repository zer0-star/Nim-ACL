# run_length_compress

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/string/run_length_compress

## 公開 API

    const ATCODER_RUN_LENGTH_COMPRESS_HPP* = 1
    proc encode*(s:string):seq[tuple[c:char, n:int]] =
    proc decode*(a:seq[tuple[c:char, n:int]]):string =
    proc encode*[T](s:seq[T]):seq[tuple[c:T, n:int]] =
    proc decode*[T](a:seq[tuple[c:T, n:int]]):seq[T] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
