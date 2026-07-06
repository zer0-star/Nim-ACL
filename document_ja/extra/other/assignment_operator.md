# assignment_operator

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/assignment_operator

## 公開 API

    const ATCODER_EXTRA_OTHER_ASSIGNMENT_OPERATOR_HPP* = 1
    proc `max=`*[S, T](a: var S, b: T):bool {.discardable.} =
    proc `min=`*[S, T](a: var S, b: T):bool {.discardable.} =
    template `>?=`*(x,y:typed):bool = x.max= y
    template `<?=`*(x,y:typed):bool = x.min= y
    proc `//`*[T:SomeInteger](x,y:T):T = x div y
    proc `%`*[T:SomeInteger](x,y:T):T = x mod y
    macro generateAssignmentOperator*(ops:varargs[untyped]) =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
