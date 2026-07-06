# operator

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/operator

## 公開 API

    const ATCODER_OPERATOR_HPP* = 1
    macro getOperator*(head:typedesc, body: untyped):untyped =
    type OperatorType*[hZ, Z, hU, U, hA, A, hS, S, hM, M, hD, D, hIZ, IZ] = tuple[
    template zero*(p: OperatorType):auto =
    template unit*(p: OperatorType):auto =
    template add*[T](p: OperatorType, a, b:T):T =
    template subt*[T](p: OperatorType, a, b:T):T =
    template mult*[T](p: OperatorType, a, b:T):T =
    template `div`*[T](p: OperatorType, a, b:T):T =
    template isZero*[T](p: OperatorType, a:T):bool =
    template getDefaultOperator*(T:typedesc):tuple =
    proc mult(a, b:T):T = a * b
    template getDefaultOperator*(T:typedesc; z, u:T):tuple =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
