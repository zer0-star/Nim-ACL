# reader

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/reader

## 公開 API

    const ATCODER_EXTRA_OTHER_READER_HPP* = 1
    proc nextString*(f:auto = stdin): string =
    proc nextInt*(f:auto = stdin): int = parseInt(f.nextString)
    proc nextFloat*(f:auto = stdin): float = parseFloat(f.nextString)
    proc toStr*[T](v:T):string =
    proc print0*(x: varargs[string, toStr]; sep:string):string{.discardable.} =
    var print*:proc(x: varargs[string, toStr]) print = proc(x: varargs[string, toStr]) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
