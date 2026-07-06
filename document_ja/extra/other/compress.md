# compress

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/compress

## 公開 API

    const ATCODER_COMPRESS_HPP* = 1
    proc build*[T](v:var Compress[T]) =
    proc initCompress*[T](a:varargs[seq[T]]):Compress[T] =
    proc id*[T](c:Compress[T], a:T):int =
    proc `{}`*[T](c:Compress[T], a:T):int = c.id(a)
    proc val*[T](c:Compress[T], i:int):T = c[i]

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
