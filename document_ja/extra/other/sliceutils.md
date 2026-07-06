# sliceutils

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/sliceutils

## 公開 API

    const ATCODER_EXTRA_OTHER_SLICEUTILS_HPP* = 1
    proc index*[T](a:openArray[T]):Slice[int] =
    proc rev*[T](p:Slice[T]):ReversedSlice[T] = ReversedSlice[T](p)
    iterator items*(n:int):int = (for i in 0..<n: yield i)
    iterator items*[T](p:ReversedSlice[T]):T =
    proc `>>`*[T](s:Slice[T], d:T):StepSlice[T] =
    proc `<<`*[T](s:Slice[T], d:T):StepSlice[T] =
    proc low*[T](s:StepSlice[T]):T = s.s.a
    proc high*[T](s:StepSlice[T]):T =
    iterator items*[T](p:StepSlice[T]):T =
    proc `[]`*[T:SomeInteger, U](a:openArray[U], s:Slice[T]):seq[U] =
    proc `[]=`*[T:SomeInteger, U](a:var openArray[U], s:StepSlice[T], b:openArray[U]) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
