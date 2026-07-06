# algorithmutils

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/algorithmutils

## 公開 API

    const ATCODER_ALGORITHM_UTILS_HPP* = 1
    iterator permutation*[T](v:seq[T]):seq[T] =
    iterator combination*[T](v:seq[T], r:int):seq[T] =
    proc copy*[T](a:seq[T], p:Slice[int], b:var seq[T], i = 0) =
    proc reverse*[T](a:var seq[T], p:Slice[int]) = a.reverse(p.a, p.b)
    proc nth_element*[T](a:var openArray[T], first, nth, last: int, comp:proc(a, b:T):bool = (proc(a, b:T):bool = a < b)) =
    proc nth_element*[T](a:var openArray[T], nth: int, comp:proc(a, b:T):bool = (proc(a, b:T):bool = a < b)) =
    proc setUnion*[T](u, v: seq[T]):seq[T] =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
