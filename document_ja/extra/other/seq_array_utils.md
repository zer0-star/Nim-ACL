# seq_array_utils

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/seq_array_utils

## 公開 API

    const ATCODER_EXTRA_OTHER_SEQ_ARRAY_UTILS_HPP* = 1
    template fill*[T](a:var T, init:untyped) =
    template makeSeq*(x:int; init):auto =
    template makeArray*(x:int or Slice[int]; init):auto =
    macro `[]`*(x:ArrayType or SeqType, args:varargs[untyped]):auto =
    macro `@`*(n: untyped, a:untyped):auto =
    proc `@`*[T](a:typedesc[T]):seq[T] =
    macro `@@`*(n: untyped, a:untyped):auto =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
