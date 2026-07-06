# solve_proc

このページは自動生成された下書きです。

公開 API と基本的な import パスを整理しています。詳細な説明、計算量、注意点、使用例は必要に応じて追記してください。

## import

    import atcoder/extra/other/solve_proc

## 公開 API

    const ATCODER_EXTRA_OTHER_SOLVE_PROC_HPP* = 1
    proc compare_answer_string*(s, t:string, error:float = NaN):bool =
    macro solveProc*(head, body:untyped):untyped =
    var naiveProcDef = newNimNode(nnkProcDef).add(newNimNode(nnkPostFix).add(ident"*").add(ident"solve_naive")).add(newEmptyNode()).add(newEmptyNode()).add(newNimNode(nnkFormalParams).add(mainParams.copy())).add(discardablePragma).add(newEmptyNode()).add(newEmptyNode())
    proc `procName`*():string {.discardable.} =

## 概要

TODO: このライブラリの用途と使いどころを記述してください。

## 使用例

TODO: 使用例を追加してください。

## 注意

TODO: 制約、前提条件、落とし穴を記述してください。
